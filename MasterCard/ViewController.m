//
//  ViewController.m
//  MasterCard
//
//  Created by Altitude Labs on 20/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[DataManager sharedInstance] request:4000];
    [[DataManager sharedInstance] lend:4000];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
