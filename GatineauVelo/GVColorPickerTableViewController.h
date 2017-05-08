//
//  GVColorPickerTableViewController.h
//  GatineauVelo
//
//  Created by Philippe on 17-04-25.
//  Copyright © 2017 Philippe Casgrain. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GVColorPickerSelected)(NSUInteger index);

@interface GVColorPickerTableViewController : UITableViewController

@property (nonatomic, copy) NSArray *colors;
@property (nonatomic, strong) GVColorPickerSelected callback;

@end
