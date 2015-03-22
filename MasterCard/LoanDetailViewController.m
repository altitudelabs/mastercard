//
//  LoanDetailViewController.m
//  MasterCard
//
//  Created by Altitude Labs on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "LoanDetailViewController.h"
#import "DataManager.h"
#import "AppConfig.h"

@interface LoanDetailViewController () <UITextFieldDelegate>
{
    CGPoint scrollViewContentOffset;
}

@end

@implementation LoanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 650);
    
    [self renderNavigationBar];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    self.amtToLendText.delegate = self;
    
    [[DataManager sharedInstance] matchApi:^(BOOL success) {
        if (!success) {
            [[[UIAlertView alloc] initWithTitle:@"Match API" message:@"The merchant you are trying to engage with is potentially of high risk." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }];
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
    lblTitle.text = @"Loan Detail";
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.font = [UIFont fontWithName:UIFontRegularBook size:19.0];
    [lblTitle sizeToFit];
    self.navigationItem.titleView = lblTitle;
}

- (void)cancelKeyboard:(id)sender {
    [self.amtToLendText resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.amtToLendText resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    scrollViewContentOffset = self.scrollView.contentOffset;
    [self.scrollView setContentOffset:CGPointMake(0, 240) animated:YES];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [self.scrollView setContentOffset:scrollViewContentOffset animated:YES];
    return YES;
}

- (IBAction)btnLendNowAction:(id)sender {
    
    [[DataManager sharedInstance] merchantCheckoutApiWithViewController:self];
    self.btnLendNow.hidden = YES;
    self.btnMoneySend.hidden = YES;
    
    [[DataManager sharedInstance]  fraudApi:^(BOOL success) {
//        if (success) {
////            NSInteger amt = [self.amtToLendText.text integerValue];
////            [[DataManager sharedInstance] merchantCheckoutApiWithViewController:self];
////            self.btnLendNow.hidden = YES;
////            self.btnMoneySend.hidden = YES;
//            
//        } else {
//            [[[UIAlertView alloc] initWithTitle:@"Fraud?" message:@"This is probably a fraud transaction" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//        }
    }];
    
}

- (IBAction)btnLendWithSend:(id)sender {
    
    self.btnLendNow.hidden = YES;
    self.btnMoneySend.hidden = YES;
    [[[UIAlertView alloc] initWithTitle:@"Success!" message:@"Money sent!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
    [[DataManager sharedInstance]  fraudApi:^(BOOL success) {
//        if (success) {
//            //            NSInteger amt = [self.amtToLendText.text integerValue];
//            [[DataManager sharedInstance] moneysendApi:^(BOOL success) {
//                if (success) {
////                    self.btnLendNow.alpha = 0;
////                    self.btnMoneySend.alpha = 0;
////                    [[[UIAlertView alloc] initWithTitle:@"Success!" message:@"Money sent!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//                } else {
//                    [[[UIAlertView alloc] initWithTitle:@"Money Send" message:@"Error." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//                }
//            }];
//            
//        } else {
//            [[[UIAlertView alloc] initWithTitle:@"Fraud?" message:@"This is probably a fraud transaction" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//        }
    }];
    
}
@end
