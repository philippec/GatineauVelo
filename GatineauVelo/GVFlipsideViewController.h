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

@interface GVFlipsideViewController : UIViewController <UINavigationControllerDelegate>

@property (weak, nonatomic) id <GVFlipsideViewControllerDelegate> delegate;
@property (readonly) UINavigationController *navigationController;

@property (strong) IBOutlet UIBarButtonItem *backButton;

- (IBAction)done:(id)sender;
- (IBAction)back:(id)sender;

@end
