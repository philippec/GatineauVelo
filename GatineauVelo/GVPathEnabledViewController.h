//
//  GVPathEnabledViewController.h
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GVPathEnabledViewController : UITableViewController

@property (strong) IBOutlet UISwitch *mainPathSwitch;
@property (strong) IBOutlet UISwitch *routeVerteSwitch;
@property (strong) IBOutlet UISwitch *updateSwitch;

@property (nonatomic, strong) NSUserDefaults *userDefaults;

- (IBAction)toggleBikePath:(id)sender;

@end
