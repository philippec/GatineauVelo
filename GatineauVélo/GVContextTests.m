//
//  GVContextTests.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-01.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVTestCase.h"
#import "GVContext.h"
#import "GVPathLoader.h"

@interface GVContextTests : GVTestCase

@property (strong) GVContext *context;

@end

@implementation GVContextTests

- (void)setUp
{
    [super setUp];
    self.context = [[GVContext alloc] init];
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

- (void)testNeedsContent
{
    BOOL result;

    // Empty content needs content
    XCTAssertNoThrow(result = self.context.needsContent);
    XCTAssertTrue(result);

    // Load some data
    GVPathLoader *pathLoader = [[GVPathLoader alloc] initWithContext:self.context];
    NSURL *fileURL = [[self dataFolder] URLByAppendingPathComponent:@"pistes_cyclables_10.csv"];
    [pathLoader loadBikePathsAtURL:fileURL withCompletion:nil];

    XCTAssertNoThrow(result = self.context.needsContent);
    XCTAssertFalse(result);
}

@end
