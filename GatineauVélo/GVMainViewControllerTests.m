//
//  GVMainViewControllerTests.m
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GVMainViewController.h"

@interface GVMainViewControllerTests : XCTestCase

@property (strong) GVMainViewController *controller;
@property (strong) UIStoryboard *storyboard;

@end

@implementation GVMainViewControllerTests

- (void)setUp
{
    [super setUp];
    self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GVMainViewController"];
}

- (void)tearDown
{
    self.controller = nil;
    self.storyboard = nil;
    [super tearDown];
}

- (void)testCreation
{
    XCTAssertNoThrow(self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GVMainViewController"]);
    XCTAssertNotNil(self.controller);

    XCTAssertNoThrow([self.controller view]);

    XCTAssertNotNil(self.controller.mapView);
}

@end
