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
    self.mainPathSwitch.on = [self.userDefaults boolForKey:@"mainPaths"];
    self.routeVerteSwitch.on = [self.userDefaults boolForKey:@"routeVertePaths"];
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
    NSString *key = @"mainPaths";
    if (sender == self.routeVerteSwitch)
    {
        key = @"routeVertePaths";
    }

    [self.userDefaults setBool:sender.isOn forKey:key];
    [self.userDefaults synchronize];
}

@end
