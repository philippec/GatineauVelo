//
//  GVAppDelegate.h
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GVContext;
@class GVPathLoader;

@interface GVAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) GVContext *context;

@end
