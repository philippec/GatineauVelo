//
//  GVAboutViewControllerTests.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GVAboutViewController.h"

@interface GVAboutViewControllerTests : XCTestCase

@property (strong) GVAboutViewController *controller;
@property (strong) UIStoryboard *storyboard;

@end

@implementation GVAboutViewControllerTests

- (void)setUp
{
    [super setUp];
    self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GVAboutViewController"];
}

- (void)tearDown
{
    self.controller = nil;
    self.storyboard = nil;
    [super tearDown];
}

- (void)testCreation
{
    XCTAssertNoThrow(self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GVAboutViewController"]);
    XCTAssertNotNil(self.controller);

    XCTAssertNoThrow([self.controller view]);

    XCTAssertNotNil(self.controller.webView);
}

@end
