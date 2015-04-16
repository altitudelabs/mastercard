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

#import "LoanRequestViewController.h"

#import "AppConfig.h"

#import "DataManager.h"

@interface LoginViewController () <UITextFieldDelegate>
//@property (assign, nonatomic) CGRect loginDialogOriginalFrame;
//@property (assign, nonatomic) CGRect createAcctButtonOriginalFrame;
//@property (assign, nonatomic) CGRect signInButtonOriginalFrame;
@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self renderNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self render];
}

- (void)renderNavigationBar {
    // Hide navigation bar
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [self navigationController].navigationBar.barTintColor = ColorBlue;
    [[UINavigationBar appearance] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    // Custom back button for all other pages
    UIImage *backButtonImage = [[UIImage imageNamed:@"back@2x.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
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
    
}

- (IBAction)signInTouchUpInside:(id)sender {
    
}

- (IBAction)signInCancelTouchUpInside:(id)sender {
    [self showSignInDialog:NO];
}


@end
