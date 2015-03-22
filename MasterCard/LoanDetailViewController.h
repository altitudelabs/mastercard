//
//  LoanDetailViewController.h
//  MasterCard
//
//  Created by Altitude Labs on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *amtToLendText;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnLendNow;
@property (weak, nonatomic) IBOutlet UIButton *btnMoneySend;

- (IBAction)btnLendNowAction:(id)sender;
- (IBAction)btnLendWithSend:(id)sender;

@end
