//
//  GVAppDelegate.m
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVAppDelegate.h"
#import "GVMainViewController.h"
#import "GVPathLoader.h"
#import "GVContext.h"


@interface GVAppDelegate()
@end

@implementation GVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"PISTE_CYCLABLE" withExtension:@"csv"];
    [self.pathLoader loadBikePathsAtURL:url];

    GVMainViewController *controller = (GVMainViewController *)self.window.rootViewController;
    controller.managedObjectContext = self.context.managedObjectContext;
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
        _context = [[GVContext alloc] init];
    }

    return _context;
}

#pragma mark - Path Loader

- (GVPathLoader *)pathLoader
{
    if (!_pathLoader)
    {
        _pathLoader = [[GVPathLoader alloc] initWithManagedObjectContext:self.context.managedObjectContext];
    }

    return _pathLoader;
}

@end
