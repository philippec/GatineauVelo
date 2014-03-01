//
//  GVPathLoaderTests.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-01.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "GVPathLoader.h"

@interface GVPathLoaderTests : XCTestCase

@property (strong) GVPathLoader *pathLoader;
@property (strong) id mockContext;

@end

@implementation GVPathLoaderTests

- (void)setUp
{
    [super setUp];
    self.mockContext = [OCMockObject mockForClass:[NSManagedObjectContext class]];
}

- (void)tearDown
{
    self.mockContext = nil;
    self.pathLoader = nil;
    [super tearDown];
}

- (void)testCreation
{
    XCTAssertNoThrow(self.pathLoader = [[GVPathLoader alloc] initWithManagedObjectContext:self.mockContext]);
    XCTAssertNotNil(self.pathLoader);

    XCTAssertEqualObjects(self.pathLoader.managedObjectContext, self.mockContext);
}

@end
