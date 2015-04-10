//
//  LoanRequestTableViewCell.h
//  MasterCard
//
//  Created by Altitude Labs on 9/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanRequestTableViewCell : UITableViewCell
@property (assign, nonatomic) NSInteger cellNumber;
@property (strong, nonatomic) NSDictionary *data;

@property (weak, nonatomic) IBOutlet UILabel *cellNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *CompanyDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *arrowButton;


@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *riskLabel;
@property (weak, nonatomic) IBOutlet UILabel *termLabel;

+ (NSString *)assignIdentifier;
- (void)updateLayout;

@end
