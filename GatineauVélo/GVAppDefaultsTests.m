//
//  GVAppDefaultsTests.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-01.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GVAppDefaults.h"

@interface GVAppDefaultsTests : XCTestCase

@property (strong) GVAppDefaults *appDefaults;

@end

@implementation GVAppDefaultsTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    self.appDefaults = nil;
    [super tearDown];
}

- (void)testCreation
{
    XCTAssertNoThrow(self.appDefaults = [[GVAppDefaults alloc] init]);
    XCTAssertNotNil(self.appDefaults);
}

@end
