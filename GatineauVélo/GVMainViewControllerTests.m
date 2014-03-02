//
//  GVMainViewControllerTests.m
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVTestCase.h"
#import "GVMainViewController.h"
#import "GVPathLoader.h"
#import "GVContext.h"

@interface GVMainViewControllerTests : GVTestCase

@property (strong) GVMainViewController *controller;
@property (strong) UIStoryboard *storyboard;
@property (strong) GVPathLoader *pathLoader;
@property (strong) GVContext *context;

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
}

- (void)tearDown
{
    self.controller = nil;
    self.storyboard = nil;
    self.context = nil;
    self.pathLoader = nil;
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
}

- (void)testColors
{
    XCTAssertNoThrow(self.controller.standardColor = [UIColor redColor]);
    XCTAssertEqualObjects(self.controller.standardColor, [UIColor redColor]);

    XCTAssertNoThrow(self.controller.routeVerteColor = [UIColor blueColor]);
    XCTAssertEqualObjects(self.controller.routeVerteColor, [UIColor blueColor]);
}

@end
