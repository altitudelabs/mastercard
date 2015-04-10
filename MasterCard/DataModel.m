//
//  DataModel.m
//  MasterCard
//
//  Created by Altitude Labs on 10/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

NSString* const KeyCompanyName = @"KeyCompanyName";
NSString* const KeyCompanyDesciption = @"KeyCompanyDesciption";
NSString* const KeyLoanAmt = @"KeyLoanAmt";
NSString* const KeyLoanReturnRate = @"KeyLoanReturnRate";
NSString* const KeyLoanerRisk = @"KeyLoanerRisk";
NSString* const KeyLoanTerm = @"KeyLoanTerm";

NSString* const KeyLoanerImg = @"KeyLoanerImg";
NSString* const KeyCompanyDetails = @"KeyCompanyDetails";
NSString* const KeyLenderNumber = @"KeyLenderNumber";
NSString* const KeyLendedMoney = @"KeyLendedMoney";
NSString* const KeyLoanerCountry = @"KeyLoanerCountry";
NSString* const KeyFundityScore = @"KeyFundityScore";
NSString* const KeyFundityMatchScore = @"KeyFundityMatchScore";

+ (DataModel*)sharedInstance {
    static DataModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataModel alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        // Init loaner data
        self.loanerDatas = @[
                             @{ KeyCompanyName: @"Pestona Family Winery",
                                KeyCompanyDesciption : @"Winery construction and development",
                                KeyLoanAmt: @100000,
                                KeyLoanReturnRate: @20,
                                KeyLoanerRisk: @"C-",
                                KeyLoanTerm: @"2 Years",
                                KeyLoanerImg: @"Pestona Family Winery.jpeg",
                                KeyCompanyDetails: @"Pestona Family Winery has been in the winemaking and distribution business for over 50 years. We are a Sonoma based vineyard producing a Bordeaux style blend based on a Provence Cabernet Savingon.",
                                KeyLenderNumber: @22,
                                KeyLendedMoney: @6000,
                                KeyLoanerCountry: @"Hong Kong",
                                KeyFundityScore: @9.1,
                                KeyFundityMatchScore: @2.3
                                },
                             @{ KeyCompanyName: @"Bailey & Martin Inc",
                                KeyCompanyDesciption : @"Clothing design and manufacturing",
                                KeyLoanAmt: @50000,
                                KeyLoanReturnRate: @4,
                                KeyLoanerRisk: @"B+",
                                KeyLoanTerm: @"6 Months"
                                },
                             @{ KeyCompanyName: @"Daylight Laundry Company",
                                KeyCompanyDesciption : @"Growth Capital",
                                KeyLoanAmt: @80000,
                                KeyLoanReturnRate: @6,
                                KeyLoanerRisk: @"B",
                                KeyLoanTerm: @"1 Year"
                                },
                             @{ KeyCompanyName: @"Biomedic Sequencing Group",
                                KeyCompanyDesciption : @"Research and Development",
                                KeyLoanAmt: @500000,
                                KeyLoanReturnRate: @15,
                                KeyLoanerRisk: @"D",
                                KeyLoanTerm: @"2 Years"
                                },
                             @{ KeyCompanyName: @"Micro Unity Shipping Company",
                                KeyCompanyDesciption : @"Production and shipping",
                                KeyLoanAmt: @300000,
                                KeyLoanReturnRate: @2,
                                KeyLoanerRisk: @"A-",
                                KeyLoanTerm: @"1 Years"
                                },
                             @{ KeyCompanyName: @"Big Lifting Force Inc",
                                KeyCompanyDesciption : @"Regional Team Expansion",
                                KeyLoanAmt: @200000,
                                KeyLoanReturnRate: @3,
                                KeyLoanerRisk: @"A-",
                                KeyLoanTerm: @"9 Months"
                                },
                             @{ KeyCompanyName: @"Lumina Cab Company",
                                KeyCompanyDesciption : @"Working Capital",
                                KeyLoanAmt: @1000000,
                                KeyLoanReturnRate: @5,
                                KeyLoanerRisk: @"C",
                                KeyLoanTerm: @"3 Years"
                                },
                             ];
    }
    return self;
}

@end
