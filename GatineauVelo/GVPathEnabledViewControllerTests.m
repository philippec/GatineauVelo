//
//  GVPathEnabledViewControllerTests.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "GVPathEnabledViewController.h"

@interface GVPathEnabledViewControllerTests : XCTestCase

@property (strong) GVPathEnabledViewController *controller;
@property (strong) UIStoryboard *storyboard;
@property (strong) id mockUserDefaults;

@end

@implementation GVPathEnabledViewControllerTests

- (void)setUp
{
    [super setUp];
    self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GVPathEnabledViewController"];
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
    XCTAssertNoThrow(self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GVPathEnabledViewController"]);
    XCTAssertNotNil(self.controller);

    XCTAssertNoThrow([self.controller view]);

    XCTAssertNotNil(self.controller.userDefaults);
    XCTAssertNotNil(self.controller.mainPathSwitch);
    XCTAssertNotNil(self.controller.routeVerteSwitch);
    XCTAssertNotNil(self.controller.updateSwitch);

    XCTAssertNoThrow(self.controller.userDefaults = self.mockUserDefaults);
    XCTAssertEqualObjects(self.controller.userDefaults, self.mockUserDefaults);
}

- (void)testToggleBikePath
{
    XCTAssertNoThrow(self.controller.userDefaults = self.mockUserDefaults);

    BOOL no = NO;
    [[[self.mockUserDefaults expect] andReturnValue:OCMOCK_VALUE(no)] boolForKey:@"mainPathsHidden"];
    [[[self.mockUserDefaults expect] andReturnValue:OCMOCK_VALUE(no)] boolForKey:@"routeVertePathsHidden"];
    [[[self.mockUserDefaults expect] andReturnValue:OCMOCK_VALUE(no)] boolForKey:@"dontUseUpdateColor"];

    XCTAssertNoThrow([self.controller view]);
    XCTAssertTrue(self.controller.mainPathSwitch.isOn);
    XCTAssertTrue(self.controller.routeVerteSwitch.isOn);
    XCTAssertTrue(self.controller.updateSwitch.isOn);

    XCTAssertNoThrow([self.mockUserDefaults verify]);

    [[self.mockUserDefaults expect] setBool:YES forKey:@"mainPathsHidden"];
    [[self.mockUserDefaults expect] synchronize];

    XCTAssertNoThrow(self.controller.mainPathSwitch.on = NO);
    XCTAssertNoThrow([self.controller toggleBikePath:self.controller.mainPathSwitch]);

    XCTAssertNoThrow([self.mockUserDefaults verify]);
    
    [[self.mockUserDefaults expect] setBool:YES forKey:@"routeVertePathsHidden"];
    [[self.mockUserDefaults expect] synchronize];

    XCTAssertNoThrow(self.controller.routeVerteSwitch.on = NO);
    XCTAssertNoThrow([self.controller toggleBikePath:self.controller.routeVerteSwitch]);

    XCTAssertNoThrow([self.mockUserDefaults verify]);

    [[self.mockUserDefaults expect] setBool:YES forKey:@"dontUseUpdateColor"];
    [[self.mockUserDefaults expect] synchronize];

    XCTAssertNoThrow(self.controller.updateSwitch.on = NO);
    XCTAssertNoThrow([self.controller toggleBikePath:self.controller.updateSwitch]);

    XCTAssertNoThrow([self.mockUserDefaults verify]);
}

@end
