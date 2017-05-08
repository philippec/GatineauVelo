//
//  GVColorPickerTableViewController.m
//  GatineauVelo
//
//  Created by Philippe on 17-04-25.
//  Copyright © 2017 Philippe Casgrain. All rights reserved.
//

#import "GVColorPickerTableViewController.h"
#import "UIColor+HexColors.h"

@interface GVColorPickerTableViewController ()

@end

@implementation GVColorPickerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.colors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GVColorPickerCell" forIndexPath:indexPath];
    // There should be only one subview and it's the color view
    UIView *view = cell.contentView.subviews.firstObject;
    UIColor *cellColor = [UIColor colorWithHexString:self.colors[indexPath.row]];
    view.backgroundColor = cellColor;
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.callback)
    {
        self.callback(indexPath.row);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
