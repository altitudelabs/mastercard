//
//  BorrowerPayLoanViewController.h
//  MasterCard
//
//  Created by Altitude Labs on 21/3/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BorrowerProfileViewController.h"

@protocol BorrowerPayLoanViewControllerDelegate <NSObject>

- (void) popback;

@end

@interface BorrowerPayLoanViewController : UIViewController

@property (strong, nonatomic) BorrowerProfileViewController *borrowerProfileViewController;
- (IBAction)btnCancelTouchUpInside:(id)sender;
- (IBAction)btnConfirmTouchUpInside:(id)sender;

@property (strong, nonatomic) id<BorrowerPayLoanViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end
