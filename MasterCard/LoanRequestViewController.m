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
#import "DataModel.h"
#import "AppConfig.h"

@interface LoanRequestViewController ()

@end

@implementation LoanRequestViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.data = [[DataModel sharedInstance] loanerDatas];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        self.data = [[DataModel sharedInstance] loanerDatas];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderNavigationBar];
    [self render];
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

- (void)render {
    [self.tableView registerNib:[UINib nibWithNibName:@"LoanRequestTableViewCell" bundle:nil] forCellReuseIdentifier:[LoanRequestTableViewCell assignIdentifier]];
}

- (UIView *)footerView {
    UIButton *footer = [UIButton buttonWithType:UIButtonTypeCustom];
    [footer setTitle:@"Sort/Filter" forState:UIControlStateNormal];
    [footer setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    footer.backgroundColor = ColorGray;
    [footer setTitleColor:TextColorDark forState:UIControlStateNormal];
    footer.titleLabel.font = [UIFont fontWithName:UIFontRegularRoman size:13];
    
    CALayer *rightBorder = [CALayer layer];
    rightBorder.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    rightBorder.borderWidth = 1;
    rightBorder.frame = CGRectMake(0, -1, CGRectGetWidth(self.tableView.frame), 1);
    
    [footer.layer addSublayer:rightBorder];
    
    return footer;
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self footerView];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoanerDetailViewController *vc = (LoanerDetailViewController *)[sb instantiateViewControllerWithIdentifier:@"LoanerDetailViewController"];
    vc.data = [self.data objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Private
- (void)doneButtonTouchUpInside:(id)sender {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    LoanerDetailViewController *vc = (LoanerDetailViewController *)[sb instantiateViewControllerWithIdentifier:@"LoanerDetailViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
