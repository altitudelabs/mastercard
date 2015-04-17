//
//  LoanRequestViewController.h
//  MasterCard
//
//  Created by Altitude Labs on 9/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FundityTableViewController.h"

@interface LoanRequestViewController : FundityTableViewController

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSDictionary *userData;
@property (assign, nonatomic) BOOL loggedIn; // Default is NO

- (void)filterByAmount;
- (void)filterByRate;
- (void)filterByNone;

@end
