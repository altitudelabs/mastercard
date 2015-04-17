//
//  BorrowerApplyNewLoanViewController.m
//  MasterCard
//
//  Created by Altitude Labs on 15/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "BorrowerApplyNewLoanViewController.h"
#import "AppConfig.h"
#import <Masonry.h>
#import <CoreFoundation/CoreFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

#define BottomHeight 100

typedef NS_ENUM(NSInteger, UIImagePickerOption) {
    UIImagePickerForVerificationPhoto1 = 1,
    UIImagePickerForVerificationPhoto2 = 2
};

@interface BorrowerApplyNewLoanViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) UIPopoverController *popOverVC;
@property (assign, nonatomic) UIImagePickerOption imagePickerOption;
@end

@implementation BorrowerApplyNewLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderNavigationBar];
    [self render];
}

#pragma mark - Private

- (void)renderNavigationBar {
    // Hide navigation bar
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [self navigationController].navigationBar.barTintColor = ColorBlue;
    [[UINavigationBar appearance] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    // Custom back button for all other pages
    UIImage *backButtonImage = [[UIImage imageNamed:@"back@2x.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, backButtonImage.size.height*2) forBarMetrics:UIBarMetricsDefault];
    
    // Title
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.text = @"New Loan";
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.font = [UIFont fontWithName:UIFontRegularBook size:19.0];
    [lblTitle sizeToFit];
    self.navigationItem.titleView = lblTitle;
}

- (void)render {
    self.contentViewHeight.constant = CGRectGetHeight(self.view.frame) - BottomHeight;
    
    [self renderDots];
    
    // Render textField
    self.textFieldBorrowAmount.layer.borderWidth = 1;
    self.textFieldBorrowAmount.layer.borderColor = ColorTextFieldBorder.CGColor;
    
    self.verificationImageView1.hidden = YES;
    self.verificationImageView2.hidden = YES;
    
    self.textFieldBorrowAmount.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.contentView addGestureRecognizer:tap];
}

- (void)renderDots {
    [self.loanDurationBlock3m mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loanRepaymentDurationContainerView.mas_left);
        make.top.equalTo(self.loanRepaymentDurationLine.mas_top).with.offset(-10);
    }];
    
    [self.loanDurationBlock6m mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([NSNumber numberWithFloat:CGRectGetWidth(self.view.frame) * 0.25 - 7 - CGRectGetWidth(self.loanDurationBlock6m.frame) * 0.25]);
        make.top.equalTo(self.loanRepaymentDurationLine.mas_top).with.offset(-10);
    }];
    
    [self.loanDurationBlock2yr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.loanRepaymentDurationContainerView.mas_centerX);
        make.top.equalTo(self.loanRepaymentDurationLine.mas_top).with.offset(-10);
    }];

    [self.loanDurationBlock3yr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.loanRepaymentDurationLine.mas_right).with.offset(-(CGRectGetWidth(self.view.frame) * 0.25 - 7 - CGRectGetWidth(self.loanDurationBlock3yr.frame) * 0.25));
        make.top.equalTo(self.loanRepaymentDurationLine.mas_top).with.offset(-10);
    }];
    
    [self.loanDurationBlock4yr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo([NSNumber numberWithFloat:0]);
        make.top.equalTo(self.loanRepaymentDurationLine.mas_top).with.offset(-10);
    }];
    
    [self.loanDurationDot3m addTarget:self action:@selector(selectDot:) forControlEvents:UIControlEventTouchDown];
    [self.loanDurationDot6m addTarget:self action:@selector(selectDot:) forControlEvents:UIControlEventTouchDown];
    [self.loanDurationDot2yr addTarget:self action:@selector(selectDot:) forControlEvents:UIControlEventTouchDown];
    [self.loanDurationDot3yr addTarget:self action:@selector(selectDot:) forControlEvents:UIControlEventTouchDown];
    [self.loanDurationDot4yr addTarget:self action:@selector(selectDot:) forControlEvents:UIControlEventTouchDown];
    
    [self selectDot:self.loanDurationDot2yr];
}

- (void)pickPhoto {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *_picker = nil;
        if (self.popOverVC) {
            [self.popOverVC dismissPopoverAnimated:NO];
        }
        _picker = [[UIImagePickerController alloc] init];
        _picker.delegate = self;
        _picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            [self presentViewController:_picker animated:YES completion:nil];
        } else {
            self.popOverVC = [[UIPopoverController alloc] initWithContentViewController:_picker];
            [self.popOverVC presentPopoverFromRect:self.uploadButton1.frame
                                            inView:self.view
                          permittedArrowDirections:UIPopoverArrowDirectionLeft
                                          animated:YES];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error access photo library"
                                                        message:@"your device non support photo library"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)selectDot:(id)sender {
    self.loanDurationDot3m.selected = NO;
    self.loanDurationDot6m.selected = NO;
    self.loanDurationDot2yr.selected = NO;
    self.loanDurationDot3yr.selected = NO;
    self.loanDurationDot4yr.selected = NO;
    
    ((UIButton *)sender).selected = YES;
}

- (void)dismissKeyboard {
    [self.textFieldBorrowAmount resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self dismissKeyboard];
    return YES;
}

#pragma mark - IBActions

- (IBAction)uploadImage1TouchUpInside:(id)sender {
    self.imagePickerOption = UIImagePickerForVerificationPhoto1;
    [self pickPhoto];
}

- (IBAction)uploadImage2TouchUpInside:(id)sender {
    self.imagePickerOption = UIImagePickerForVerificationPhoto2;
    [self pickPhoto];
}

- (IBAction)checkEligibilityTouchUpInside:(id)sender {
    if (self.textFieldBorrowAmount.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter how much do you want to borrow." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Pending Approval" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage;
    
    // Handle a still image picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        if (self.imagePickerOption == UIImagePickerForVerificationPhoto1) {
            self.verificationImageView1.image = originalImage;
            self.uploadButton1Height.constant = 280;
            CGRect contentViewFrame = self.contentView.frame;
            contentViewFrame.size.height += 280;
            self.contentView.frame = contentViewFrame;
            
            self.verificationImageView1.hidden = NO;
            
        } else if (self.imagePickerOption == UIImagePickerForVerificationPhoto2) {
            self.verificationImageView2.image = originalImage;
            self.uploadButton2Height.constant = 280;
            CGRect contentViewFrame = self.contentView.frame;
            contentViewFrame.size.height += 280;
            self.contentView.frame = contentViewFrame;
            
            self.verificationImageView2.hidden = NO;
        }
        
        [self.uploadButton2 updateConstraints];
        
        self.contentViewHeight.constant = CGRectGetHeight(self.view.frame) + self.uploadButton1Height.constant + self.uploadButton2Height.constant - 50 - 50 - BottomHeight;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.checkEligibilityButton setTitle:@"Pending Approval" forState:UIControlStateNormal];
    self.checkEligibilityButton.userInteractionEnabled = NO;
}

@end
