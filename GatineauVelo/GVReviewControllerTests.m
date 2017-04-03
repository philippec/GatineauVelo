//
//  GVReviewControllerTests.m
//  GatineauVelo
//
//  Created by Philippe on 17-04-03.
//  Copyright © 2017 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "GVReviewController.h"
#import <StoreKit/StoreKit.h>

@interface GVReviewControllerTests : XCTestCase

@end

@implementation GVReviewControllerTests

- (void)testRequestReview
{
    if (![SKStoreReviewController class])
    {
        return;
    }

    GVReviewController *controller;

    id mockDefaults = [OCMockObject mockForClass:[NSUserDefaults class]];

    XCTAssertNoThrow(controller = [[GVReviewController alloc] initWithDefaults:mockDefaults]);
    XCTAssertNotNil(controller);

    // Install a class mock for SKStoreReviewController
    id classMock = OCMClassMock([SKStoreReviewController class]);

    NSInteger numLaunches = 1;
    [[[mockDefaults expect] andReturnValue:OCMOCK_VALUE(numLaunches)] integerForKey:@"Number of launches"];
    [[mockDefaults expect] setInteger:2 forKey:@"Number of launches"];

    XCTAssertNoThrow([controller requestReview]);

    XCTAssertNoThrow([mockDefaults verify]);
    XCTAssertNoThrow([classMock verify]);

    // What if we already launched 9 times?
    numLaunches = 9;
    [[[mockDefaults expect] andReturnValue:OCMOCK_VALUE(numLaunches)] integerForKey:@"Number of launches"];
    [[mockDefaults expect] setInteger:10 forKey:@"Number of launches"];

    __block BOOL wasCalled = NO;
    [[[classMock expect] andDo:^(NSInvocation *invocation) {
        wasCalled = YES;
    }] requestReview];
    
    XCTAssertNoThrow([controller requestReview]);
    
    XCTAssertNoThrow([mockDefaults verify]);
    XCTAssertNoThrow([classMock verify]);
    XCTAssertTrue(wasCalled);
}

@end
