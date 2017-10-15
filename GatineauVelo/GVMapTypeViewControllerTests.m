//
//  GVMapTypeViewControllerTests.m
//  GatineauVelo
//
//  Created by Philippe on 2017-04-16.
//  Copyright (c) 2017 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "GVMapTypeViewController.h"
#import <MapKit/MapKit.h>

@interface GVMapTypeViewControllerTests : XCTestCase

@property (strong) GVMapTypeViewController *controller;
@property (strong) UIStoryboard *storyboard;
@property (strong) id mockUserDefaults;

@end

@implementation GVMapTypeViewControllerTests

- (void)setUp
{
    [super setUp];
    self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GVMapTypeViewController"];
    self.mockUserDefaults = [OCMockObject mockForClass:[NSUserDefaults class]];
}

- (void)tearDown
{
    self.controller = nil;
    self.storyboard = nil;
    self.mockUserDefaults = nil;
    [super tearDown];
}

- (void)testCreation
{
    XCTAssertNoThrow(self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GVMapTypeViewController"]);
    XCTAssertNotNil(self.controller);

    XCTAssertNoThrow([self.controller view]);

    XCTAssertNotNil(self.controller.userDefaults);
    XCTAssertNotNil(self.controller.standardViewCell);
    XCTAssertNotNil(self.controller.satelliteViewCell);
    XCTAssertNotNil(self.controller.hybridViewCell);

    XCTAssertNoThrow(self.controller.userDefaults = self.mockUserDefaults);
    XCTAssertEqualObjects(self.controller.userDefaults, self.mockUserDefaults);
}

- (void)testToggleMapType
{
    XCTAssertNoThrow(self.controller.userDefaults = self.mockUserDefaults);

    MKMapType mapType = MKMapTypeSatellite;
    [[[self.mockUserDefaults expect] andReturnValue:OCMOCK_VALUE(mapType)] integerForKey:@"mapType"];

    XCTAssertNoThrow([self.controller view]);
    XCTAssertEqual(self.controller.standardViewCell.accessoryType, UITableViewCellAccessoryNone);
    XCTAssertEqual(self.controller.satelliteViewCell.accessoryType, UITableViewCellAccessoryCheckmark);
    XCTAssertEqual(self.controller.hybridViewCell.accessoryType, UITableViewCellAccessoryNone);

    XCTAssertNoThrow([self.mockUserDefaults verify]);

    [[self.mockUserDefaults expect] setInteger:MKMapTypeHybrid forKey:@"mapType"];
    mapType = MKMapTypeHybrid;
    [[[self.mockUserDefaults expect] andReturnValue:OCMOCK_VALUE(mapType)] integerForKey:@"mapType"];
    [[self.mockUserDefaults expect] synchronize];

    XCTAssertNoThrow([self.controller tableView:self.controller.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]);

    XCTAssertNoThrow([self.mockUserDefaults verify]);
    
}

@end
