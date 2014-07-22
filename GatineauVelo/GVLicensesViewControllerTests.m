//
//  GVLicensesViewControllerTests.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GVLicensesViewController.h"

@interface GVLicensesViewControllerTests : XCTestCase

@property (strong) GVLicensesViewController *controller;
@property (strong) UIStoryboard *storyboard;

@end

@implementation GVLicensesViewControllerTests

- (void)setUp
{
    [super setUp];
    self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GVLicensesViewController"];
}

- (void)tearDown
{
    self.controller = nil;
    self.storyboard = nil;
    [super tearDown];
}

- (void)testCreation
{
    XCTAssertNoThrow(self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GVLicensesViewController"]);
    XCTAssertNotNil(self.controller);

    XCTAssertNoThrow([self.controller view]);

    XCTAssertNotNil(self.controller.webView);
}

@end
