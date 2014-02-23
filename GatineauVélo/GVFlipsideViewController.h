//
//  GVFlipsideViewController.h
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GVFlipsideViewController;

@protocol GVFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(GVFlipsideViewController *)controller;
@end

@interface GVFlipsideViewController : UIViewController

@property (weak, nonatomic) id <GVFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
