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
#import "Third Party/AnalyticsKeys.h"

#ifndef DISABLE_APPCENTER
@import AppCenter;
@import AppCenterAnalytics;
@import AppCenterCrashes;
#endif

@interface GVAppDelegate()

@property (strong) GVAppDefaults *appDefaults;
@property (strong) GVMainViewController *mainViewController;

@end


@implementation GVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.appDefaults = [[GVAppDefaults alloc] init];

    self.mainViewController = (GVMainViewController *)self.window.rootViewController;
    self.mainViewController.context = self.context;
    self.mainViewController.standardColor = [self.appDefaults colorNamed:@"standardColor"];
    self.mainViewController.routeVerteColor = [self.appDefaults colorNamed:@"routeVerteColor"];
    self.mainViewController.updateColor = [self.appDefaults colorNamed:@"updateColor"];

#ifndef DISABLE_APPCENTER
    [MSAppCenter start:APPCENTER_SECRET_KEY withServices:@[
      [MSAnalytics class],
      [MSCrashes class]
    ]];
#endif

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
    [self.mainViewController appDidBecomeActive];
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
        NSString *filePath = [[NSBundle mainBundle] pathForResource:self.appDefaults.csvFileName ofType:@"csv"];
        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        NSDate *date = [attributes fileModificationDate];

        _context = [[GVContext alloc] initWithMemoryStoreType:NSSQLiteStoreType andCreationDate:date];
    }

    return _context;
}

@end
