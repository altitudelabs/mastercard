//
//  DataManager.m
//  MasterCard
//
//  Created by Justin Yek on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "DataManager.h"
#import "MPManager.h"
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

- (void)merchantCheckoutApiWithViewController:(UIViewController*)vc {
    MPManager *manager = [MPManager sharedInstance];
    [manager pairCheckoutForOrder:@"123498371234212" showInViewController:vc];
}

- (void)moneysendApi {
    NSInteger randomSeed = arc4random() % 100000 + 1000000;
    NSString *randomString = [NSString stringWithFormat:@"123456789012%ld", (long)randomSeed];
    NSString *xmlRequestString = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\
    <TransferRequest>\
    <LocalDate>0612</LocalDate>\
    <LocalTime>161222</LocalTime>\
    <TransactionReference>%@</TransactionReference>\
    <SenderName>John Doe</SenderName>\
    <SenderAddress>\
    <Line1>123 Main Street</Line1>\
    <City>Arlington</City>\
    <CountrySubdivision>VA</CountrySubdivision>\
    <PostalCode>22207</PostalCode>\
    <Country>USA</Country>\
    </SenderAddress>\
    <FundingCard>\
    <AccountNumber>5184680430000014</AccountNumber>\
    <ExpiryMonth>11</ExpiryMonth>\
    <ExpiryYear>2016</ExpiryYear>\
    </FundingCard>\
    <FundingMasterCardAssignedId>123456</FundingMasterCardAssignedId>\
    <FundingAmount>\
    <Value>15000</Value>\
    <Currency>840</Currency>\
    </FundingAmount>\
    <ReceiverName>Jose Lopez</ReceiverName>\
    <ReceiverAddress>\
    <Line1>Pueblo Street</Line1>\
    <Line2>PO BOX 12</Line2>\
    <City>El PASO</City>\
    <CountrySubdivision>TX</CountrySubdivision>\
    <PostalCode>79906</PostalCode>\
    <Country>USA</Country>\
    </ReceiverAddress>\
    <ReceiverPhone>1800639426</ReceiverPhone>\
    <ReceivingCard>\
    <AccountNumber>5184680430000006</AccountNumber>\
    </ReceivingCard>\
    <ReceivingAmount>\
    <Value>182206</Value>\
    <Currency>484</Currency>\
    </ReceivingAmount>\
    <Channel>W</Channel>\
    <UCAFSupport>true</UCAFSupport>\
    <ICA>009674</ICA>\
    <ProcessorId>9000000442</ProcessorId>\
    <RoutingAndTransitNumber>990442082</RoutingAndTransitNumber>\
    <CardAcceptor>\
    <Name>My Local Bank</Name>\
    <City>Saint Louis</City>\
    <State>MO</State>\
    <PostalCode>63101</PostalCode>\
    <Country>USA</Country>\
    </CardAcceptor>\
    <TransactionDesc>P2P</TransactionDesc>\
    <MerchantId>123456</MerchantId>\
    </TransferRequest>", randomString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://dmartin.org:8021/moneysend/v2/transfer?Format=XML"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:[xmlRequestString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/xml" forHTTPHeaderField:@"content-type"];
    
    NSOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Moneysend API Error");
    }];
    
    [manager.operationQueue addOperation:operation];
}

- (void)fraudApi {
    NSString *xmlRequestString = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\
    <ScoreLookupRequest>\
    <TransactionDetail>\
    <CustomerIdentifier>1996</CustomerIdentifier>\
    <MerchantIdentifier>123</MerchantIdentifier>\
    <AccountNumber>5555555555555555555</AccountNumber>\
    <AccountPrefix>555555</AccountPrefix>\
    <AccountSuffix>5555</AccountSuffix>\
    <TransactionAmount>62500</TransactionAmount>\
    <TransactionDate>1231</TransactionDate>\
    <TransactionTime>035959</TransactionTime>\
    <BankNetReferenceNumber>abcABC123</BankNetReferenceNumber>\
    <Stan>123456</Stan>\
    </TransactionDetail>\
    </ScoreLookupRequest>";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://dmartin.org:8021/fraud/merchantscoring/v1/score-lookup?Format=XML"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:[xmlRequestString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/xml" forHTTPHeaderField:@"content-type"];
    
    NSOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Fraud API Success %@", responseObject);
        NSXMLParser *parser = responseObject;
        parser.delegate = self;
        if (![parser parse]) {
            // handle parsing error here
        } else {
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fraud API Error %@", error);
    }];
    
    [manager.operationQueue addOperation:operation];
}

- (void)matchApi {
    NSString *xmlRequestString = @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
    <ns2:TerminationInquiryRequest xmlns:ns2=\"http://mastercard.com/termination\">\
    <AcquirerId>1996</AcquirerId>\
    <Merchant>\
    <Name>TEST</Name>\
    <Address>\
    <Line1>TEST</Line1>\
    <City>St. Louis</City>\
    <CountrySubdivision>MO</CountrySubdivision>\
    <PostalCode>55555</PostalCode>\
    <Country>USA</Country>\
    </Address>\
    <Principal>\
    <FirstName>John</FirstName>\
    <LastName>Smith</LastName>\
    <Address>\
    <CountrySubdivision>MO</CountrySubdivision>\
    <PostalCode>55555</PostalCode>\
    <Country>USA</Country>\
    </Address>\
    </Principal>\
    </Merchant>\
    </ns2:TerminationInquiryRequest>";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://dmartin.org:8021/fraud/merchant/v1/termination-inquiry?Format=XML&PageOffset=0&PageLength=10"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:[xmlRequestString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/xml" forHTTPHeaderField:@"content-type"];
    
    NSOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Match API Success %@", responseObject);
        NSXMLParser *parser = responseObject;
        parser.delegate = self;
        if (![parser parse]) {
            // handle parsing error here
        } else {
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Match API Error %@", error);
    }];
    
    [manager.operationQueue addOperation:operation];
}
                                  
- (void)lostAccountApi {
    NSString *xmlRequestString = @"<AccountInquiry>\
    <AccountNumber>5343434343434343</AccountNumber>\
    </AccountInquiry>";
      
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
      
    NSURL *url = [[NSURL alloc] initWithString:@"http://dmartin.org:8021/fraud/loststolen/v1/account-inquiry?Format=XML"];
      
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:[xmlRequestString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/xml" forHTTPHeaderField:@"content-type"];
      
    NSOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Lost Account API Success %@", responseObject);
        NSXMLParser *parser = responseObject;
        parser.delegate = self;
        if (![parser parse]) {
            // handle parsing error here
        } else {
              
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Lost Account API Error %@", error);
    }];
      
    [manager.operationQueue addOperation:operation];
}
                                  
@end
