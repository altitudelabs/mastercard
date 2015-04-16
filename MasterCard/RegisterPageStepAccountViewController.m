//
//  RegisterPageStepAccountViewController.m
//  MasterCard
//
//  Created by Altitude Labs on 13/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "RegisterPageStepAccountViewController.h"
#import "UITextField+WithPadding.h"
#import "AppConfig.h"

#define SelectedBLueColor [UIColor colorWithRed:83/255.0  green:120/255.0 blue:216/255.0 alpha:1.0]

@interface RegisterPageStepAccountViewController () <UITextFieldDelegate>
@property (assign, nonatomic) BOOL borrowerSelected;
@end

@implementation RegisterPageStepAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderNavigationBar];
    [self render];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.containerViewWidth.constant = self.scrollView.frame.size.width;
//    self.containerViewHeight.constant = self.scrollView.frame.size.height;
//}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.containerViewWidth.constant = self.scrollView.frame.size.width;
    self.containerViewHeight.constant = self.scrollView.frame.size.height;
}

# pragma mark - Private

- (void)renderNavigationBar {
    // Show navigation bar
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    // Custom back button for all other pages
    UIImage *backButtonImage = [[UIImage imageNamed:@"back@2x.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, backButtonImage.size.height*2) forBarMetrics:UIBarMetricsDefault];
    
    // Title
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.text = @"Registration";
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.font = [UIFont fontWithName:UIFontRegularBook size:19.0];
    [lblTitle sizeToFit];
    self.navigationItem.titleView = lblTitle;
}

- (void)render {
    // Borders
    self.btnBorrower.layer.borderWidth = 1;
    self.btnBorrower.layer.borderColor = ColorTextFieldBorder.CGColor;
    
    self.btnLender.layer.borderWidth = 1;
    self.btnLender.layer.borderColor = ColorTextFieldBorder.CGColor;
    
    self.btnOr.layer.borderWidth = 1;
    self.btnOr.layer.borderColor = [UIColor colorWithWhite:0.65 alpha:1].CGColor;
    self.btnOr.layer.cornerRadius = 3;
    
    self.textboxEmail.layer.borderWidth = 1;
    self.textboxEmail.layer.borderColor = ColorTextFieldBorder.CGColor;
    
    self.textboxPassword.layer.borderWidth = 1;
    self.textboxPassword.layer.borderColor = ColorTextFieldBorder.CGColor;
    
    self.btnNext.layer.borderWidth = 1;
    self.btnNext.layer.borderColor = ColorTextFieldBorder.CGColor;
    
    // Borrower & lender button
    self.borrowerSelected = YES;
    [self updateBorrowerLenderButtons];
    
    // Textbox
    self.textboxEmail.delegate = self;
    self.textboxPassword.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.scrollView addGestureRecognizer:tap];
}

- (void)updateBorrowerLenderButtons {
    if (self.borrowerSelected) {
        self.btnBorrower.backgroundColor = SelectedBLueColor;
        self.imageBorrower.image = [UIImage imageNamed:@"Registration_Borrower.png"];
        self.labelBorrower.textColor = [UIColor whiteColor];
        
        self.btnLender.backgroundColor = [UIColor whiteColor];
        self.imageLender.image = [UIImage imageNamed:@"Registration_Lender.png"];
        self.labelLender.textColor = ColorTextFieldBorder;
        
    } else {
        self.btnLender.backgroundColor = SelectedBLueColor;
        self.imageLender.image = [UIImage imageNamed:@"Registration_ActiveLender.png"];
        self.labelLender.textColor = [UIColor whiteColor];
        
        self.btnBorrower.backgroundColor = [UIColor whiteColor];
        self.imageBorrower.image = [UIImage imageNamed:@"Registration_InActiveBorrower.png"];
        self.labelBorrower.textColor = ColorTextFieldBorder;
    }
}

- (void)dismissKeyboard {
    [self.textboxEmail resignFirstResponder];
    [self.textboxPassword resignFirstResponder];
}

#pragma mark - Outlet Actions

- (IBAction)btnBorrowerTouchUpInside:(id)sender {
    self.borrowerSelected = YES;
    [self updateBorrowerLenderButtons];
}

- (IBAction)btnLenderTouchUpInside:(id)sender {
    self.borrowerSelected = NO;
    [self updateBorrowerLenderButtons];
}

- (IBAction)btnNextTouchUpInside:(id)sender {
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.textboxEmail) {
        [self.textboxEmail resignFirstResponder];
        [self.textboxPassword becomeFirstResponder];
    } else if (textField == self.textboxPassword) {
        [self.textboxPassword resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.textboxPassword) {
        NSLog(@"aa: %f", self.scrollView.contentOffset.y);
        [self.scrollView setContentOffset:CGPointMake(0, 20) animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.scrollView setContentOffset:CGPointMake(0, -64) animated:YES];
}

@end
