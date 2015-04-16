//
//  LoanRequestTableViewCell.m
//  MasterCard
//
//  Created by Altitude Labs on 9/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "LoanRequestTableViewCell.h"
#import "DataModel.h"

@interface LoanRequestTableViewCell ()

@end

@implementation LoanRequestTableViewCell

#pragma mark - Public

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (NSString *)assignIdentifier {
    return @"LoanRequestTableViewCell";
}

- (void)updateLayout {
    self.cellNumberLabel.text = [NSString stringWithFormat:@"%i", (int)_cellNumber];
    
    NSString *loanerName = [self.data objectForKey:KeyCompanyName];
    NSString *loanerDescription = [self.data objectForKey:KeyCompanyDesciption];
    NSInteger loanAmt = [[self.data objectForKey:KeyLoanAmt] integerValue];
    NSInteger loanReturnRate = [[self.data objectForKey:KeyLoanReturnRate] integerValue];
    NSString *loanRisk = [self.data objectForKey:KeyLoanerRisk];
    NSString *loanTerm = [self.data objectForKey:KeyLoanTerm];
    
    self.companyNameLabel.text = loanerName;
    self.CompanyDescriptionLabel.text = loanerDescription;
    self.amountLabel.text = [NSString stringWithFormat:@"$%ld", (long)loanAmt];
    self.amountLabel.adjustsFontSizeToFitWidth = YES;
    self.rateLabel.text = [NSString stringWithFormat:@"%ld%%", (long)loanReturnRate];
    self.riskLabel.text = loanRisk;
    self.termLabel.text = loanTerm;
}

@end
