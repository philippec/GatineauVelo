//
//  GVUserLocationTests.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
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
    XCTAssertNoThrow(self.userLocation = [[GVUserLocation alloc] init]);
    XCTAssertNotNil(self.userLocation);
}

@end
