//
//  BorrowerApplyNewLoanViewController.h
//  MasterCard
//
//  Created by Altitude Labs on 15/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BorrowerApplyNewLoanViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UITextField *textFieldBorrowAmount;

// Loan Repayment Duration

@property (weak, nonatomic) IBOutlet UIView *loanRepaymentDurationContainerView;
@property (weak, nonatomic) IBOutlet UIView *loanRepaymentDurationLine;

@property (weak, nonatomic) IBOutlet UIView *loanDurationBlock3m;
@property (weak, nonatomic) IBOutlet UIView *loanDurationBlock6m;
@property (weak, nonatomic) IBOutlet UIView *loanDurationBlock2yr;
@property (weak, nonatomic) IBOutlet UIView *loanDurationBlock3yr;
@property (weak, nonatomic) IBOutlet UIView *loanDurationBlock4yr;

@property (weak, nonatomic) IBOutlet UIButton *loanDurationDot3m;
@property (weak, nonatomic) IBOutlet UIButton *loanDurationDot6m;
@property (weak, nonatomic) IBOutlet UIButton *loanDurationDot2yr;
@property (weak, nonatomic) IBOutlet UIButton *loanDurationDot3yr;
@property (weak, nonatomic) IBOutlet UIButton *loanDurationDot4yr;

@property (weak, nonatomic) IBOutlet UIImageView *verificationImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *verificationImageView2;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton1;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uploadButton1Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uploadButton2Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;

@property (weak, nonatomic) IBOutlet UIButton *checkEligibilityButton;

- (IBAction)uploadImage1TouchUpInside:(id)sender;
- (IBAction)uploadImage2TouchUpInside:(id)sender;
- (IBAction)checkEligibilityTouchUpInside:(id)sender;

@end
