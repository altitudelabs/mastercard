//
//  MyProfileTableViewController.h
//  MasterCard
//
//  Created by Altitude Labs on 16/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FundityTableViewController.h"

@interface MyProfileTableViewController : FundityTableViewController

@property (weak, nonatomic) IBOutlet UIImageView *profilePhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *locationName;
@property (weak, nonatomic) IBOutlet UIButton *fundityFastPayButton;
@property (weak, nonatomic) IBOutlet UIButton *applyNewLoanButton;

@property (weak, nonatomic) IBOutlet UIView *earningContentView;
@property (weak, nonatomic) IBOutlet UIView *earningGrossYield;
@property (weak, nonatomic) IBOutlet UIView *earningAnnualReturn;
@property (weak, nonatomic) IBOutlet UIView *earningEstimatedReturn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *earningItemHeight;

@property (strong, nonatomic) NSDictionary *data;

- (IBAction)fundityFastPayTouchUpInside:(id)sender;
- (IBAction)applyNewLoanTouchUpInside:(id)sender;

@end
