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
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderNavigationBar];
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
    
}

- (IBAction)signupButtonPressed:(id)sender {
    
}

- (IBAction)continueWithoutAccountTouchUpInside:(id)sender {
}


@end
