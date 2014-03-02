//
//  GVFlipsideViewControllerTests.m
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GVFlipsideViewController.h"

@interface GVFlipsideViewControllerTests : XCTestCase

@property (strong) GVFlipsideViewController *controller;
@property (strong) UIStoryboard *storyboard;

@end

@implementation GVFlipsideViewControllerTests

- (void)setUp
{
    [super setUp];
    self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GVFlipsideViewController"];
}

- (void)tearDown
{
    self.controller = nil;
    self.storyboard = nil;
    [super tearDown];
}

- (void)testCreation
{
    XCTAssertNoThrow(self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GVFlipsideViewController"]);
    XCTAssertNotNil(self.controller);

    XCTAssertNoThrow([self.controller view]);
    XCTAssertNotNil(self.controller.navigationController);
    XCTAssertEqualObjects(self.controller.navigationController.delegate, self.controller);
    XCTAssertNotNil(self.controller.backButton);
    XCTAssertFalse(self.controller.backButton.enabled);
}

@end
