//
//  UIHelper.h
//  MasterCard
//
//  Created by Altitude Labs on 17/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIHelper : NSObject

+ (UIHelper*)sharedInstance;

- (void)showLoadingSpinnerInView:(UIView *)view;
- (void)hideLoadingSpinnerInView:(UIView *)view;

@end
