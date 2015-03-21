//
//  DataManager.h
//  MasterCard
//
//  Created by Justin Yek on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataManager : NSObject <NSXMLParserDelegate>

@property (nonatomic, assign) NSInteger lentAmt;
@property (nonatomic, assign) NSInteger borrowedAmt;
@property (nonatomic, assign) NSInteger requestedAmt;
@property (nonatomic, assign) double monthlyPayment;
@property (nonatomic, assign) double borrowerInterest;
@property (nonatomic, assign) double borrowerTenor;

+ (DataManager*) sharedInstance;

- (NSInteger)lend:(NSInteger)amount;
- (NSInteger)request:(NSInteger)amount;

- (void)moneysendApi;
- (void)fraudApi;
- (void)matchApi;
- (void)merchantCheckoutApiWithViewController:(UIViewController*)vc;

@end
