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

@property (weak, nonatomic) IBOutlet UIView *signInDialog;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSignInEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSignInPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSignIn;
@property (weak, nonatomic) IBOutlet UIButton *btnCancelSignIn;


- (IBAction)signupButtonPressed:(id)sender;
- (IBAction)showSignInDialogButtonPressed:(id)sender;
- (IBAction)continueWithoutAccountTouchUpInside:(id)sender;
- (IBAction)signInTouchUpInside:(id)sender;
- (IBAction)signInCancelTouchUpInside:(id)sender;

@end
