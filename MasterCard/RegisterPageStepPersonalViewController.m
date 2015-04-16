//
//  RegisterPageStepPersonalViewController.m
//  MasterCard
//
//  Created by Altitude Labs on 13/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "RegisterPageStepPersonalViewController.h"
#import "UITextField+WithPadding.h"
#import "UIImage+Resizing.h"
#import "AppConfig.h"
#import <CoreFoundation/CoreFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

typedef NS_ENUM(NSInteger, UIImagePickerOption) {
    UIImagePickerForProfilePhoto = 1,
    UIImagePickerForLicense = 2
};

@interface RegisterPageStepPersonalViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) UIPopoverController *popOverVC;
@property (assign, nonatomic) UIImagePickerOption imagePickerOption;
@end

@implementation RegisterPageStepPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderNavigationBar];
    [self render];
}

#pragma mark - Private

- (void)renderNavigationBar {
    // Show navigation bar
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    // Custom back button for all other pages
    UIImage *backButtonImage = [[UIImage imageNamed:@"back@2x.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, backButtonImage.size.height*2) forBarMetrics:UIBarMetricsDefault];
    
    // Title
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.text = @"Registration";
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.font = [UIFont fontWithName:UIFontRegularBook size:19.0];
    [lblTitle sizeToFit];
    self.navigationItem.titleView = lblTitle;
}

- (void)render {
    // Border
    self.textFieldFullName.layer.borderWidth = 1;
    self.textFieldFullName.layer.borderColor = ColorTextFieldBorder.CGColor;
    self.textFieldCompanyName.layer.borderWidth = 1;
    self.textFieldCompanyName.layer.borderColor = ColorTextFieldBorder.CGColor;
    self.btnUploadLicense.layer.borderWidth = 1;
    self.btnUploadLicense.layer.borderColor = ColorTextFieldBorder.CGColor;
    self.btnPostCode.layer.borderWidth = 1;
    self.btnPostCode.layer.borderColor = ColorTextFieldBorder.CGColor;
    self.textFieldPhoneNumber.layer.borderWidth = 1;
    self.textFieldPhoneNumber.layer.borderColor = ColorTextFieldBorder.CGColor;
    self.textFieldAddressLine1.layer.borderWidth = 1;
    self.textFieldAddressLine1.layer.borderColor = ColorTextFieldBorder.CGColor;
    self.textFieldAddressLine2.layer.borderWidth = 1;
    self.textFieldAddressLine2.layer.borderColor = ColorTextFieldBorder.CGColor;
    self.btnNext.layer.borderWidth = 1;
    self.btnNext.layer.borderColor = ColorTextFieldBorder.CGColor;
    
    // Shape
    self.btnEditProfilePicture.clipsToBounds = YES;
    self.btnEditProfilePicture.layer.cornerRadius = CGRectGetWidth(self.btnEditProfilePicture.frame) * 0.5;
    self.profilePhotoImageView.clipsToBounds = YES;
    self.profilePhotoImageView.layer.cornerRadius = CGRectGetWidth(self.btnEditProfilePicture.frame) * 0.5;
    
    // TextField
    self.textFieldFullName.delegate = self;
    self.textFieldCompanyName.delegate = self;
    self.textFieldPhoneNumber.delegate = self;
    self.textFieldAddressLine1.delegate = self;
    self.textFieldAddressLine2.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard)];
    [self.scrollView addGestureRecognizer:tap];
    
    // ImageView
    self.imageViewLicense.clipsToBounds = YES;
    self.imageViewLicense.backgroundColor = [UIColor blackColor];
    self.imageViewLicense.contentMode = UIViewContentModeScaleAspectFit;
    self.imageViewLicense.hidden = YES;
    
    self.profilePhotoImageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)resignKeyboard {
    [self.textFieldFullName resignFirstResponder];
    [self.textFieldCompanyName resignFirstResponder];
    [self.textFieldPhoneNumber resignFirstResponder];
    [self.textFieldAddressLine1 resignFirstResponder];
    [self.textFieldAddressLine2 resignFirstResponder];
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
            [self.popOverVC presentPopoverFromRect:self.btnUploadLicense.frame
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

#pragma mark - IBAction

- (IBAction)pickLicenseTouchUpInside:(id)sender {
    self.imagePickerOption = UIImagePickerForLicense;
    [self pickPhoto];
}

- (IBAction)pickProfilePhotoTouchUpInside:(id)sender {
    self.imagePickerOption = UIImagePickerForProfilePhoto;
    [self pickPhoto];
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.scrollView endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.textFieldFullName) {
        [self.textFieldCompanyName becomeFirstResponder];
    } else if (textField == self.textFieldCompanyName) {
        [self.textFieldCompanyName resignFirstResponder];
    } else if (textField == self.textFieldPhoneNumber) {
        [self.textFieldAddressLine1 becomeFirstResponder];
    } else if (textField == self.textFieldAddressLine1) {
        [self.textFieldAddressLine2 becomeFirstResponder];
    } else if (textField == self.textFieldAddressLine2) {
        [self.textFieldAddressLine2 resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.textFieldFullName) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (textField == self.textFieldCompanyName) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (textField == self.textFieldPhoneNumber) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (textField == self.textFieldAddressLine1) {
        [self.scrollView setContentOffset:CGPointMake(0, 40) animated:YES];
    } else if (textField == self.textFieldAddressLine2) {
        [self.scrollView setContentOffset:CGPointMake(0, 90) animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.scrollView setContentOffset:CGPointMake(0, -64) animated:YES];
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
        
        if (self.imagePickerOption == UIImagePickerForProfilePhoto) {
            self.btnEditProfilePicture.imageView.image = originalImage;
            UIImage *scaledImage = [originalImage scaleToSize:self.btnEditProfilePicture.frame.size];
            self.profilePhotoImageView.image = scaledImage;
            self.editProfilePictureEmptyLogo.hidden = YES;
            self.editProfilePictureLabel.hidden = YES;
            
        } else if (self.imagePickerOption == UIImagePickerForLicense) {
            self.imageViewLicense.image = originalImage;
            self.uploadedImageViewHeight.constant = 280;
            self.uploadedBtnHeight.constant = 280;
            self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, CGRectGetHeight(self.scrollView.frame) + 280);
            self.imageViewLicense.hidden = NO;
//            self.btnUploadLicense.hidden = YES;
            
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
