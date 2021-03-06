//
//  BorrowerProfileViewController.h
//  MasterCard
//
//  Created by Altitude Labs on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BorrowerProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *btnPayNow;

@property (weak, nonatomic) IBOutlet UIButton *btnApplyNow;

- (IBAction)payNowAction:(id)sender;

- (IBAction)applyNewLoanAction:(id)sender;

@end
