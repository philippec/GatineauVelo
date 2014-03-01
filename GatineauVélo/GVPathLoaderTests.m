//
//  GVPathLoaderTests.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-01.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GVPathLoader.h"

@interface GVPathLoaderTests : XCTestCase

@property (strong) GVPathLoader *pathLoader;

@end

@implementation GVPathLoaderTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    self.pathLoader = nil;
    [super tearDown];
}

- (void)testCreation
{
    XCTAssertNoThrow(self.pathLoader = [[GVPathLoader alloc] init]);
    XCTAssertNotNil(self.pathLoader);
}

@end
