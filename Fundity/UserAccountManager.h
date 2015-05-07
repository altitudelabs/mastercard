//
//  RegistrationManager.h
//  MasterCard
//
//  Created by Altitude Labs on 16/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ RegistrationResultCallback)(BOOL success, NSString *error);
typedef void (^ LoginCallback)(BOOL success, NSString *error, NSDictionary *userData);

extern NSString* const KeyUserEmail;
extern NSString* const KeyUserpassword;
extern NSString* const KeyUserName;
extern NSString* const KeyUserCompany;
extern NSString* const KeyUserPhoneNumber;
extern NSString* const KeyUserAddress;
extern NSString* const KeyUserBank;
extern NSString* const KeyUserBankAcctNumber;
extern NSString* const KeyUserCreditCardNumber;
extern NSString* const KeyuserExpiryDate;
extern NSString* const KeyUserCVCCode;
extern NSString* const KeyUserProfileImage;


@interface UserAccountManager : NSObject

@property (strong, nonatomic) NSMutableDictionary *data;

+ (UserAccountManager *)sharedInstance;

- (id)init;

- (void)replaceDataWithCurrentAccount:(NSString *)currentAccountUserName;

- (void)setAccountDataWithEmail:(NSString *)email password:(NSString *)password callback:(RegistrationResultCallback)resultCallback;

- (void)setProfilePage:(UIImage *)profileImage userName:(NSString *)userName companyName:(NSString *)companyName phoneNumber:(NSString *)phoneNumber address:(NSString *)address licenseImage:(UIImage *)licenseImage callback:(RegistrationResultCallback) resultCallback;

- (void)setBankName:(NSString *)bankName bankAccountNumber:(NSString *) bankAccountNumber creditCardNumber:(NSString *)creditCardNumber expiryDate:(NSString *)expiryDate cvcCode:(NSString *)cvcCode callback:(RegistrationResultCallback) resultCallback;

- (void)registerThisAccountWithCallback:(RegistrationResultCallback) resultCallback;

// Need to call commitChange to update UserPref after this method
- (void)setProfilePhotoForThisUser:(UIImage *)profilePhoto;
- (void)commitChange;

// data will become the logged user if success
- (void)loginWithUserName:(NSString *)userName callback:(LoginCallback)callback;

- (void)loginWithEmail:(NSString *)email password:(NSString *)password callback:(LoginCallback)callback;

// data will become the logged user if success
- (void)tryAutoLogin:(LoginCallback)callback;

- (void)logout;

@end
