//
//  GVMainViewController.h
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVFlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface GVMainViewController : UIViewController <GVFlipsideViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
