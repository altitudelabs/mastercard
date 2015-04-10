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
@property (nonatomic, assign) BOOL selectedLender;
@property (nonatomic, assign) BOOL selectedBorrower;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderNavigationBar];
    self.selectedLender = NO;
    self.selectedBorrower = NO;
    
    self.btnPassword.secureTextEntry = YES;
    
    self.btnUsername.delegate = self;
    self.btnPassword.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    if ([self.btnUsername respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        self.btnUsername.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email (or Username)" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }
    
    if ([self.btnPassword respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        self.btnPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }
}
                                   
- (void)cancelKeyboard:(id)sender {
    [self.btnUsername resignFirstResponder];
    [self.btnPassword resignFirstResponder];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signupButtonPressed:(id)sender {
    if (self.selectedBorrower) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BorrowerProfileViewController *vc = (BorrowerProfileViewController *)[sb instantiateViewControllerWithIdentifier:@"BorrowerProfileViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (self.selectedLender) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoanRequestViewController *vc = (LoanRequestViewController *)[sb instantiateViewControllerWithIdentifier:@"LoanRequestViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        
        //LoanRequestViewController *vc = [[LoanRequestViewController alloc] init];
        //[self.navigationController pushViewController:vc animated:YES];
        
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Incomplete info" message:@"You need to select lender or borrower." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

- (IBAction)btnLenderTouchUpInside:(id)sender {
    self.selectedLender = YES;
    self.btnLender.selected = YES;
    self.selectedBorrower = NO;
    self.btnBorrower.selected = NO;
}

- (IBAction)btnBorrowerTouchUpInside:(id)sender {
    self.selectedLender = NO;
    self.btnLender.selected = NO;
    self.selectedBorrower = YES;
    self.btnBorrower.selected = YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.btnUsername) {
        [self.btnPassword becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

@end
