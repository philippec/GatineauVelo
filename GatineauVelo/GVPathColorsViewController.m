//
//  GVPathColorsViewController.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVPathColorsViewController.h"
#import "GVAppDefaults.h"

@interface GVPathColorsViewController ()

@end

@implementation GVPathColorsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.mainPathColorView.backgroundColor = [self.appDefaults colorNamed:@"standardColor"];
    self.routeVerteColorView.backgroundColor = [self.appDefaults colorNamed:@"routeVerteColor"];
    self.updatedPathColorView.backgroundColor = [self.appDefaults colorNamed:@"updateColor"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (GVAppDefaults *)appDefaults
{
    if (!_appDefaults)
    {
        _appDefaults = [[GVAppDefaults alloc] init];
    }

    return _appDefaults;
}

@end
