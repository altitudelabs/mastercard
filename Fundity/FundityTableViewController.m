//
//  FundityTableViewController.m
//  MasterCard
//
//  Created by Altitude Labs on 9/4/15.
//  Copyright (c) 2015 MasterCard. All rights reserved.
//

#import "FundityTableViewController.h"

@interface FundityTableViewController ()

@end

@implementation FundityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set footer to blank white
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    // Background color
    self.tableView.backgroundColor = [UIColor whiteColor];
//    self.tableView.separatorColor = [UIColor grayColor];
    
    // Dismiss keyboard when touch empty space
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTableViewTapped)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Customize selection style of all static cells
    NSArray *cells = [self.tableView visibleCells];
    for (UITableViewCell *cell in cells) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.bounds = CGRectInset(cell.contentView.frame, 0, 0);
    }
}

- (void)onTableViewTapped {
    [self.tableView.superview endEditing:YES];
}

#pragma mark - table view delegate
// Set insets of separator to zero
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 1;
}

@end
