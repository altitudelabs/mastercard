//
//  LoginViewController.h
//  MasterCard
//
//  Created by Justin Yek on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

- (IBAction)signupButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnLender;
@property (weak, nonatomic) IBOutlet UIButton *btnBorrower;

@property (weak, nonatomic) IBOutlet UITextField *btnUsername;
@property (weak, nonatomic) IBOutlet UITextField *btnPassword;

- (IBAction)btnLenderTouchUpInside:(id)sender;
- (IBAction)btnBorrowerTouchUpInside:(id)sender;

@end
