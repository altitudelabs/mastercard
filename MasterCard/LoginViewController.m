//
//  LoginViewController.m
//  MasterCard
//
//  Created by Justin Yek on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "LoginViewController.h"
#import "LenderMainViewController.h"
#import "BorrowerMainViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
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

- (IBAction)signupButtonPressed:(id)sender {
    UIViewController *lenderMainVC = [[LenderMainViewController alloc] init];
    [self.navigationController pushViewController:lenderMainVC animated:YES];
}

@end
