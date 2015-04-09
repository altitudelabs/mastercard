//
//  LoanRequestTableViewCell.m
//  MasterCard
//
//  Created by Altitude Labs on 9/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "LoanRequestTableViewCell.h"

@interface LoanRequestTableViewCell ()

@end

@implementation LoanRequestTableViewCell

- (void)awakeFromNib {
    self.cellNumberLabel.text = [NSString stringWithFormat:@"%ld", (long)self.cellNumber];
    
}

- (void)render {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
