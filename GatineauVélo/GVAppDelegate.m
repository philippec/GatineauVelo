//
//  GVAppDelegate.m
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVAppDelegate.h"
#import "GVMainViewController.h"
#import "DDFileReader.h"
#import "GVPisteCyclable.h"
#import "GVPoint.h"

@implementation GVAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSSet *)extractCoordsFromString:(NSString *)coords
{
    NSMutableSet *s = [NSMutableSet setWithCapacity:0];

    NSString *coordsWithoutLinestring = [coords substringFromIndex:@"LINESTRING (".length];
    NSString *coordsWithoutBraces = [coordsWithoutLinestring substringToIndex:coordsWithoutLinestring.length - 2];
    NSArray *allCoords = [coordsWithoutBraces componentsSeparatedByString:@","];
    NSUInteger count = 0;
    for (NSString *oneCoord in allCoords)
    {
        NSScanner *scanner = [NSScanner scannerWithString:oneCoord];
        GVPoint *pt = [NSEntityDescription insertNewObjectForEntityForName:@"GVPoint" inManagedObjectContext:self.managedObjectContext];

        double latitude, longitude;
        [scanner scanDouble:&latitude];
        [scanner scanDouble:&longitude];

        pt.latitude = [NSNumber numberWithDouble:latitude];
        pt.longitude = [NSNumber numberWithDouble:longitude];
        pt.order = [NSNumber numberWithUnsignedInteger:count];

        [s addObject:pt];
        count++;
    }

    return [NSSet setWithSet:s];
}

- (void)loadBikePaths
{
    DDFileReader *reader = [[DDFileReader alloc] initWithFilePath:[[NSBundle mainBundle] pathForResource:@"PISTE_CYCLABLE" ofType:@"csv"]];
    reader.lineDelimiter = @"\r";
    NSUInteger lineCounter = 0;
    NSString *line;
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];

    while ((line = [reader readLine]))
    {
        // Skip the first line as it contains just the headers
        if (lineCounter > 0)
        {
            NSArray *elements = [line componentsSeparatedByString:@"|"];
            if (elements.count == 12)
            {
                GVPisteCyclable *pisteCyclable = [NSEntityDescription insertNewObjectForEntityForName:@"GVPisteCyclable" inManagedObjectContext:self.managedObjectContext];
                pisteCyclable.entiteID = elements[0];
                pisteCyclable.munID = elements[1];
                pisteCyclable.codeID = elements[2];
                pisteCyclable.type = elements[3];
                pisteCyclable.route_verte = [elements[4] isEqualToString:@"Oui"] ? @YES : @NO;
                pisteCyclable.direc_uniq = [elements[5] isEqualToString:@"Oui"] ? @YES : @NO;
                pisteCyclable.status = elements[6];
                pisteCyclable.revetement = elements[7];
                pisteCyclable.proprio = elements[8];
                pisteCyclable.largeur = [f numberFromString:elements[9]];
                pisteCyclable.longueur = [f numberFromString:elements[10]];

                pisteCyclable.geom = [self extractCoordsFromString:elements[11]];
            }
        }
        lineCounter++;
    }

    NSError *error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Erreur: %@", error);
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [self loadBikePaths];

    GVMainViewController *controller = (GVMainViewController *)self.window.rootViewController;
    controller.managedObjectContext = self.managedObjectContext;
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
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GatineauVe_lo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"GatineauVe_lo.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
