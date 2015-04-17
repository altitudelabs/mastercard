//
//  DeviceHelper.m
//  MasterCard
//
//  Created by Altitude Labs on 17/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "DeviceHelper.h"
#import <SystemConfiguration/SCNetworkReachability.h>

@implementation DeviceHelper

+ (BOOL)isNetworkAvailable {
    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityRef address;
    address = SCNetworkReachabilityCreateWithName(NULL, "www.apple.com" );
    Boolean success = SCNetworkReachabilityGetFlags(address, &flags);
    CFRelease(address);
    
    bool canReach = success
    && !(flags & kSCNetworkReachabilityFlagsConnectionRequired)
    && (flags & kSCNetworkReachabilityFlagsReachable);
    
    return canReach;
}

+ (NSString *)documentsPathForFileName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}

@end
