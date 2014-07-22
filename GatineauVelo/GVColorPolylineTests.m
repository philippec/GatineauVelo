//
//  GVColorPolylineTests.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-01.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GVColorPolyline.h"

@interface GVColorPolylineTests : XCTestCase
@end

@implementation GVColorPolylineTests

- (void)testCreation
{
    GVColorPolyline *polyLine;
    XCTAssertNoThrow(polyLine = [[GVColorPolyline alloc] init]);
    XCTAssertNotNil(polyLine);

    UIColor *redColor = [UIColor redColor];
    XCTAssertNoThrow(polyLine.color = redColor);
    XCTAssertEqualObjects(polyLine.color, redColor);
}

@end
