//
//  RegisterPageStepPersonalViewController.h
//  MasterCard
//
//  Created by Altitude Labs on 13/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterPageStepPersonalViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnEditProfilePicture;
@property (weak, nonatomic) IBOutlet UIImageView *profilePhotoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *editProfilePictureEmptyLogo;
@property (weak, nonatomic) IBOutlet UILabel *editProfilePictureLabel;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFullName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCompanyName;
@property (weak, nonatomic) IBOutlet UIButton *btnUploadLicense;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLicense;
@property (weak, nonatomic) IBOutlet UIButton *btnPostCode;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAddressLine1;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAddressLine2;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property (weak, nonatomic) IBOutlet UIButton *uploadedImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uploadedImageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uploadedBtnHeight;


@end
