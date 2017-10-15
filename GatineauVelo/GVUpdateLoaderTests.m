//
//  GVUpdateLoaderTests.m
//  GatineauVelo
//
//  Created by Philippe on 2017-10-14.
//  Copyright (c) 2017 Philippe Casgrain. All rights reserved.
//

#import "GVTestCase.h"
#import "GVUpdateLoader.h"

@interface GVUpdateLoaderTests : GVTestCase
@end

@implementation GVUpdateLoaderTests

- (void)testCreation
{
    GVUpdateLoader *loader;
    XCTAssertNoThrow(loader = [[GVUpdateLoader alloc] init]);
    XCTAssertNotNil(loader);

    NSURL *fileURL = [[self dataFolder] URLByAppendingPathComponent:@"update.json"];
    NSArray *expectedArray = @[@"abc", @"def"];
    NSArray *readArray;

    XCTAssertNoThrow(readArray = [loader loadUpdatesAtURL:fileURL]);
    XCTAssertEqualObjects(readArray, expectedArray);
}

@end
