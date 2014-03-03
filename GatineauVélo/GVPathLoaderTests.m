//
//  GVPathLoaderTests.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-01.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVTestCase.h"
#import <OCMock/OCMock.h>
#import "GVPathLoader.h"
#import "GVContext.h"
#import "GVPisteCyclable.h"

@interface GVPathLoaderTests : GVTestCase

@property (strong) GVPathLoader *pathLoader;
@property (strong) GVContext *context;
@property (assign) MKCoordinateRegion region;

@end

@implementation GVPathLoaderTests

- (void)setUp
{
    [super setUp];

    self.context = [[GVContext alloc] initWithMemoryStoreType:NSInMemoryStoreType];
    self.pathLoader = [[GVPathLoader alloc] initWithContext:self.context];
    self.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(45, -75), MKCoordinateSpanMake(1.3, 2.8));
}

- (void)tearDown
{
    self.context = nil;
    self.pathLoader = nil;
    [super tearDown];
}

- (void)testCreation
{
    id mockContext = [OCMockObject mockForClass:[GVContext class]];
    XCTAssertNoThrow(self.pathLoader = [[GVPathLoader alloc] initWithContext:mockContext]);
    XCTAssertNotNil(self.pathLoader);

    XCTAssertEqualObjects(self.pathLoader.context, mockContext);
}

- (void)testLoad10Paths
{
    NSURL *fileURL = [[self dataFolder] URLByAppendingPathComponent:@"pistes_cyclables_10.csv"];

    __block BOOL wasCalled;
    GVPathLoaderComplete completion = ^(void) {
        wasCalled = YES;
    };

    XCTAssertNoThrow([self.pathLoader loadBikePathsAtURL:fileURL withCompletion:completion]);

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"GVPisteCyclable"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"codeID" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context.managedObjectContext sectionNameKeyPath:nil cacheName:nil];

    NSError *error;
    [frc performFetch:&error];
    XCTAssertNil(error);

    XCTAssertEqual(frc.fetchedObjects.count, (NSUInteger)10);
    XCTAssertTrue(wasCalled);
}

- (void)testBoundingRegion
{
    XCTAssertNoThrow(self.pathLoader.boundingRegion = self.region);

    MKCoordinateRegion region = self.region, newRegion;
    XCTAssertNoThrow(newRegion = self.pathLoader.boundingRegion);
    XCTAssertEqual(memcmp(&region, &newRegion, sizeof(MKCoordinateRegion)), 0);
}

- (void)testFilterBadCoordinatesInPath
{
    XCTAssertNoThrow(self.pathLoader.boundingRegion = self.region);

    NSURL *fileURL = [[self dataFolder] URLByAppendingPathComponent:@"piste_bad_data.csv"];
    XCTAssertNoThrow([self.pathLoader loadBikePathsAtURL:fileURL withCompletion:nil]);

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"GVPisteCyclable"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"codeID" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context.managedObjectContext sectionNameKeyPath:nil cacheName:nil];

    NSError *error;
    [frc performFetch:&error];
    XCTAssertNil(error);

    XCTAssertEqual(frc.fetchedObjects.count, (NSUInteger)1);

    GVPisteCyclable *pisteCyclable = frc.fetchedObjects.firstObject;
    XCTAssertNotNil(pisteCyclable);

    // There is one bad point in here
    XCTAssertEqual(pisteCyclable.geom.count, (NSUInteger)2);
}

@end
