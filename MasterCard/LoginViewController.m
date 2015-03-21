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
}
                                   
- (void)cancelKeyboard:(id)sender {
    [self.btnUsername resignFirstResponder];
    [self.btnPassword resignFirstResponder];
    
}

- (void)renderNavigationBar {
    [[DataManager sharedInstance] moneysendApi];
    [[DataManager sharedInstance] fraudApi];
    [[DataManager sharedInstance] matchApi];
    [[DataManager sharedInstance] lostAccountApi];
    [[DataManager sharedInstance] merchantCheckoutApiWithViewController:self];
    
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
        
        self.btnUsername.text = @"";
        
    } else if (self.selectedLender) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoanRequestFeedViewController *vc = (LoanRequestFeedViewController *)[sb instantiateViewControllerWithIdentifier:@"LoanRequestFeedViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        
        self.btnUsername.text = @"";
        
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
    [textField resignFirstResponder];
    
    return YES;
}

@end
