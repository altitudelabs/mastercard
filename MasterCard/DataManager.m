//
//  DataManager.m
//  MasterCard
//
//  Created by Justin Yek on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "DataManager.h"
#import "AFHTTPRequestOperationManager.h"

@implementation DataManager

@synthesize lentAmt;
@synthesize borrowedAmt;
@synthesize requestedAmt;
@synthesize monthlyPayment;
@synthesize borrowerInterest;
@synthesize borrowerTenor;

+ (DataManager*)sharedInstance {
    static DataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataManager alloc] init];
    });
    
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.lentAmt = 120,000;
        self.borrowedAmt = 0;
        self.requestedAmt = 0;
        self.borrowerInterest = 0.065;
    }
    return self;
}

- (NSInteger)lend:(NSInteger)amount {
    self.lentAmt += amount;
    self.borrowedAmt += amount;
    [self updateMonthlyPayment];
    return lentAmt;
}

- (NSInteger)request:(NSInteger)amount {
    self.requestedAmt += amount;
    return requestedAmt;
}

- (void)updateMonthlyPayment {
    self.monthlyPayment = (self.borrowedAmt * self.borrowerInterest/12)/(1-(1+pow(self.borrowerInterest/12,self.borrowerTenor*12)));
}

- (void)test{
    NSLog(@"TEST");
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager]
    
    NSDictionary *parameters = @{@"foo": @"bar"};
    [manager POST:@"http://example.com/resources.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
