//
//  LenderListViewController.m
//  MasterCard
//
//  Created by Justin Yek on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "LenderMainViewController.h"

@interface LenderMainViewController ()

@end

@implementation LenderMainViewController

@synthesize isLender;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
