//
//  RegisterPageStepPersonalViewController.m
//  MasterCard
//
//  Created by Altitude Labs on 13/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "RegisterPageStepPersonalViewController.h"
#import "UITextField+WithPadding.h"
#import "AppConfig.h"
#import <CoreFoundation/CoreFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface RegisterPageStepPersonalViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) UIPopoverController *popOverVC;
@end

@implementation RegisterPageStepPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self render];
}

#pragma mark - Private

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
}

- (void)resignKeyboard {
    [self.textFieldFullName resignFirstResponder];
    [self.textFieldCompanyName resignFirstResponder];
    [self.textFieldPhoneNumber resignFirstResponder];
    [self.textFieldAddressLine1 resignFirstResponder];
    [self.textFieldAddressLine2 resignFirstResponder];
}

- (void)showLicensePhoto {
    
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
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

- (IBAction)uploadLicenseTouchUpInside:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
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
//            [self.popoverController setDelegate:self];
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

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage;
    
    // Handle a still image picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        self.imageViewLicense.image = originalImage;
        self.uploadedImageViewHeight.constant = 280;
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, CGRectGetHeight(self.scrollView.frame) + 280);
        
        self.imageViewLicense.hidden = NO;
        self.btnUploadLicense.hidden = YES;
    }
//    [[picker parentViewController] dismissModalViewControllerAnimated: YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
