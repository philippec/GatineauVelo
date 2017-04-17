//
//  GVMapTypeViewController.h
//  GatineauVelo
//
//  Created by Philippe on 2017-04-16.
//  Copyright (c) 2017 Philippe Casgrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GVMapTypeViewController : UITableViewController <UITableViewDelegate>

@property (strong) IBOutlet UITableViewCell *standardViewCell;
@property (strong) IBOutlet UITableViewCell *satelliteViewCell;
@property (strong) IBOutlet UITableViewCell *hybridViewCell;

@property (nonatomic, strong) NSUserDefaults *userDefaults;

@end
