//
//  AppConfig.h
//  MasterCard
//
//  Created by Altitude Labs on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BorrowerProfileViewController.h"

@interface AppConfig : NSObject

// Color definitions
#define  ColorBlue     [UIColor colorWithRed:58/255.0  green:89/255.0 blue:171/255.0 alpha:1.0]
#define ColorGray   [UIColor colorWithRed:236/255.0  green:236/255.0 blue:236/255.0 alpha:1.0]

#define TextColorLight   [UIColor colorWithRed:153/255.0  green:153/255.0 blue:153/255.0 alpha:1.0]
#define TextColorDark   [UIColor colorWithRed:107/255.0  green:107/255.0 blue:107/255.0 alpha:1.0]

// Font definitions
extern NSString* const UIFontRegularRoman;
extern NSString* const UIFontRegularBook;
extern NSString* const UIFontRegularMedium;

@end
