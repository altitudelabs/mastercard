//
//  BorrowerProfileViewController.m
//  MasterCard
//
//  Created by Altitude Labs on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "BorrowerProfileViewController.h"
#import "AppConfig.h"

@interface BorrowerProfileViewController ()

@end

@implementation BorrowerProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderNavigationBar];
}

- (void)renderNavigationBar {
    // Hide navigation bar
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    // Custom back button for all other pages
    UIImage *backButtonImage = [[UIImage imageNamed:@"back@2x.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, backButtonImage.size.height*2) forBarMetrics:UIBarMetricsDefault];
    
    
    // Title
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.text = @"Giordano Profile";
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.font = [UIFont fontWithName:UIFontRegularBook size:19.0];
    [lblTitle sizeToFit];
    self.navigationItem.titleView = lblTitle;
}

@end