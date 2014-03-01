//
//  GVContextTests.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-01.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GVContext.h"

@interface GVContextTests : XCTestCase

@property (strong) GVContext *context;

@end

@implementation GVContextTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    self.context = nil;
    [super tearDown];
}

- (void)testCreation
{
    XCTAssertNoThrow(self.context = [[GVContext alloc] init]);
    XCTAssertNotNil(self.context);
}

@end
