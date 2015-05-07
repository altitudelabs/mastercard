//
//  RegisterPageStepPaymentViewController.h
//  MasterCard
//
//  Created by Altitude Labs on 13/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAccountManager.h"

@interface RegisterPageStepPaymentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnChooseBank;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAcctNumber;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCreditCardNo;
@property (weak, nonatomic) IBOutlet UIButton *btnExpiryMonth;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCVCCode;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UserAccountManager *registrationManager;

- (IBAction)pickBankTouchUpInside:(id)sender;
- (IBAction)pickExpiryMonthTouchUpInside:(id)sender;
- (IBAction)submitTouchUpInside:(id)sender;

@end
