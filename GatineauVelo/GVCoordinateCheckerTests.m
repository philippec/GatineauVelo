//
//  GVCoordinateCheckerTests.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GVCoordinateChecker.h"

@interface GVCoordinateCheckerTests : XCTestCase

@property (strong) GVCoordinateChecker *checker;
@property (assign) MKCoordinateRegion region;

@end

@implementation GVCoordinateCheckerTests

- (void)setUp
{
    [super setUp];
    self.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(45, -75), MKCoordinateSpanMake(1.3, 2.7));
}

- (void)tearDown
{
    self.checker = nil;
    [super tearDown];
}

- (void)testCreation
{
    XCTAssertNoThrow(self.checker = [GVCoordinateChecker coordinateCheckerWithRegion:self.region]);
    XCTAssertNotNil(self.checker);
}

- (void)testCoordinatesInRegion
{
    XCTAssertNoThrow(self.checker = [GVCoordinateChecker coordinateCheckerWithRegion:self.region]);

    BOOL result;
    XCTAssertNoThrow(result = [self.checker coordinateInRegion:CLLocationCoordinate2DMake(45, -75)]);
    XCTAssertTrue(result);

    XCTAssertNoThrow(result = [self.checker coordinateInRegion:CLLocationCoordinate2DMake(48, -75)]);
    XCTAssertFalse(result);

    XCTAssertNoThrow(result = [self.checker coordinateInRegion:CLLocationCoordinate2DMake(45.3, -76.3)]);
    XCTAssertTrue(result);

    XCTAssertNoThrow(result = [self.checker coordinateInRegion:CLLocationCoordinate2DMake(45, +75)]);
    XCTAssertFalse(result);

}

@end
