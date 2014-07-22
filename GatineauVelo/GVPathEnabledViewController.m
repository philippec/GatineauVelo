//
//  GVPathEnabledViewController.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVPathEnabledViewController.h"
#import "GVAppDefaults.h"

@interface GVPathEnabledViewController ()

@end

@implementation GVPathEnabledViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mainPathSwitch.on = ![self.userDefaults boolForKey:@"mainPathsHidden"];
    self.routeVerteSwitch.on = ![self.userDefaults boolForKey:@"routeVertePathsHidden"];
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

- (IBAction)toggleBikePath:(UISwitch *)sender
{
    NSString *key = @"mainPathsHidden";
    if (sender == self.routeVerteSwitch)
    {
        key = @"routeVertePathsHidden";
    }

    [self.userDefaults setBool:!(sender.isOn) forKey:key];
    [self.userDefaults synchronize];
}

@end
