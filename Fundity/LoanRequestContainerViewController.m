//
//  LoanRequestContainerViewController.m
//  MasterCard
//
//  Created by Altitude Labs on 16/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "LoanRequestContainerViewController.h"
#import "LoanRequestViewController.h"
#import "MyProfileTableViewController.h"
#import "AppConfig.h"
#import "UIHelper.h"
#import "DeviceHelper.h"
#import <Masonry.h>

#define FilterButtonHeight 44.0
#define FilterPanelHeight 160.0
#define SelectedFilterItemColor [UIColor WhiteColor]
#define itemBorderColor [UIColor colorWithWhite:0.56 alpha:1]

@interface LoanRequestContainerViewController ()
@property (strong, nonatomic) LoanRequestViewController *tableViewController;
@property (strong, nonatomic) UIButton *filterByAmountButton;
@property (strong, nonatomic) UIButton *filterByRateButton;
@property (strong, nonatomic) UIView *footer;
@property (assign, nonatomic) BOOL showingFooter;

@property (strong, nonatomic) UIButton *refreshButton;
@end

@implementation LoanRequestContainerViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self closeFilterPanel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderNavigationBar];
    [self render];
    [self showContentWithDelay];
}

- (void)render {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.tableViewController = (LoanRequestViewController *)[sb instantiateViewControllerWithIdentifier:@"LoanRequestViewController"];
    self.tableViewController.loggedIn = self.loggedIn;
    self.tableViewController.userData = self.userData;
    [self addChildViewController:self.tableViewController];
    [self.view addSubview:self.tableViewController.view];
    CGRect tableViewFrame = self.tableViewController.view.frame;
    tableViewFrame.size.height -= FilterButtonHeight;
    self.tableViewController.view.frame = tableViewFrame;
    
    self.footer = [self footerView];
    self.footer.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - FilterButtonHeight, CGRectGetWidth(self.view.frame), FilterPanelHeight);
    [self.view addSubview:self.footer];
    
    self.showingFooter = NO;
}

- (void)renderNavigationBar {
    // Hide navigation bar
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    // Title
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.text = @"Loan Requests";
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.font = [UIFont fontWithName:UIFontRegularBook size:19.0];
    [lblTitle sizeToFit];
    self.navigationItem.titleView = lblTitle;
    
    // Right button
    [self showRightButtonInNavigationBar:self.loggedIn];
    [self showBackButton:!self.loggedIn];
}

- (void)showRightButtonInNavigationBar:(BOOL)show {
    if (show) {
        // Right button
        UIButton* buttonDone = [UIButton buttonWithType: UIButtonTypeCustom];
        buttonDone.frame = CGRectMake(0, 0, 30, 30);
        buttonDone.titleLabel.font = [UIFont fontWithName:UIFontRegularBook size:12];
        //    [buttonDone setTitle:@" " forState:UIControlStateNormal];
        [buttonDone setImage:[UIImage imageNamed:@"profile.png"] forState:UIControlStateNormal];
        [buttonDone setTitle:@"" forState:UIControlStateNormal];
        [buttonDone addTarget:self action:@selector(doneButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:buttonDone];
        self.navigationItem.rightBarButtonItem = anotherButton;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)showBackButton:(BOOL)show {
//    UIImage *backButtonImage = [[UIImage imageNamed:@"back@2x.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:nil  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, backButtonImage.size.height*2) forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.hidesBackButton = !show;
}

- (void)showContentWithDelay {
    self.tableViewController.view.hidden = YES;
    [[UIHelper sharedInstance] showLoadingSpinnerInView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [[UIHelper sharedInstance] hideLoadingSpinnerInView:self.view];
        if ([DeviceHelper isNetworkAvailable]) {
            self.tableViewController.view.hidden = NO;
            [self.refreshButton removeFromSuperview];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Oops" message:@"Please check your internet connect and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            
            self.refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.refreshButton.frame = CGRectMake(0, 0, 192, 132);
            self.refreshButton.center = self.view.center;
//            [self.refreshButton setTitle:@"Retry" forState:UIControlStateNormal];
            [self.refreshButton setImage:[UIImage imageNamed:@"Fundity_Connection.png"] forState:UIControlStateNormal];
            [self.refreshButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.refreshButton.titleLabel.font = [UIFont fontWithName:UIFontLight size:15];
            [self.refreshButton addTarget:self action:@selector(showContentWithDelay) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.refreshButton];
            
            // Navigation bar
            [self showRightButtonInNavigationBar:self.loggedIn];
            [self showBackButton:!self.loggedIn];
        }
    });
}

#pragma mark - Private

- (void)doneButtonTouchUpInside:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyProfileTableViewController *vc = (MyProfileTableViewController *)[sb instantiateViewControllerWithIdentifier:@"MyProfileTableViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)footerView {
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    footer.backgroundColor = ColorGray;
    
    // Filter by amount button
    
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [filterButton setTitle:@"  Filter" forState:UIControlStateNormal];
    [filterButton setImage:[UIImage imageNamed:@"LoanRequest_Filter.png"] forState:UIControlStateNormal];
    
    [filterButton setTitleColor:TextColorDark forState:UIControlStateNormal];
    filterButton.titleLabel.font = [UIFont fontWithName:UIFontLight size:18];
    filterButton.layer.borderWidth = 1;
    filterButton.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    [filterButton addTarget:self action:@selector(filterButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:filterButton];
    [filterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footer.mas_top);
        make.left.equalTo(footer.mas_left);
        make.right.equalTo(footer.mas_right);
        make.height.equalTo([NSNumber numberWithInteger:FilterButtonHeight]);
    }];
    
    self.filterByAmountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.filterByAmountButton.layer.borderWidth = 1;
    self.filterByAmountButton.layer.borderColor = itemBorderColor.CGColor;
    [self.filterByAmountButton addTarget:self action:@selector(sortByAmountButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:self.filterByAmountButton];
    [self.filterByAmountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@90);
        make.height.equalTo(@90);
        make.centerX.equalTo(filterButton.mas_centerX).with.offset(0);
        make.centerY.equalTo(footer.mas_centerY).with.offset(44 * 0.5);
    }];
    
    [self addFilterButton:self.filterByAmountButton withCenterText:@"Amount" leftLabelText:@"High" rightLabelText:@"Low"];
    
    // Clear button
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearButton setTitleColor:TextColorDark forState:UIControlStateNormal];
    clearButton.titleLabel.font = [UIFont fontWithName:UIFontRegular size:15];
    clearButton.layer.borderWidth = 1;
    clearButton.layer.borderColor = itemBorderColor.CGColor;
    [clearButton addTarget:self action:@selector(clearButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:clearButton];
    [clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@90);
        make.height.equalTo(@90);
        make.right.equalTo(self.filterByAmountButton.mas_left).with.offset(-10);
        make.top.equalTo(self.filterByAmountButton.mas_top);
    }];
    
    // Filter by rate button
    
    self.filterByRateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.filterByRateButton.layer.borderWidth = 1;
    self.filterByRateButton.layer.borderColor = itemBorderColor.CGColor;
    [self.filterByRateButton addTarget:self action:@selector(sortByRateButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:self.filterByRateButton];
    [self.filterByRateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@90);
        make.height.equalTo(@90);
        make.left.equalTo(self.filterByAmountButton.mas_right).with.offset(10);
        make.top.equalTo(self.filterByAmountButton.mas_top);
    }];
    
    [self addFilterButton:self.filterByRateButton withCenterText:@"Rate" leftLabelText:@"Low" rightLabelText:@"High"];
    
    return footer;
}

- (void)addFilterButton:(UIView *)filterButton withCenterText:(NSString *)centerText leftLabelText:(NSString *)leftText rightLabelText:(NSString *)rightText {
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    amountLabel.font = [UIFont fontWithName:UIFontRegular size:15];
    amountLabel.textAlignment = NSTextAlignmentCenter;
    amountLabel.textColor = TextColorDark;
    amountLabel.text = centerText;
    [filterButton addSubview:amountLabel];
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(filterButton.mas_left);
        make.right.equalTo(filterButton.mas_right);
        make.height.equalTo(@15);
        make.centerY.equalTo(filterButton.mas_centerY).with.offset(-5);
    }];
    
    UILabel *filterByLabelForAmount = [[UILabel alloc] initWithFrame:CGRectZero];
    filterByLabelForAmount.font = [UIFont fontWithName:UIFontRegular size:10];
    filterByLabelForAmount.textAlignment = NSTextAlignmentCenter;
    filterByLabelForAmount.textColor = TextColorDark;
    filterByLabelForAmount.text = @"Filter by";
    [filterButton addSubview:filterByLabelForAmount];
    [filterByLabelForAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(filterButton.mas_left);
        make.right.equalTo(filterButton.mas_right);
        make.height.equalTo(@12);
        make.bottom.equalTo(amountLabel.mas_top);
    }];
    
    UIView *lineForAmount = [[UIView alloc] initWithFrame:CGRectZero];
    lineForAmount.backgroundColor = itemBorderColor;
    [filterButton addSubview:lineForAmount];
    [lineForAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(filterButton.mas_left);
        make.right.equalTo(filterButton.mas_right);
        make.height.equalTo(@1);
        make.bottom.equalTo(filterButton).with.offset(-20);
    }];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    leftLabel.font = [UIFont fontWithName:UIFontRegular size:11];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.textColor = TextColorDark;
    leftLabel.text = leftText;
    [leftLabel sizeToFit];
    [filterButton addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(filterButton.mas_left).with.offset(10);
        make.width.equalTo([NSNumber numberWithFloat:CGRectGetWidth(leftLabel.frame)]);
        make.bottom.equalTo(filterButton.mas_bottom);
        make.height.equalTo(@20);
    }];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    rightLabel.font = [UIFont fontWithName:UIFontRegular size:11];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.textColor = TextColorDark;
    rightLabel.text = rightText;
    [rightLabel sizeToFit];
    [filterButton addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(filterButton.mas_right).with.offset(-10);
        make.width.equalTo([NSNumber numberWithFloat:CGRectGetWidth(rightLabel.frame)]);
        make.bottom.equalTo(filterButton.mas_bottom);
        make.height.equalTo(@20);
    }];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoanDetail_FilterArrow.png"]];
    [filterButton addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(filterButton.mas_centerX);
        make.centerY.equalTo(rightLabel.mas_centerY);
        make.width.equalTo(@16);
        make.height.equalTo(@9);
    }];
}

- (void)filterButtonClicked {
    [self openOrCloseFilterPanel];
}

- (void)openOrCloseFilterPanel {
    self.showingFooter = !self.showingFooter;
    [self updateFilterPanel];
}

- (void)closeFilterPanel {
    self.showingFooter = NO;
    [self updateFilterPanel];
}

- (void)updateFilterPanel {
    if (self.showingFooter) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.footer.frame;
            frame.origin.y = CGRectGetMaxY(self.view.frame) - FilterPanelHeight;
            self.footer.frame = frame;
        } completion:^(BOOL finished) {
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.footer.frame;
            frame.origin.y = CGRectGetMaxY(self.view.frame) - FilterButtonHeight;
            self.footer.frame = frame;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)clearButtonClicked {
    [self.tableViewController filterByNone];
    [self openOrCloseFilterPanel];
    
    self.filterByAmountButton.backgroundColor = [UIColor clearColor];
    self.filterByRateButton.backgroundColor = [UIColor clearColor];
}

- (void)sortByAmountButtonClicked {
    [self.tableViewController filterByAmount];
    [self openOrCloseFilterPanel];
    
    self.filterByAmountButton.backgroundColor = [UIColor whiteColor];
    self.filterByRateButton.backgroundColor = [UIColor clearColor];
}

- (void)sortByRateButtonClicked {
    [self.tableViewController filterByRate];
    [self openOrCloseFilterPanel];
    
    self.filterByAmountButton.backgroundColor = [UIColor clearColor];
    self.filterByRateButton.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Accessors

- (void)setLoggedIn:(BOOL)loggedIn {
    _loggedIn = loggedIn;
    if (self.tableViewController) self.tableViewController.loggedIn = _loggedIn;
    [self showRightButtonInNavigationBar:_loggedIn];
    [self showBackButton:!_loggedIn];
}

@end
