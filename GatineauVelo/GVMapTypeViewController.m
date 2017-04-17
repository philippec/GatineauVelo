//
//  GVMapTypeViewController.m
//  GatineauVelo
//
//  Created by Philippe on 2017-04-16.
//  Copyright (c) 2017 Philippe Casgrain. All rights reserved.
//

#import "GVMapTypeViewController.h"
#import "GVAppDefaults.h"

@interface GVMapTypeViewController ()

@end

@implementation GVMapTypeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateCheckmarks];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSUserDefaults *)userDefaults
{
    if (!_userDefaults)
    {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }

    return _userDefaults;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.userDefaults setInteger:indexPath.row forKey:@"mapType"];
    [self.userDefaults synchronize];
    [self updateCheckmarks];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)updateCheckmarks
{
    NSInteger mapType = [self.userDefaults integerForKey:@"mapType"];

    self.standardViewCell.accessoryType = (mapType == MKMapTypeStandard) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    self.satelliteViewCell.accessoryType = (mapType == MKMapTypeSatellite) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    self.hybridViewCell.accessoryType = (mapType == MKMapTypeHybrid) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

@end
