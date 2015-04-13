//
//  LoginViewController.h
//  MasterCard
//
//  Created by Justin Yek on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *buttonCreateAcct;
@property (weak, nonatomic) IBOutlet UIButton *buttonSignIn;

- (IBAction)signupButtonPressed:(id)sender;
- (IBAction)continueWithoutAccountTouchUpInside:(id)sender;

@end
