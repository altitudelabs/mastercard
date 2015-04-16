//
//  LoanerDetailViewController.m
//  MasterCard
//
//  Created by Altitude Labs on 10/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "LoanerDetailViewController.h"
#import "DataModel.h"
#import "AppConfig.h"
#import <Masonry.h>

@interface LoanerDetailViewController ()

@end

@implementation LoanerDetailViewController

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
    lblTitle.text = @"Loan Detail";
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.font = [UIFont fontWithName:UIFontRegularBook size:19.0];
    [lblTitle sizeToFit];
    self.navigationItem.titleView = lblTitle;
}

- (void)render {
    // Remove bottom border of last table cell
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    
    // TextField borders
    self.containerViewLendAmount.layer.borderWidth = 1;
    self.containerViewLendAmount.layer.borderColor = ColorTextFieldBorder.CGColor;
    self.containerViewLendRate.layer.borderWidth = 1;
    self.containerViewLendRate.layer.borderColor = ColorTextFieldBorder.CGColor;
    
    NSString *loanerImg = [self.data objectForKey:KeyLoanerImg];
    NSString *loanerName = [self.data objectForKey:KeyCompanyName];
    NSString *loanerDescription = [self.data objectForKey:KeyCompanyDesciption];
    NSString *loanerDetails = [self.data objectForKey:KeyCompanyDetails];
    NSInteger lenderNumber = [[self.data objectForKey:KeyLenderNumber] integerValue];
    NSInteger lendedMoney = [[self.data objectForKey:KeyLendedMoney] integerValue];
    NSInteger loanAmount = [[self.data objectForKey:KeyLoanAmt] integerValue];
    NSString *country = [self.data objectForKey:KeyLoanerCountry];
    NSInteger fundityScore = [[self.data objectForKey:KeyFundityScore] integerValue];
    
    self.imgView.image = [UIImage imageNamed:loanerImg];
    self.LoanerName.text = loanerName;
    self.LoanerDescription.text = loanerDescription;
    self.LoanerDetails.text = loanerDetails;
    [self.LoanerDetails sizeToFit];
    self.LoanerDetails.numberOfLines = 3;
    self.lenderNumValue.text = [NSString stringWithFormat:@"%ld", lenderNumber];
    self.lenderNum.text = lenderNumber > 1 ? @"Lenders" : @"Lender";
    self.countryLabel.text = country;
    
    [self renderProgressBarWithPercentage:(float)lendedMoney / (float)loanAmount];
    
    self.fundityScore.text = [NSString stringWithFormat:@"%ld.0", fundityScore];
    self.fundityScore.layer.borderWidth = 1;
    self.fundityScore.layer.borderColor = [[UIColor colorWithRed:255/255.0 green:154/255.0 blue:42/255.0 alpha:1] CGColor];
    
    [self.buttonLendNow setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
}

- (void)renderProgressBarWithPercentage:(CGFloat)percent {
    self.progressBar.clipsToBounds = YES;
    self.progressBar.layer.cornerRadius = 5;
    self.progressBar.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    
    UIView *greenBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.progressBar.frame) * percent, CGRectGetHeight(self.progressBar.frame))];
    greenBar.backgroundColor = [UIColor colorWithRed:90/255.0 green:233/255.0 blue:144/255.0 alpha:1];
    greenBar.clipsToBounds = YES;
    greenBar.layer.cornerRadius = 5;
    [self.progressBar addSubview:greenBar];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (IBAction)lendNowTouchUpInside:(id)sender {
}
@end
