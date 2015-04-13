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
    NSString *loanerImg = [self.data objectForKey:KeyLoanerImg];
    NSString *loanerName = [self.data objectForKey:KeyCompanyName];
    NSString *loanerDescription = [self.data objectForKey:KeyCompanyDesciption];
    NSString *loanerDetails = [self.data objectForKey:KeyCompanyDetails];
    NSInteger lenderNumber = [[self.data objectForKey:KeyLenderNumber] integerValue];
    NSInteger lendedMoney = [[self.data objectForKey:KeyLendedMoney] integerValue];
    NSInteger loanAmount = [[self.data objectForKey:KeyLoanAmt] integerValue];
    NSString *country = [self.data objectForKey:KeyLoanerCountry];
    NSInteger fundityScore = [[self.data objectForKey:KeyFundityScore] integerValue];
    NSInteger fundityMatchScore = [[self.data objectForKey:KeyFundityMatchScore] integerValue];
    
    self.imgView.image = [UIImage imageNamed:loanerImg];
    self.LoanerName.text = loanerName;
    self.LoanerDescription.text = loanerDescription;
    self.LoanerDetails.text = loanerDetails;
    [self.LoanerDetails sizeToFit];
    self.LoanerDetails.numberOfLines = 3;
    
    [self renderProgressBarWithPercentage:(float)lendedMoney / (float)loanAmount];
    
    // Render detail data 0.25 | 0.375 | 0.375
    CGFloat segment1Length = 0.25 * CGRectGetWidth(self.detailContainerView.frame);
    CGFloat segment2Length = 0.375 * CGRectGetWidth(self.detailContainerView.frame);
    CGFloat segment3Length = 0.375 * CGRectGetWidth(self.detailContainerView.frame);
    
//    self.lenderNumValue.frame = CGRectMake(0,
//                                           0,
//                                           segment1Length,
//                                           CGRectGetHeight(self.lenderNumValue.frame));
//    self.lenderNum.frame = CGRectMake(CGRectGetMinX(self.lenderNumValue.frame),
//                                      CGRectGetMaxY(self.lenderNumValue.frame),
//                                      segment1Length,
//                                      CGRectGetHeight(self.lenderNum.frame));
//    
//    self.lendedValue.frame = CGRectMake(segment1Length,
//                                        0,
//                                        segment2Length,
//                                        CGRectGetHeight(self.lendedValue.frame));
//    self.lendRequireValue.frame = CGRectMake(CGRectGetMinX(self.lendedValue.frame),
//                                      CGRectGetMaxY(self.lendedValue.frame),
//                                      segment2Length,
//                                      CGRectGetHeight(self.lendRequireValue.frame));
//    
//    self.location.frame = CGRectMake(segment1Length + segment2Length,
//                                        0,
//                                        segment3Length,
//                                        CGRectGetHeight(self.location.frame));
//    self.countryLabel.frame = CGRectMake(CGRectGetMinX(self.location.frame),
//                                             CGRectGetMaxY(self.location.frame),
//                                             segment3Length,
//                                             CGRectGetHeight(self.countryLabel.frame));
    
    
//    [self.lenderNumValue mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(@0);
//        make.top.mas_equalTo(@0);
////        make.width.equalTo([NSNumber numberWithInteger:(NSInteger)segment1Length]);
//        make.height.equalTo(self.lenderNumValue.mas_height);
//    }];
//    [self.lenderNum mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(@0);
//        make.top.mas_equalTo(self.lenderNumValue.mas_bottom).with.offset(0);
////        make.width.equalTo([NSNumber numberWithInteger:(NSInteger)segment1Length]);
//        make.height.equalTo(self.lenderNum.mas_height);
//    }];
//    [self.lendedValue mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.lenderNum.mas_right).with.offset(0);
//        make.top.mas_equalTo(@0);
////        make.width.equalTo([NSNumber numberWithInteger:(NSInteger)segment2Length]);
//        make.height.equalTo(self.lendedValue.mas_height);
//    }];
//    [self.lendRequireValue mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.lendedValue.mas_left).with.offset(0);
//        make.top.mas_equalTo(self.lendedValue.mas_bottom).with.offset(0);
////        make.width.equalTo([NSNumber numberWithInteger:(NSInteger)segment2Length]);
//        make.height.equalTo(self.lendRequireValue.mas_height);
//    }];
//    [self.location mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.lendedValue.mas_right).with.offset(0);
//        make.top.mas_equalTo(@0);
////        make.width.equalTo([NSNumber numberWithInteger:(NSInteger)segment3Length]);
//        make.height.equalTo(self.location.mas_height);
//    }];
//    [self.countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.location.mas_left).with.offset(0);
//        make.top.mas_equalTo(self.location.mas_bottom).with.offset(0);
////        make.width.equalTo([NSNumber numberWithInteger:(NSInteger)segment3Length]);
//        make.height.equalTo(self.countryLabel.mas_height);
//    }];
    
    self.fundityScore.text = [NSString stringWithFormat:@"%ld.0", fundityScore];
    self.fundityScore.layer.borderWidth = 1;
    self.fundityScore.layer.borderColor = [[UIColor colorWithRed:255/255.0 green:154/255.0 blue:42/255.0 alpha:1] CGColor];
    
    self.fundityMatchScore.text = [NSString stringWithFormat:@"%ld", fundityMatchScore];
    self.fundityMatchScore.layer.borderWidth = 1;
    self.fundityMatchScore.layer.borderColor = [[UIColor colorWithRed:65/255.0 green:162/255.0 blue:17/255.0 alpha:1] CGColor];
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
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
}


- (IBAction)lendNowTouchUpInside:(id)sender {
}
@end
