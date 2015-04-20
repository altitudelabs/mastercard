//
//  LoginViewController.m
//  MasterCard
//
//  Created by Justin Yek on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "LoginViewController.h"
#import "BorrowerProfileViewController.h"
#import "LoanRequestFeedViewController.h"
#import "LoanRequestContainerViewController.h"
#import "RegisterPageStepAccountViewController.h"
#import "UserAccountManager.h"
#import "UIHelper.h"
#import "AppConfig.h"
#import "DataManager.h"

@interface LoginViewController () <UITextFieldDelegate>
@property (strong, nonatomic) UserAccountManager *registrationManager;
@property (assign, nonatomic) BOOL loggedOnce;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self render];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self renderNavigationBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UserAccountManager *acctManager = [UserAccountManager sharedInstance];
    [acctManager tryAutoLogin:^(BOOL success, NSString *error, NSDictionary *userData) {
        if (success) {
            [self toMainPageWithLoggedState:YES userData:userData withDelay:NO];
        } else {
            NSLog(@"%s: %@", __func__,  error);
        }
    }];
}

- (void)renderNavigationBar {
    // Hide navigation bar
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [self navigationController].navigationBar.barTintColor = ColorBlue;
    [[UINavigationBar appearance] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    // Custom back button for all other pages
    UIImage *backButtonImage = [[UIImage imageNamed:@"back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, backButtonImage.size.height*2) forBarMetrics:UIBarMetricsDefault];
    
    // Title
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.text = @"Login";
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.font = [UIFont fontWithName:UIFontRegularBook size:19.0];
    [lblTitle sizeToFit];
    self.navigationItem.titleView = lblTitle;
}

- (void)render {
    // Render buttons
    self.buttonSignIn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.buttonSignIn.layer.borderWidth = 1;
    self.buttonSignIn.layer.cornerRadius = 12;
    self.buttonCreateAcct.layer.cornerRadius = 12;
    self.btnSignIn.layer.cornerRadius = 12;
    
    // Render Sign in view
    self.textFieldSignInEmail.delegate = self;
    self.textFieldSignInPassword.delegate = self;
    
    // Textboxes
    if ([self.textFieldSignInEmail respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        self.textFieldSignInEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.textFieldSignInEmail.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    }
    if ([self.textFieldSignInPassword respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        self.textFieldSignInPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.textFieldSignInPassword.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    self.signInDialog.alpha = 0;
}

- (void)showSignInDialog:(BOOL)show {
    if (show) {
        [UIView animateWithDuration:0.4 animations:^{
            self.signInDialog.alpha = 1;
            self.buttonSignIn.alpha = 0;
            self.buttonCreateAcct.alpha = 0;
        } completion:^(BOOL finished) {
        }];
    } else {
        [UIView animateWithDuration:0.4 animations:^{
            self.signInDialog.alpha = 0;
            self.buttonSignIn.alpha = 1;
            self.buttonCreateAcct.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }
}

- (IBAction)signupButtonPressed:(id)sender {
    
}

- (IBAction)showSignInDialogButtonPressed:(id)sender {
    [self showSignInDialog:YES];
}

- (IBAction)continueWithoutAccountTouchUpInside:(id)sender {
    [self toMainPageWithLoggedState:NO userData:nil withDelay:NO];
}

- (IBAction)signInTouchUpInside:(id)sender {
    [self signInNow];
}

- (IBAction)signInCancelTouchUpInside:(id)sender {
    self.textFieldSignInEmail.text = @"";
    self.textFieldSignInPassword.text = @"";
    [self showSignInDialog:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"createAccount"]) {
        self.registrationManager = [UserAccountManager sharedInstance];
        RegisterPageStepAccountViewController *destVC = segue.destinationViewController;
        destVC.registrationManager = self.registrationManager;
        
    } else if ([segue.identifier isEqual:@"withoutLogin"]) {
    }
}

- (void)signInNow {
    NSString *email = self.textFieldSignInEmail.text;
    NSString *password = self.textFieldSignInPassword.text;
    UserAccountManager *acctManager = [UserAccountManager sharedInstance];
    [acctManager loginWithEmail:email password:password callback:^(BOOL success, NSString *error, NSDictionary *userData) {
        if (success) {
            [self toMainPageWithLoggedState:YES userData:userData withDelay:YES];
            self.textFieldSignInEmail.text = @"";
            self.textFieldSignInPassword.text = @"";
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Oops" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        }
    }];
}

- (void)toMainPageWithLoggedState:(BOOL)loggedIn userData:(NSDictionary *)userDataOrNil withDelay:(BOOL)delay {
    int delayTime = 0;
    if (delay) {
        delayTime = arc4random() % 2 + 1;
        [[UIHelper sharedInstance] showLoadingSpinnerInView:self.view];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delayTime * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (delay) {
            [[UIHelper sharedInstance] hideLoadingSpinnerInView:self.view];
        }
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoanRequestContainerViewController *vc = (LoanRequestContainerViewController *)[sb instantiateViewControllerWithIdentifier:@"LoanRequestContainerViewController"];
        vc.loggedIn = loggedIn;
        vc.userData = userDataOrNil;
        [self.navigationController pushViewController:vc animated:YES];
    });
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.textFieldSignInEmail) {
        [self.textFieldSignInPassword becomeFirstResponder];
    } else if (textField == self.textFieldSignInPassword) {
        [self.view endEditing:YES];
        [self signInNow];
    }
    return YES;
}

#pragma mark - UIResponder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
