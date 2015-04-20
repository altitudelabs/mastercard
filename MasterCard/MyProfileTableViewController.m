//
//  MyProfileTableViewController.m
//  MasterCard
//
//  Created by Altitude Labs on 16/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "MyProfileTableViewController.h"
#import "UserAccountManager.h"
#import "UIHelper.h"
#import "DeviceHelper.h"
#import "AppConfig.h"
#import <Masonry.h>

#define TableRowNumber 6

@interface MyProfileTableViewController ()
@property (assign, nonatomic) NSInteger numberOfTableRow;
@property (assign, nonatomic) BOOL showRefreshButton;
@end

@implementation MyProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderNavigationBar];
    [self render];
    [self showContentWithDelay];
}

- (void)renderNavigationBar {
    // Show navigation bar
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    // Custom back button for all other pages
    UIImage *backButtonImage = [[UIImage imageNamed:@"back@2x.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, backButtonImage.size.height*2) forBarMetrics:UIBarMetricsDefault];
    
    // Title
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.text = @"My Profile";
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.font = [UIFont fontWithName:UIFontRegularBook size:19.0];
    [lblTitle sizeToFit];
    self.navigationItem.titleView = lblTitle;
    
    // Right button
    UIButton* buttonDone = [UIButton buttonWithType: UIButtonTypeCustom];
    buttonDone.frame = CGRectMake(0, 0, 40, 30);
    buttonDone.titleLabel.font = [UIFont fontWithName:UIFontRegularBook size:12];
    buttonDone.titleLabel.textAlignment = NSTextAlignmentRight;
    //    [buttonDone setTitle:@" " forState:UIControlStateNormal];
    [buttonDone setImage:nil forState:UIControlStateNormal];
    [buttonDone setTitle:@"Logout" forState:UIControlStateNormal];
    [buttonDone addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:buttonDone];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void)render {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    
    // Hide table first
    self.numberOfTableRow = 0;
    
    // Remove bottom border in last table cell
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    CGFloat earningItemLength = CGRectGetWidth(self.view.frame) * 0.33;
    [self.earningGrossYield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.earningContentView.mas_left);
        make.width.equalTo([NSNumber numberWithFloat:earningItemLength]);
    }];
    [self.earningAnnualReturn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.earningContentView.mas_centerX);
        make.width.equalTo([NSNumber numberWithFloat:earningItemLength]);
    }];
    [self.earningEstimatedReturn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.earningContentView.mas_right);
        make.width.equalTo([NSNumber numberWithFloat:earningItemLength]);
    }];
    
    CALayer *separator = [CALayer layer];
    separator.backgroundColor = [UIColor colorWithWhite:0.73 alpha:1].CGColor;
    separator.frame = CGRectMake(0, 0, 1, self.earningItemHeight.constant);
    
    CALayer *separator2 = [CALayer layer];
    separator2.backgroundColor = [UIColor colorWithWhite:0.73 alpha:1].CGColor;
    separator2.frame = CGRectMake((NSInteger)earningItemLength - 1, 0, 1, self.earningItemHeight.constant);
    
    [self.earningAnnualReturn.layer addSublayer:separator];
    [self.earningAnnualReturn.layer addSublayer:separator2];
    
    // Profile photo
    self.profilePhotoImageView.clipsToBounds = YES;
    self.profilePhotoImageView.layer.cornerRadius = CGRectGetWidth(self.profilePhotoImageView.frame) * 0.5;
    
    // Set data
    NSMutableDictionary *userData = [UserAccountManager sharedInstance].data;
    // Profile photo
    NSString *photoFilePath = [userData objectForKey:KeyUserProfileImage];
    photoFilePath = [[DeviceHelper documentsPathForFileName:photoFilePath] stringByAppendingString:@".png"];
    NSData *profilePhotoPng = [NSData dataWithContentsOfFile:photoFilePath];
    UIImage *profileImage = [UIImage imageWithData:profilePhotoPng];
    self.profilePhotoImageView.image = profileImage;
    // User company name
    self.profileName.text = [userData objectForKey:KeyUserCompany];
    // Location
//    self.profileName.text = [userData objectForKey:KeyUserAddress];
}

- (void)showContentWithDelay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if ([DeviceHelper isNetworkAvailable]) {
            self.numberOfTableRow = TableRowNumber;
            [self.tableView reloadData];
            self.showRefreshButton = NO;
            self.tableView.tableHeaderView = nil;
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Oops" message:@"Please check your internet connect and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            
            UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
            refreshButton.frame = CGRectMake(0, 0, 192, 132);
            [refreshButton setImage:[UIImage imageNamed:@"Fundity_Connection.png"] forState:UIControlStateNormal];
            [refreshButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            refreshButton.titleLabel.font = [UIFont fontWithName:UIFontLight size:15];
            [refreshButton addTarget:self action:@selector(showContentWithDelay) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
            [headerView addSubview:refreshButton];
            refreshButton.center = CGPointMake(headerView.center.x, headerView.center.y - 60);
            
            self.tableView.tableHeaderView = headerView;
            self.showRefreshButton = YES;
        }
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberOfTableRow;
}

- (IBAction)fundityFastPayTouchUpInside:(id)sender {
    [[UIHelper sharedInstance] showPaymentEventInView:self.view spinnerOffset:CGPointMake(0, self.tableView.contentOffset.y) successDialogTitle:@"Payment Error" successDialogMessage:@"No monthly payments necessary."];
}

- (IBAction)applyNewLoanTouchUpInside:(id)sender {
    // Used segue
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.showRefreshButton) {
        return CGRectGetHeight(self.view.frame);
    } else {
        return 0;
    }
}

#pragma mark - Private
- (void)logout {
    [[UserAccountManager sharedInstance] logout];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
