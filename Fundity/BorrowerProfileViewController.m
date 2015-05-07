//
//  BorrowerProfileViewController.m
//  MasterCard
//
//  Created by Altitude Labs on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "BorrowerProfileViewController.h"
#import "BorrowerNewLoanViewController.h"
#import "AppConfig.h"
#import "DataManager.h"

@interface BorrowerProfileViewController ()

@end

@implementation BorrowerProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderNavigationBar];
    
    self.scrollView.contentSize = CGSizeMake(320, 743);
    
    
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

- (IBAction)payNowAction:(id)sender {
    
    [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Money sent!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    
    // Lost account?
    [[DataManager sharedInstance] lostAccountApi:^(BOOL success) {
        if (success) { // Account is okay
            // Send money
            [[DataManager sharedInstance] moneysendApi:^(BOOL success) {
//                if (success) {
//                    [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Money sent!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
//                } else {
//                    [[[UIAlertView alloc] initWithTitle:@"Money Send" message:@"Fail." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
//                }
            }];
            
        } else {
//            [[[UIAlertView alloc] initWithTitle:@"Lost account" message:@"This is a lost account." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        }
    }];
}

- (IBAction)applyNewLoanAction:(id)sender {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"check eigi"])
    {
        BorrowerNewLoanViewController *dest = [segue destinationViewController];
        
        dest.borrowerProfileViewController = self;
    }
}

@end
