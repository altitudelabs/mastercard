//
//  BorrowerNewLoanViewController.m
//  MasterCard
//
//  Created by Altitude Labs on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "BorrowerNewLoanViewController.h"
#import "AppConfig.h"

@interface BorrowerNewLoanViewController ()

@end

@implementation BorrowerNewLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderNavigationBar];
    
    self.dot3.selected = YES;
    
    [self.dot1 addTarget:self action:@selector(selectDot:) forControlEvents:UIControlEventTouchUpInside];
    [self.dot2 addTarget:self action:@selector(selectDot:) forControlEvents:UIControlEventTouchUpInside];
    [self.dot3 addTarget:self action:@selector(selectDot:) forControlEvents:UIControlEventTouchUpInside];
    [self.dot4 addTarget:self action:@selector(selectDot:) forControlEvents:UIControlEventTouchUpInside];
    [self.dot5 addTarget:self action:@selector(selectDot:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKeyboard:)];
    [self.view addGestureRecognizer:tap];
}

- (void)cancelKeyboard:(id)sender {
    [self.textFieldBorrowMoney resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)renderNavigationBar {
    // Hide navigation bar
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    // Custom back button for all other pages
    UIImage *backButtonImage = [[UIImage imageNamed:@"back@2x.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, backButtonImage.size.height*2) forBarMetrics:UIBarMetricsDefault];
    
    // Title
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.text = @"New Loan";
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.font = [UIFont fontWithName:UIFontRegularBook size:19.0];
    [lblTitle sizeToFit];
    self.navigationItem.titleView = lblTitle;
}

- (void)selectDot:(id)sender {
    self.dot1.selected = NO;
    self.dot2.selected = NO;
    self.dot3.selected = NO;
    self.dot4.selected = NO;
    self.dot5.selected = NO;
    
    ((UIButton *)sender).selected = YES;
}

- (IBAction)upload1Clicked:(id)sender {
}

- (IBAction)upload2Clicked:(id)sender {
}

- (IBAction)checkEligibilityAction:(id)sender {
    
}


@end
