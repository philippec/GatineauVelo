//
//  GVContext.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-01.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVContext.h"

@interface GVContext()

@property (copy) NSString *memoryStoreType;
@property (strong) NSDate *creationDate;

@end

@implementation GVContext

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (instancetype)initWithMemoryStoreType:(NSString *)memoryStoreType andCreationDate:(NSDate *)date
{
    if (self = [super init])
    {
        _memoryStoreType = memoryStoreType;
        _creationDate = date;
    }

    return self;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [managedObjectContext rollback];
        }
    }
}

- (BOOL)needsContent
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"GVPisteCyclable"];
    fetchRequest.includesSubentities = NO;

    NSUInteger count = [self.managedObjectContext countForFetchRequest:fetchRequest error:nil];
    if (count == 0 || count == NSNotFound)
    {
        return YES;
    }

    return NO;
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
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
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

    // Check if the store is older than the requested creation date
    NSError *error;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:storeURL.filePathURL.path error:&error];
    NSDate *storeCreationDate = [attributes fileModificationDate];
    BOOL shouldDestroyStore = NO;
    if (storeCreationDate != nil && error == nil)
    {
        if (NSOrderedAscending == [storeCreationDate compare:self.creationDate])
        {
            shouldDestroyStore = YES;
        }
    }

    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];

    if (shouldDestroyStore)
    {
        if ([_persistentStoreCoordinator respondsToSelector:@selector(destroyPersistentStoreAtURL:withType:options:error:)])
        {
            // Do it the new way
            [_persistentStoreCoordinator destroyPersistentStoreAtURL:storeURL withType:self.memoryStoreType options:nil error:&error];
        }
        else
        {
            // Do it the old-fashioned way
            // Note that we can't just delete the store itself, we have to delete related files as well
            // For that we'll use a regex so we can match "GatineauVelo.sqlite", "GatineauVelo.sqlite-wal", etc.
            NSString *storeName = storeURL.lastPathComponent;
            NSString *storePath = storeURL.path.stringByDeletingLastPathComponent;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:[storeName stringByAppendingString:@".*$"]
                                                                                   options:NSRegularExpressionCaseInsensitive
                                                                                     error:nil];
            NSDirectoryEnumerator *filesEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:storePath];

            NSString *oneFileName;
            NSError *deleteError;
            while (oneFileName = [filesEnumerator nextObject])
            {
                NSUInteger match = [regex numberOfMatchesInString:oneFileName
                                                          options:0
                                                            range:NSMakeRange(0, oneFileName.length)];
                if (match > 0)
                {
                    [[NSFileManager defaultManager] removeItemAtPath:[storePath stringByAppendingPathComponent:oneFileName] error:&deleteError];
                }
            }
        }
    }

    if (![_persistentStoreCoordinator addPersistentStoreWithType:self.memoryStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
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
