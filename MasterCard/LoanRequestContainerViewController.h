//
//  LoanRequestContainerViewController.h
//  MasterCard
//
//  Created by Altitude Labs on 16/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanRequestContainerViewController : UIViewController

@property (assign, nonatomic) BOOL loggedIn;
@property (strong, nonatomic) NSDictionary *userData;

@end