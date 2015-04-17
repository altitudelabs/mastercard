//
//  UIHelper.m
//  MasterCard
//
//  Created by Altitude Labs on 17/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "UIHelper.h"

NSString* const KeySpinner = @"spinner";
NSString* const KeyView = @"view";

@interface UIHelper ()
@property (strong, nonatomic) NSMutableSet *spinnersOfViews;
@end

@implementation UIHelper

+ (UIHelper*)sharedInstance {
    static UIHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UIHelper alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.spinnersOfViews = [NSMutableSet set];
    }
    return self;
}

- (void)showLoadingSpinnerInView:(UIView *)view {
    UIView *spinner = [self loadingSpinner];
    spinner.center = view.center;
    [view addSubview:spinner];
    
    view.userInteractionEnabled = NO;
    
    NSDictionary *saveDict = @{KeySpinner : spinner,
                               KeyView : view};
    [self.spinnersOfViews addObject:saveDict];
}

- (void)hideLoadingSpinnerInView:(UIView *)view {
    view.userInteractionEnabled = YES;
    
    NSArray *allSaveDicts = [self.spinnersOfViews allObjects];
    for (NSDictionary *saveDict in allSaveDicts) {
        if ([saveDict objectForKey:KeyView] == view) {
            UIView *theSpinner = [saveDict objectForKey:KeySpinner];
            [theSpinner removeFromSuperview];
            [self.spinnersOfViews removeObject:saveDict];
            break;
        }
    }
}

#pragma mark - Private

- (UIView *)loadingSpinner {
    UIView *loadingBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    loadingBox.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    loadingBox.clipsToBounds = YES;
    loadingBox.layer.cornerRadius = 8;
    
    UIActivityIndicatorView * spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.center = loadingBox.center;
    [spinner startAnimating];
    [loadingBox addSubview:spinner];
    
    return loadingBox;
}

@end
