//
//  GVPathColorsViewController.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVPathColorsViewController.h"
#import "GVAppDefaults.h"
#import "GVColorPickerTableViewController.h"

@interface GVPathColorsViewController ()

@end

@implementation GVPathColorsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareColors];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (GVAppDefaults *)appDefaults
{
    if (!_appDefaults)
    {
        _appDefaults = [[GVAppDefaults alloc] initWithUserDefaults:[NSUserDefaults standardUserDefaults]];
    }

    return _appDefaults;
}

- (void)prepareColors
{
    self.mainPathColorView.backgroundColor = [self.appDefaults colorNamed:@"standardColor"];
    self.routeVerteColorView.backgroundColor = [self.appDefaults colorNamed:@"routeVerteColor"];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *colorSelection = segue.identifier;
    GVColorPickerTableViewController *controller = (GVColorPickerTableViewController *)segue.destinationViewController;
    controller.colors = [self.appDefaults colorsForName:colorSelection];
    controller.callback = ^(NSUInteger index) {
        [self.appDefaults saveColorIndex:index forColorName:colorSelection];
        [self prepareColors];
    };
}

@end
