//
//  BorrowerNewLoanViewController.h
//  MasterCard
//
//  Created by Altitude Labs on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BorrowerNewLoanViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textFieldBorrowMoney;
@property (weak, nonatomic) IBOutlet UIButton *dot1;
@property (weak, nonatomic) IBOutlet UIButton *dot2;
@property (weak, nonatomic) IBOutlet UIButton *dot3;
@property (weak, nonatomic) IBOutlet UIButton *dot4;
@property (weak, nonatomic) IBOutlet UIButton *dot5;

- (IBAction)upload1Clicked:(id)sender;
- (IBAction)upload2Clicked:(id)sender;
- (IBAction)checkEligibilityAction:(id)sender;

@end
