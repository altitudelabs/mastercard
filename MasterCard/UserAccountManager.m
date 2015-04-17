//
//  RegistrationManager.m
//  MasterCard
//
//  Created by Altitude Labs on 16/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "UserAccountManager.h"
#import "DeviceHelper.h"

NSString* const KeyUserAccountArray = @"KeyUserAccountArray";
NSString* const KeyUserNameForAutoLogin = @"KeyUserNameForAutoLogin";

NSString* const KeyUserEmail = @"KeyUserEmail";
NSString* const KeyUserpassword = @"KeyUserpassword";
NSString* const KeyUserName = @"KeyUserName";
NSString* const KeyUserCompany = @"KeyUserCompany";
NSString* const KeyUserPhoneNumber = @"KeyUserPhoneNumber";
NSString* const KeyUserAddress = @"KeyUserAddress";
NSString* const KeyUserBank = @"KeyUserBank";
NSString* const KeyUserBankAcctNumber = @"KeyUserBankAcctNumber";
NSString* const KeyUserCreditCardNumber = @"KeyUserCreditCardNumber";
NSString* const KeyuserExpiryDate = @"KeyuserExpiryDate";
NSString* const KeyUserCVCCode = @"KeyUserCVCCode";
NSString* const KeyUserProfileImage = @"KeyUserProfileImage";

@interface UserAccountManager ()

@end

@implementation UserAccountManager

+ (UserAccountManager *)sharedInstance {
    static UserAccountManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UserAccountManager alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.data = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - Public

- (void)replaceDataWithCurrentAccount:(NSString *)currentAccountUserName {
    NSArray *userAccounts = [self userAccountArrayFromPref];
    for (NSDictionary *userAccount in userAccounts) {
        if ([((NSString *)[userAccount objectForKey:KeyUserName]) isEqual:currentAccountUserName]) {
            self.data = [userAccount mutableCopy];
            break;
        }
    }
}

- (void)setAccountDataWithEmail:(NSString *)email password:(NSString *)password callback:(RegistrationResultCallback)resultCallback {
    int delayTime = arc4random() % 1 + 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delayTime * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        // Error
        if (![DeviceHelper isNetworkAvailable]) {
            resultCallback(NO, @"Please check internet connection and try again.");
            return;
        } else if (![self validateEmail:email]) {
            resultCallback(NO, @"Invalid email!");
            return;
        } else if ([self emailUsed:email]) {
            resultCallback(NO, @"This email has been registered!");
            return;
        } else if (password == nil || password.length < 6) {
            resultCallback(NO, @"Password need to be at least 6 characters!");
            return;
        }
        
        // Success
        [self.data setObject:email forKey:KeyUserEmail];
        [self.data setObject:password forKey:KeyUserpassword];
        resultCallback(YES, nil);
    });
}

- (void)setProfilePage:(UIImage *)profileImage userName:(NSString *)userName companyName:(NSString *)companyName phoneNumber:(NSString *)phoneNumber address:(NSString *)address callback:(RegistrationResultCallback) resultCallback {
    
    // Error
    if (userName == nil || userName.length == 0) {
        resultCallback(NO, @"User name cannot be empty!");
        return;
    } else if (companyName == nil || companyName.length == 0) {
        resultCallback(NO, @"Company name cannot be empty!");
        return;
    } else if (phoneNumber == nil || phoneNumber.length == 0) {
        resultCallback(NO, @"Phone number cannot be empty!");
        return;
    } else if (address == nil || address.length == 0) {
        resultCallback(NO, @"Address cannot be empty");
        return;
    }
    
    // Success
    [self.data setObject:userName forKey:KeyUserName];
    [self.data setObject:companyName forKey:KeyUserCompany];
    [self.data setObject:phoneNumber forKey:KeyUserPhoneNumber];
    [self.data setObject:address forKey:KeyUserAddress];
    
    // Optional
    if (profileImage) {
        [self setProfilePhotoForThisUser:profileImage];
    }
    
    resultCallback(YES, nil);
}

- (void)setBankName:(NSString *)bankName bankAccountNumber:(NSString *) bankAccountNumber creditCardNumber:(NSString *)creditCardNumber expiryDate:(NSString *)expiryDate cvcCode:(NSString *)cvcCode callback:(RegistrationResultCallback) resultCallback {
    
    // Success
    if ((bankName && bankName.length > 0) && (bankAccountNumber && bankAccountNumber.length > 0)) {
        [self.data setObject:bankName forKey:KeyUserBank];
        [self.data setObject:bankAccountNumber forKey:KeyUserBankAcctNumber];
        
        [self registerThisAccountWithCallback:^(BOOL success, NSString *error) {
            if (success) {
                [self setAutoLoginUser:[self.data objectForKey:KeyUserName]];
                resultCallback(YES, nil);
            } else {
                resultCallback(NO, error);
            }
        }];
        
    } else if ((creditCardNumber && creditCardNumber.length > 0) &&
               (expiryDate && expiryDate.length > 0) &&
               (cvcCode && cvcCode.length > 0)) {
        [self.data setObject:creditCardNumber forKey:KeyUserCreditCardNumber];
        [self.data setObject:expiryDate forKey:KeyuserExpiryDate];
        [self.data setObject:cvcCode forKey:KeyUserCVCCode];
        
        [self registerThisAccountWithCallback:^(BOOL success, NSString *error) {
            if (success) {
                [self setAutoLoginUser:[self.data objectForKey:KeyUserName]];
                resultCallback(YES, nil);
            } else {
                resultCallback(NO, error);
            }
        }];
        
    } else {
        // Error
        resultCallback(NO, @"Payment info is not complete.");
    }
}

- (void)registerThisAccountWithCallback:(RegistrationResultCallback) resultCallback {
    // Sleep for 1-2 seconds
    int delaySeconds = arc4random() % 2 + 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delaySeconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if ([DeviceHelper isNetworkAvailable]) {
            if ([self emailUsed:[self.data objectForKey:KeyUserEmail]]) {
                resultCallback(NO, @"This email has been registered.");
            } else {
                [self registerUserWithData:self.data];
                resultCallback(YES, nil);
            }
        } else {
            resultCallback(NO, @"Please check internet connection and try again.");
        }
    });
}

- (void)setProfilePhotoForThisUser:(UIImage *)profilePhoto {
    NSString *imageFilePath = [self saveImageToAppFolder:profilePhoto withName:[self.data objectForKey:KeyUserName]];
    [self.data setObject:imageFilePath forKey:KeyUserProfileImage];
}

- (void)commitChange {
    [self updateUserWithData:self.data];
}

- (void)loginWithUserName:(NSString *)userName callback:(LoginCallback)callback {
    NSMutableArray *userAccounts = [self userAccountArrayFromPref];
    
    for (NSDictionary *userData in userAccounts) {
        NSString *nameInDict = [userData objectForKey:KeyUserName];
        if ([nameInDict isEqual:userName]) {
            self.data = [userData mutableCopy];
            [self setAutoLoginUser:userName];
            callback(YES, nil, userData);
            return;
        }
    }
    callback(NO, @"Incorrect username or password.", nil);
    return;
}

- (void)loginWithEmail:(NSString *)email password:(NSString *)password callback:(LoginCallback)callback {
    NSMutableArray *userAccounts = [self userAccountArrayFromPref];
    
    for (NSDictionary *userData in userAccounts) {
        NSString *emailInDict = [userData objectForKey:KeyUserEmail];
        if ([emailInDict isEqual:email]) {
            NSString *passwordInDict = [userData objectForKey:KeyUserpassword];
            if ([passwordInDict isEqual:password]) {
                self.data = [userData mutableCopy];
                [self setAutoLoginUser:[userData objectForKey:KeyUserName]];
                callback(YES, nil, userData);
                return;
            } else {
                callback(NO, @"Incorrect password.", nil);
                return;
            }
        }
    }
    callback(NO, @"Incorrect email or password.", nil); // Dictionary is empty
}

- (void)tryAutoLogin:(LoginCallback)callback {
    NSString *autoLoginUserName = [self autoLoginUserName];
    [self loginWithUserName:autoLoginUserName callback:^(BOOL success, NSString *error, NSDictionary *userData) {
        callback(success, error, userData);
    }];
}

- (void)logout {
    self.data = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:KeyUserNameForAutoLogin];
    [userDefaults synchronize];
}

#pragma mark - Helper

- (BOOL)validateEmail:(NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

// Return the filePath of saved image
- (NSString *)saveImageToAppFolder:(UIImage *)image withName:(NSString *)fileName {
    NSData *pngData = UIImagePNGRepresentation(image);
    NSString *filePath = [DeviceHelper documentsPathForFileName:[fileName stringByAppendingString:@".png"]];
    [pngData writeToFile:filePath atomically:YES]; //Write the file
    return filePath;
}

#pragma Create/ modify user account helper methods

- (void)registerUserWithData:(NSDictionary *)dictionary {
    NSMutableArray *userAccounts = [self userAccountArrayFromPref];
    [userAccounts addObject:dictionary];
    [self saveUserArrayIntoPref:userAccounts];
}

- (void)updateUserWithData:(NSDictionary *)dictionary {
    NSString *targetUserName = [dictionary objectForKey:KeyUserName];
    NSMutableArray *userAccounts = [self userAccountArrayFromPref];
    for (NSDictionary *userData in userAccounts) {
        if ([((NSString *)[userData objectForKey:KeyUserName]) isEqual:targetUserName]) {
            [userAccounts removeObject:userData];
            break;
        }
    }
    [self registerUserWithData:dictionary];
}

- (BOOL)emailUsed:(NSString *)checkingEmail {
    NSMutableArray *userAccts = [self userAccountArrayFromPref];
    for (NSDictionary *userData in userAccts) {
        NSString *email = [userData objectForKey:KeyUserEmail];
        if ([email isEqual:checkingEmail]) {
            return YES;
        }
    }
    return NO;
}

- (NSMutableArray *)userAccountArrayFromPref {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userArray = [userDefaults objectForKey:KeyUserAccountArray];
    if (userArray == nil) {
        userArray = [NSMutableArray array];
    }
    
    // Testing
    for (NSDictionary *userData in userArray) {
        NSLog(@"%s: userData: %@", __func__, userData);
    }
    
    return userArray;
}

- (void)saveUserArrayIntoPref:(NSMutableArray *)userArray {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userArray forKey:KeyUserAccountArray];
    [userDefaults synchronize];
}

- (void)setAutoLoginUser:(NSString *)userName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userName forKey:KeyUserNameForAutoLogin];
    [userDefaults synchronize];
}

- (NSString *)autoLoginUserName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:KeyUserNameForAutoLogin];
}

@end
