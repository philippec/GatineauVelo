//
//  GVAppDelegate.m
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVAppDelegate.h"
#import "GVMainViewController.h"
#import "GVContext.h"
#import "GVAppDefaults.h"


@implementation GVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    GVAppDefaults *appDefaults = [[GVAppDefaults alloc] init];

    GVMainViewController *controller = (GVMainViewController *)self.window.rootViewController;
    controller.context = self.context;
    controller.standardColor = [appDefaults colorNamed:@"standardColor"];
    controller.routeVerteColor = [appDefaults colorNamed:@"routeVerteColor"];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self.context saveContext];
}

#pragma mark - Context

- (GVContext *)context
{
    if (!_context)
    {
        _context = [[GVContext alloc] initWithMemoryStoreType:NSInMemoryStoreType];
    }

    return _context;
}

@end
