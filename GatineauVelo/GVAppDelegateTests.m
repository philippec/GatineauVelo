//
//  GVAppDelegateTests.m
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GVAppDelegate.h"
#import "GVPathLoader.h"

@interface GVAppDelegateTests : XCTestCase

@end

@implementation GVAppDelegateTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testCreation
{
    GVAppDelegate *appDelegate;
    XCTAssertNoThrow(appDelegate = [[UIApplication sharedApplication] delegate]);
    XCTAssertNotNil(appDelegate);
    XCTAssertTrue([appDelegate isKindOfClass:[GVAppDelegate class]]);

    GVContext *context;
    XCTAssertNoThrow(context = appDelegate.context);
    XCTAssertNotNil(context);
}

@end
