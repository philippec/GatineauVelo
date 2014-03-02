//
//  GVMainViewControllerTests.m
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVTestCase.h"
#import <OCMock/OCMock.h>
#import "GVMainViewController.h"
#import "GVPathLoader.h"
#import "GVContext.h"
#import "GVUserLocation.h"

@interface GVMainViewControllerTests : GVTestCase

@property (strong) GVMainViewController *controller;
@property (strong) UIStoryboard *storyboard;
@property (strong) GVPathLoader *pathLoader;
@property (strong) GVContext *context;
@property (strong) id mockUserDefaults;
@property (strong) id mockUserLocation;

@end

@implementation GVMainViewControllerTests

- (void)setUp
{
    [super setUp];
    self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GVMainViewController"];

    self.context = [[GVContext alloc] init];
    self.pathLoader = [[GVPathLoader alloc] initWithManagedObjectContext:self.context.managedObjectContext];

    NSURL *fileURL = [[self dataFolder] URLByAppendingPathComponent:@"pistes_cyclables_10.csv"];
    [self.pathLoader loadBikePathsAtURL:fileURL];

    self.mockUserDefaults = [OCMockObject mockForClass:[NSUserDefaults class]];
    self.mockUserLocation = [OCMockObject mockForClass:[GVUserLocation class]];

    self.controller.userLocation = self.mockUserLocation;
}

- (void)tearDown
{
    self.controller = nil;
    self.storyboard = nil;
    self.context = nil;
    self.pathLoader = nil;
    self.mockUserDefaults = nil;
    self.mockUserLocation = nil;
    [super tearDown];
}

- (void)testCreation
{
    XCTAssertNoThrow(self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GVMainViewController"]);
    XCTAssertNotNil(self.controller);

    XCTAssertNoThrow(self.controller.managedObjectContext = self.context.managedObjectContext);
    XCTAssertEqualObjects(self.controller.managedObjectContext, self.context.managedObjectContext);

    XCTAssertNoThrow([self.controller view]);

    XCTAssertNotNil(self.controller.mapView);
    XCTAssertEqualObjects(self.controller.mapView.delegate, self.controller);

    XCTAssertNotNil(self.controller.userDefaults);
    XCTAssertNoThrow(self.controller.userDefaults = self.mockUserDefaults);
    XCTAssertEqualObjects(self.controller.userDefaults, self.mockUserDefaults);

    XCTAssertNotNil(self.controller.userLocation);
    XCTAssertNoThrow(self.controller.userLocation = self.mockUserLocation);
    XCTAssertEqualObjects(self.controller.userLocation, self.mockUserLocation);
}

- (void)testColors
{
    XCTAssertNoThrow(self.controller.standardColor = [UIColor redColor]);
    XCTAssertEqualObjects(self.controller.standardColor, [UIColor redColor]);

    XCTAssertNoThrow(self.controller.routeVerteColor = [UIColor blueColor]);
    XCTAssertEqualObjects(self.controller.routeVerteColor, [UIColor blueColor]);
}

@end
