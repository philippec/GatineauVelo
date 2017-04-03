//
//  GVUserLocationTests.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "GVUserLocation.h"

@interface GVUserLocationTests : XCTestCase

@property (strong) GVUserLocation *userLocation;

@end

@implementation GVUserLocationTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    self.userLocation = nil;
    [super tearDown];
}

- (void)testCreation
{
    __block BOOL wasCalled;
    GVUserLocationEnabledCallback cb = ^(BOOL enabled) {
        XCTAssertTrue(enabled);
        wasCalled = YES;
    };

    XCTAssertNoThrow(self.userLocation = [[GVUserLocation alloc] initWithBlock:cb]);
    XCTAssertNotNil(self.userLocation);

    id mockLocationManager = [OCMockObject mockForClass:[CLLocationManager class]];

    // Call delegate method
    XCTAssertNoThrow([self.userLocation locationManager:mockLocationManager didChangeAuthorizationStatus:kCLAuthorizationStatusAuthorizedAlways]);

    XCTAssertTrue(wasCalled);
}

@end
