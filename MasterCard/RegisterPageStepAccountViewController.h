//
//  RegisterPageStepAccountViewController.h
//  MasterCard
//
//  Created by Altitude Labs on 13/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAccountManager.h"

@interface RegisterPageStepAccountViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeight;

@property (weak, nonatomic) IBOutlet UIButton *btnOr;

@property (weak, nonatomic) IBOutlet UIButton *btnBorrower;
@property (weak, nonatomic) IBOutlet UIImageView *imageBorrower;
@property (weak, nonatomic) IBOutlet UILabel *labelBorrower;

@property (weak, nonatomic) IBOutlet UIButton *btnLender;
@property (weak, nonatomic) IBOutlet UIImageView *imageLender;
@property (weak, nonatomic) IBOutlet UILabel *labelLender;

@property (weak, nonatomic) IBOutlet UITextField *textboxEmail;
@property (weak, nonatomic) IBOutlet UITextField *textboxPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property (strong, nonatomic) UserAccountManager *registrationManager;

- (IBAction)btnBorrowerTouchUpInside:(id)sender;
- (IBAction)btnLenderTouchUpInside:(id)sender;
- (IBAction)btnNextTouchUpInside:(id)sender;

@end
