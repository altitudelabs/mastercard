//
//  LoanerDetailViewController.h
//  MasterCard
//
//  Created by Altitude Labs on 10/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FundityTableViewController.h"

@interface LoanerDetailViewController : FundityTableViewController

@property (strong, nonatomic) NSDictionary *data;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *LoanerName;
@property (weak, nonatomic) IBOutlet UILabel *LoanerDescription;
@property (weak, nonatomic) IBOutlet UILabel *LoanerDetails;
@property (weak, nonatomic) IBOutlet UIView *progressBar;
@property (weak, nonatomic) IBOutlet UIView *detailContainerView;

@property (weak, nonatomic) IBOutlet UILabel *fundityScore;

@property (weak, nonatomic) IBOutlet UITextField *lendAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *lendRateTextField;

@property (weak, nonatomic) IBOutlet UILabel *lenderNum;
@property (weak, nonatomic) IBOutlet UILabel *lenderNumValue;
@property (weak, nonatomic) IBOutlet UILabel *lendedValue;
@property (weak, nonatomic) IBOutlet UILabel *lendRequireValue;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;

@property (weak, nonatomic) IBOutlet UIView *containerViewLendAmount;
@property (weak, nonatomic) IBOutlet UIView *containerViewLendRate;

@property (weak, nonatomic) IBOutlet UIButton *buttonLendNow;

- (IBAction)lendNowTouchUpInside:(id)sender;

@end
