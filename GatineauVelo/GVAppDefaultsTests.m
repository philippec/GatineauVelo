//
//  GVAppDefaultsTests.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-01.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "GVAppDefaults.h"

@interface GVAppDefaultsTests : XCTestCase

@property (strong) GVAppDefaults *appDefaults;
@property (strong) id mockDefaults;

@end

@implementation GVAppDefaultsTests

- (void)setUp
{
    [super setUp];
    self.mockDefaults = [OCMockObject mockForClass:[NSUserDefaults class]];
}

- (void)tearDown
{
    self.mockDefaults = nil;
    self.appDefaults = nil;
    [super tearDown];
}

- (void)testCreation
{
    XCTAssertNoThrow(self.appDefaults = [[GVAppDefaults alloc] initWithUserDefaults:self.mockDefaults]);
    XCTAssertNotNil(self.appDefaults);

    MKCoordinateRegion region;
    XCTAssertNoThrow(region = self.appDefaults.maximumCityRegion);
    XCTAssertTrue(region.center.latitude != 0.0);
    XCTAssertTrue(region.center.longitude != 0.0);
    XCTAssertTrue(region.span.latitudeDelta > 0.0);
    XCTAssertTrue(region.span.longitudeDelta > 0.0);

    UIColor *color;
    NSUInteger idx = 1;
    [[[self.mockDefaults expect] andReturnValue:OCMOCK_VALUE(idx)] integerForKey:@"standardColor"];
    XCTAssertNoThrow(color = [self.appDefaults colorNamed:@"standardColor"]);
    XCTAssertNotNil(color);
    XCTAssertNoThrow([self.mockDefaults verify]);

    NSArray *colors;
    XCTAssertNoThrow(colors = [self.appDefaults colorsForName:@"standardColor"]);
    XCTAssertTrue(colors.count > 0);

    NSString *fileName;
    XCTAssertNoThrow(fileName = self.appDefaults.csvFileName);
    XCTAssertEqualObjects(fileName, @"PISTE_CYCLABLE");
}

@end
