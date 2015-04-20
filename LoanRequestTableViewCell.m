//
//  LoanRequestTableViewCell.m
//  MasterCard
//
//  Created by Altitude Labs on 9/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "LoanRequestTableViewCell.h"
#import "DataModel.h"
#import "AppConfig.h"

@interface LoanRequestTableViewCell ()
@property (assign, nonatomic) BOOL iphone6OrAbove;
@end

@implementation LoanRequestTableViewCell

#pragma mark - Public

- (void)awakeFromNib {
    UIScreen *mainScreen = [UIScreen mainScreen];
    if (mainScreen.bounds.size.width > 320) {
        self.iphone6OrAbove = YES;
    } else {
        self.iphone6OrAbove = NO;
    }
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
    
    if (self.iphone6OrAbove) {
//        self.companyNameHeight.constant = 25;x
    } else { // iPhone 5
        self.companyNameHeight.constant = 20;
        self.companyDescriptionHeight.constant = 16;
        // Adjust font size
        self.companyNameLabel.font = [UIFont fontWithName:UIFontBold size:14];
        self.CompanyDescriptionLabel.font = [UIFont fontWithName:UIFontRegular size:13];
        self.amountTextLabel.font = [UIFont fontWithName:UIFontSemiBold size:13];
        self.rateTextLabel.font = [UIFont fontWithName:UIFontSemiBold size:13];
        self.riskTextLabel.font = [UIFont fontWithName:UIFontSemiBold size:13];
        self.termTextLabel.font = [UIFont fontWithName:UIFontSemiBold size:13];
        self.amountLabel.font = [UIFont fontWithName:UIFontSemiBold size:13];
        self.rateLabel.font = [UIFont fontWithName:UIFontSemiBold size:13];
        self.riskLabel.font = [UIFont fontWithName:UIFontSemiBold size:13];
        self.termLabel.font = [UIFont fontWithName:UIFontSemiBold size:13];
    }
    
//    self.companyNameLabel.numberOfLines = 0;
//    [self.companyNameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//    [self.companyNameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//    [self.companyNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.companyNameLabel sizeToFit];
}

@end
