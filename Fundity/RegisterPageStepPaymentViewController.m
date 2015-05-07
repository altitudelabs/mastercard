//
//  RegisterPageStepPaymentViewController.m
//  MasterCard
//
//  Created by Altitude Labs on 13/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "RegisterPageStepPaymentViewController.h"
#import "LoanRequestContainerViewController.h"
#import "UITextField+WithPadding.h"
#import "AppConfig.h"
#import "UIHelper.h"
#import <Masonry.h>

typedef NS_ENUM(NSInteger, UIPickerOption) {
    UIPickerForBank = 1,
    UIPickerForExpiryDate = 2
};

@interface RegisterPageStepPaymentViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) NSArray *bankList;
@property (assign, nonatomic) UIPickerOption pickerOption;
@property (strong, nonatomic) UIPickerView *currentPicker;
@property (strong, nonatomic) UIButton *doneBtn;

@property (strong, nonatomic) NSString *btnChooseBankPlaceholder;
@property (strong, nonatomic) NSString *btnExpiryMonthPlaceholder;
@end

@implementation RegisterPageStepPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self render];
    [self renderNavigationBar];
    
    self.btnChooseBankPlaceholder = self.btnChooseBank.titleLabel.text;
    self.btnExpiryMonthPlaceholder = self.btnExpiryMonth.titleLabel.text;
}

#pragma mark - Private

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
    // Data
    self.bankList = [NSArray arrayWithObjects:@"Bank of China", @"HSBC", @"Hang Seng Bank", nil];
    
    // Border
    [self addBorder:self.btnChooseBank];
    [self addBorder:self.textFieldAcctNumber];
    [self addBorder:self.textFieldCreditCardNo];
    [self addBorder:self.btnExpiryMonth];
    [self addBorder:self.textFieldCVCCode];
    [self addBorder:self.btnSubmit];
    
    // TextField
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.scrollView addGestureRecognizer:tap];
    
    self.textFieldAcctNumber.delegate = self;
    self.textFieldCreditCardNo.delegate = self;
    self.textFieldCVCCode.delegate = self;
}

- (void)addBorder:(UIView *)view {
    view.layer.borderWidth = 1;
    view.layer.borderColor = ColorTextFieldBorder.CGColor;
}

- (void)dismissKeyboard {
    [self.textFieldAcctNumber resignFirstResponder];
    [self.textFieldCreditCardNo resignFirstResponder];
    [self.textFieldCVCCode resignFirstResponder];
}

- (void)showPickerView:(UIPickerView *)pickerView {
    self.currentPicker = pickerView;
    pickerView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame), CGRectGetWidth(pickerView.frame), CGRectGetHeight(pickerView.frame));
    pickerView.alpha = 0;
    self.doneBtn.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        pickerView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - CGRectGetHeight(pickerView.frame), CGRectGetWidth(pickerView.frame), CGRectGetHeight(pickerView.frame));
        pickerView.alpha = 1;
        self.doneBtn.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.doneBtn.alpha = 1;
    }];
    
    self.scrollView.userInteractionEnabled = NO;
}

- (void)hidePickerView:(UIPickerView *)pickerView {
    self.currentPicker = pickerView;
    pickerView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - CGRectGetHeight(pickerView.frame), CGRectGetWidth(pickerView.frame), CGRectGetHeight(pickerView.frame));
    pickerView.alpha = 1;
    self.doneBtn.alpha = 1;
    [UIView animateWithDuration:0.5 animations:^{
        pickerView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame), CGRectGetWidth(pickerView.frame), CGRectGetHeight(pickerView.frame));
        pickerView.alpha = 0;
    } completion:^(BOOL finished) {
        [pickerView removeFromSuperview];
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.doneBtn.alpha = 0;
    }];
    
    self.scrollView.userInteractionEnabled = YES;
}

#pragma mark - IBAction

- (IBAction)pickBankTouchUpInside:(id)sender {
    self.pickerOption = UIPickerForBank;
    UIPickerView *picker = [self makePicker];
    [self showPickerView:picker];
}

- (IBAction)pickExpiryMonthTouchUpInside:(id)sender {
    self.pickerOption = UIPickerForExpiryDate;
    UIPickerView *picker = [self makePicker];
    [self showPickerView:picker];
}

- (IBAction)submitTouchUpInside:(id)sender {
    [[UIHelper sharedInstance] showLoadingSpinnerInView:self.view];
    
    NSString *bankName = self.btnChooseBank.titleLabel.text;
    if ([bankName isEqual:self.btnChooseBankPlaceholder]) {
        bankName = nil;
    }
    NSString *expiryMonth = self.btnExpiryMonth.titleLabel.text;
    if ([expiryMonth isEqual:self.btnExpiryMonthPlaceholder]) {
        expiryMonth = nil;
    }
    [self.registrationManager setBankName:bankName bankAccountNumber:self.textFieldAcctNumber.text creditCardNumber:self.textFieldCreditCardNo.text expiryDate:expiryMonth cvcCode:self.textFieldCVCCode.text callback:^(BOOL success, NSString *error) {
        [[UIHelper sharedInstance] hideLoadingSpinnerInView:self.view];
        
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Oops" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }];
}

- (UIPickerView *)makePicker {
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
    
    self.doneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    self.doneBtn.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1];
    [self.doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.doneBtn.titleLabel.font = [UIFont fontWithName:UIFontRegular size:20];
    self.doneBtn.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - CGRectGetHeight(pickerView.frame), CGRectGetWidth(pickerView.frame), 40);
    [self.doneBtn addTarget:self action:@selector(pickerDone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneBtn];
    
    return pickerView;
}

- (void)pickerDone {
    [self hidePickerView:self.currentPicker];
    if (self.pickerOption == UIPickerForBank) {
        [self.btnChooseBank setTitle:[self.bankList objectAtIndex:[self.self.currentPicker selectedRowInComponent:0]] forState:UIControlStateNormal];
    } else {
        NSInteger year = 2015 + [self.currentPicker selectedRowInComponent:0];
        NSInteger month = [self.currentPicker selectedRowInComponent:1] + 1;
        NSString *expiryDate = [NSString stringWithFormat:@"%ld / %ld", year, month];
        [self.btnExpiryMonth setTitle:expiryDate forState:UIControlStateNormal];
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.pickerOption == UIPickerForBank) {
        return 1;
    } else {
        return 2;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.pickerOption == UIPickerForBank) {
        return self.bankList.count;
    } else {
        if (component == 0) { // Year
            return 50;
        } else { // Month
            return 12;
        }
    }
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.pickerOption == UIPickerForBank) {
        return [self.bankList objectAtIndex:row];
    } else {
        if (component == 0) { // Year
            NSInteger year = 2015 + row;
            return [NSString stringWithFormat:@"%ld", year];
        } else { // Month
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            NSString *monthName = [[df monthSymbols] objectAtIndex:(row)];
            return monthName;
        }
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.textFieldAcctNumber) {
        [self.textFieldCreditCardNo becomeFirstResponder];
    } else {
        [self dismissKeyboard];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.textFieldCVCCode) {
        [self.scrollView setContentOffset:CGPointMake(0, 40) animated:YES];
    } else if (textField == self.textFieldCreditCardNo) {
        [self.scrollView setContentOffset:CGPointMake(0, 5) animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.scrollView setContentOffset:CGPointMake(0, -64) animated:YES];
}

@end
