//
//  GVWebViewDelegateTests.m
//  GatineauVelo
//
//  Created by Philippe on 17-04-03.
//  Copyright © 2017 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GVWebViewDelegate.h"

@interface GVWebViewDelegateTests : XCTestCase
@end

@implementation GVWebViewDelegateTests

- (void)testCreation
{
    GVWebViewDelegate *delegate;
    XCTAssertNoThrow(delegate = [[GVWebViewDelegate alloc] init]);
    XCTAssertNotNil(delegate);
    XCTAssertTrue([delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]);
}

@end
