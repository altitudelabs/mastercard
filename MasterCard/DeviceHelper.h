//
//  DeviceHelper.h
//  MasterCard
//
//  Created by Altitude Labs on 17/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceHelper : NSObject

+ (BOOL)isNetworkAvailable;
+ (NSString *)documentsPathForFileName:(NSString *)name;

@end
