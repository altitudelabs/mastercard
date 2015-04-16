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
                                KeyLoanTerm: @"6 Months",
                                
                                KeyLoanerImg: @"Bailey & Martin.jpg",
                                KeyCompanyDetails: @"Bailey & Martin is an American retailer that focuses on luxury urban wear for young consumers and is headquartered in Orange County, California. With 5 locations in the United States, Bailey & Martin is looking into smarter and more efficient ways to produce our products",
                                KeyLenderNumber: @22,
                                KeyLendedMoney: @6000,
                                KeyLoanerCountry: @"Hong Kong",
                                KeyFundityScore: @9.1,
                                KeyFundityMatchScore: @2.3
                                },
                             @{ KeyCompanyName: @"Daylight Laundry Company",
                                KeyCompanyDesciption : @"Growth Capital",
                                KeyLoanAmt: @80000,
                                KeyLoanReturnRate: @6,
                                KeyLoanerRisk: @"B",
                                KeyLoanTerm: @"1 Year",
                                
                                KeyLoanerImg: @" The Daylight Laundry Company .jpeg",
                                KeyCompanyDetails: @"The Daylight Laundry Company has been a long standing commercial laundry company in Hong Kong servicing hotel, retail, clubhouse and airline industries. With 200 staff on hand, the company is looking to expand its outlets to new residential areas and purchase better hardware for processing.",
                                KeyLenderNumber: @22,
                                KeyLendedMoney: @6000,
                                KeyLoanerCountry: @"Hong Kong",
                                KeyFundityScore: @9.1,
                                KeyFundityMatchScore: @2.3
                                },
                             @{ KeyCompanyName: @"Biomedic Sequencing Group",
                                KeyCompanyDesciption : @"Research and Development",
                                KeyLoanAmt: @500000,
                                KeyLoanReturnRate: @15,
                                KeyLoanerRisk: @"D",
                                KeyLoanTerm: @"2 Years",
                                
                                KeyLoanerImg: @"The Biomedic Sequencing Group.jpg",
                                KeyCompanyDetails: @"The Biomedic Sequencing Group is a bioinformatics company focusing on DNA sequencing. Our R&D lab based in Hong Kong will need substantial support in the realm of manpower and research. BSG is planning a roll out DNA diagnostic kits in 2016.",
                                KeyLenderNumber: @22,
                                KeyLendedMoney: @6000,
                                KeyLoanerCountry: @"Hong Kong",
                                KeyFundityScore: @9.1,
                                KeyFundityMatchScore: @2.3
                                },
                             @{ KeyCompanyName: @"Micro Unity Shipping Company",
                                KeyCompanyDesciption : @"Production and shipping",
                                KeyLoanAmt: @300000,
                                KeyLoanReturnRate: @2,
                                KeyLoanerRisk: @"A-",
                                KeyLoanTerm: @"1 Years",
                                
                                KeyLoanerImg: @"Micro Unity Shipping Company.jpg",
                                KeyCompanyDetails: @"Micro Unity Shipping Company is a boutique shipping and transportation conglomerate. Our container ships and bulk carriers are seen at major ports of the world. We are looking to streamline our logistics processes to provide better returns to our stakeholders.",
                                KeyLenderNumber: @22,
                                KeyLendedMoney: @6000,
                                KeyLoanerCountry: @"Hong Kong",
                                KeyFundityScore: @9.1,
                                KeyFundityMatchScore: @2.3
                                },
                             @{ KeyCompanyName: @"Big Lifting Force Inc",
                                KeyCompanyDesciption : @"Regional Team Expansion",
                                KeyLoanAmt: @200000,
                                KeyLoanReturnRate: @3,
                                KeyLoanerRisk: @"A-",
                                KeyLoanTerm: @"9 Months",
                                
                                KeyLoanerImg: @"At the Big Lifting Force Inc.png",
                                KeyCompanyDetails: @"At the Big Lifting Force Inc. we provide a unique experience of moving to your new home or office. We have been serving the local community for over 10 years and our guys are the best movers there is to find. Our goal is to franchise the brand to ASEAN countries and we are looking forward to kickstarting this expansion.",
                                KeyLenderNumber: @22,
                                KeyLendedMoney: @6000,
                                KeyLoanerCountry: @"Hong Kong",
                                KeyFundityScore: @9.1,
                                KeyFundityMatchScore: @2.3
                                },
                             @{ KeyCompanyName: @"Lumina Cab Company",
                                KeyCompanyDesciption : @"Working Capital",
                                KeyLoanAmt: @1000000,
                                KeyLoanReturnRate: @5,
                                KeyLoanerRisk: @"C",
                                KeyLoanTerm: @"3 Years",
                                
                                KeyLoanerImg: @"The Lumina Cab Company.jpg",
                                KeyCompanyDetails: @"The Lumina Cab Company is a prominent taxi licensing and call and demand taxi servicing company. Our vehicles are well serviced and our fleet runs on petrol. We would like to transition into all electric in the coming few years for better returns.",
                                KeyLenderNumber: @22,
                                KeyLendedMoney: @6000,
                                KeyLoanerCountry: @"Hong Kong",
                                KeyFundityScore: @9.1,
                                KeyFundityMatchScore: @2.3
                                },
                             ];
    }
    return self;
}

@end
