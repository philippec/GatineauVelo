//
//  GVPathColorsViewController.h
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GVAppDefaults;

@interface GVPathColorsViewController : UITableViewController

@property (strong) IBOutlet UIView *mainPathColorView;
@property (strong) IBOutlet UIView *routeVerteColorView;
@property (strong) IBOutlet UIView *updatedPathColorView;

@property (nonatomic, strong) GVAppDefaults *appDefaults;

@end
