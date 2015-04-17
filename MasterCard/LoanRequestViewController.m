//
//  LoanRequestViewController.m
//  MasterCard
//
//  Created by Altitude Labs on 9/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "LoanRequestViewController.h"
#import "LoanRequestTableViewCell.h"
#import "LoanerDetailViewController.h"
#import "MyProfileTableViewController.h"
#import "DataModel.h"
#import "AppConfig.h"
#import <Masonry.h>

@interface LoanRequestViewController ()
@end

@implementation LoanRequestViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self prepare];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self prepare];
    }
    return self;
}

- (void)prepare {
    self.data = [[[DataModel sharedInstance] loanerDatas] copy];
    self.loggedIn = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderNavigationBar];
    [self render];
    
    NSLog(@"%s : userData: %@", __func__, self.userData);
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
    
    // Right button
    [self showRightButtonInNavigationBar:self.loggedIn];
}

- (void)showRightButtonInNavigationBar:(BOOL)show {
    if (show) {
        // Right button
        UIButton* buttonDone = [UIButton buttonWithType: UIButtonTypeCustom];
        buttonDone.frame = CGRectMake(0, 0, 30, 30);
        buttonDone.titleLabel.font = [UIFont fontWithName:UIFontRegularBook size:12];
        //    [buttonDone setTitle:@" " forState:UIControlStateNormal];
        [buttonDone setImage:[UIImage imageNamed:@"profile.png"] forState:UIControlStateNormal];
        [buttonDone setTitle:@"" forState:UIControlStateNormal];
        [buttonDone addTarget:self action:@selector(doneButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:buttonDone];
        self.navigationItem.rightBarButtonItem = anotherButton;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)render {
    [self.tableView registerNib:[UINib nibWithNibName:@"LoanRequestTableViewCell" bundle:nil] forCellReuseIdentifier:[LoanRequestTableViewCell assignIdentifier]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LoanRequestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[LoanRequestTableViewCell assignIdentifier] forIndexPath:indexPath];
    cell.cellNumber = indexPath.row + 1;
    cell.data = [self.data objectAtIndex:indexPath.row];
    [cell updateLayout];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoanerDetailViewController *vc = (LoanerDetailViewController *)[sb instantiateViewControllerWithIdentifier:@"LoanerDetailViewController"];
    vc.data = [self.data objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Private

- (void)doneButtonTouchUpInside:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyProfileTableViewController *vc = (MyProfileTableViewController *)[sb instantiateViewControllerWithIdentifier:@"MyProfileTableViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Public

- (void)filterByAmount {
    NSArray *sortedArray = [self.data sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *p1, NSDictionary *p2){
        NSInteger amount1 = [[p1 objectForKey:KeyLoanAmt] integerValue];
        NSInteger amount2 = [[p2 objectForKey:KeyLoanAmt] integerValue];
        return amount1  < amount2;
    }];
    self.data = sortedArray;
    [self.tableView reloadData];
}

- (void)filterByRate {
    NSArray *sortedArray = [self.data sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *p1, NSDictionary *p2){
        NSInteger amount1 = [[p1 objectForKey:KeyLoanReturnRate] integerValue];
        NSInteger amount2 = [[p2 objectForKey:KeyLoanReturnRate] integerValue];
        return amount1  < amount2;
    }];
    self.data = sortedArray;
    [self.tableView reloadData];
}

- (void)filterByNone {
    self.data = [[[DataModel sharedInstance] loanerDatas] copy];
    [self.tableView reloadData];
}

#pragma mark - Accessors

- (void)setLoggedIn:(BOOL)loggedIn {
    _loggedIn = loggedIn;
    [self showRightButtonInNavigationBar:_loggedIn];
}

@end
