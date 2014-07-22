//
//  GVContextTests.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-01.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVTestCase.h"
#import "GVContext.h"
#import "GVPathLoader.h"

@interface GVContextTests : GVTestCase

@property (strong) GVContext *context;

@end

@implementation GVContextTests

- (void)setUp
{
    [super setUp];
    self.context = [[GVContext alloc] initWithMemoryStoreType:NSInMemoryStoreType andCreationDate:nil];
}

- (void)tearDown
{
    self.context = nil;
    [super tearDown];
}

- (void)testCreation
{
    XCTAssertNoThrow(self.context = [[GVContext alloc] initWithMemoryStoreType:NSInMemoryStoreType andCreationDate:nil]);
    XCTAssertNotNil(self.context);
}

- (void)testNeedsContent
{
    BOOL result;

    // Empty content needs content
    XCTAssertNoThrow(result = self.context.needsContent);
    XCTAssertTrue(result);

    // Load some data
    GVPathLoader *pathLoader = [[GVPathLoader alloc] initWithContext:self.context];
    NSURL *fileURL = [[self dataFolder] URLByAppendingPathComponent:@"pistes_cyclables_10.csv"];
    [pathLoader loadBikePathsAtURL:fileURL withCompletion:nil];

    XCTAssertNoThrow(result = self.context.needsContent);
    XCTAssertFalse(result);
}

- (void)testDeleteStoreIfTooOld
{
    XCTAssertNoThrow(self.context = [[GVContext alloc] initWithMemoryStoreType:NSSQLiteStoreType andCreationDate:[NSDate distantPast]]);

    // Load some data
    GVPathLoader *pathLoader = [[GVPathLoader alloc] initWithContext:self.context];
    NSURL *fileURL = [[self dataFolder] URLByAppendingPathComponent:@"pistes_cyclables_10.csv"];
    [pathLoader loadBikePathsAtURL:fileURL withCompletion:nil];

    XCTAssertFalse(self.context.needsContent);

    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = -1;

    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *yesterday = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];

    // Create another store, should still have data
    XCTAssertNoThrow(self.context = [[GVContext alloc] initWithMemoryStoreType:NSSQLiteStoreType andCreationDate:yesterday]);
    XCTAssertFalse(self.context.needsContent);

    // Move the date to tomorrow, should clear the data
    dayComponent.day = 1;
    NSDate *tomorrow = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
    XCTAssertNoThrow(self.context = [[GVContext alloc] initWithMemoryStoreType:NSSQLiteStoreType andCreationDate:tomorrow]);
    XCTAssertTrue(self.context.needsContent);
}

@end
