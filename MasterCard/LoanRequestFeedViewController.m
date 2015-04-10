//
//  LoanRequestViewController.m
//  MasterCard
//
//  Created by Altitude Labs on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "LoanRequestFeedViewController.h"
#import "LeaderProfileViewController.h"
#import "AppConfig.h"

@interface LoanRequestFeedViewController ()

@end

@implementation LoanRequestFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderNavigationBar];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 590);
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
    lblTitle.text = @"Loan Requests";
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.font = [UIFont fontWithName:UIFontRegularBook size:19.0];
    [lblTitle sizeToFit];
    self.navigationItem.titleView = lblTitle;
    
//    // Right button
    UIButton* buttonDone = [UIButton buttonWithType: UIButtonTypeCustom];
    buttonDone.frame = CGRectMake(0, 0, 30, 30);
    buttonDone.titleLabel.font = [UIFont fontWithName:UIFontRegularBook size:12];
//    [buttonDone setTitle:@" " forState:UIControlStateNormal];
    [buttonDone setImage:[UIImage imageNamed:@"profile.png"] forState:UIControlStateNormal];
    [buttonDone setTitle:@"" forState:UIControlStateNormal];
    [buttonDone addTarget:self action:@selector(doneButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:buttonDone];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void)doneButtonTouchUpInside:(id)sender {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    LeaderProfileViewController *vc = (LeaderProfileViewController *)[sb instantiateViewControllerWithIdentifier:@"LeaderProfileViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
