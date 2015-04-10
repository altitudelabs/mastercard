//
//  DataModel.h
//  MasterCard
//
//  Created by Altitude Labs on 10/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

extern NSString* const KeyCompanyName;
extern NSString* const KeyCompanyDesciption;
extern NSString* const KeyLoanAmt;
extern NSString* const KeyLoanReturnRate;
extern NSString* const KeyLoanerRisk;
extern NSString* const KeyLoanTerm;

extern NSString* const KeyLoanerImg;
extern NSString* const KeyCompanyDetails;
extern NSString* const KeyLenderNumber;
extern NSString* const KeyLendedMoney;
extern NSString* const KeyLoanerCountry;
extern NSString* const KeyFundityScore;
extern NSString* const KeyFundityMatchScore;

@property (strong, nonatomic) NSArray *loanerDatas;

+ (DataModel*)sharedInstance;

@end
