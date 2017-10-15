//
//  GVPathColorsViewControllerTests.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "GVPathColorsViewController.h"
#import "GVAppDefaults.h"

@interface GVPathColorsViewControllerTests : XCTestCase

@property (strong) GVPathColorsViewController *controller;
@property (strong) UIStoryboard *storyboard;
@property (strong) id mockAppDefaults;

@end

@implementation GVPathColorsViewControllerTests

- (void)setUp
{
    [super setUp];
    self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GVPathColorsViewController"];
    self.mockAppDefaults = [OCMockObject mockForClass:[GVAppDefaults class]];
}

- (void)tearDown
{
    self.controller = nil;
    self.storyboard = nil;
    self.mockAppDefaults = nil;
    [super tearDown];
}

- (void)testCreation
{
    XCTAssertNoThrow(self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GVPathColorsViewController"]);
    XCTAssertNotNil(self.controller);

    XCTAssertNoThrow([self.controller view]);

    XCTAssertNotNil(self.controller.appDefaults);
    XCTAssertNotNil(self.controller.mainPathColorView);
    XCTAssertNotNil(self.controller.routeVerteColorView);
    XCTAssertNotNil(self.controller.updatedPathColorView);

    XCTAssertNoThrow(self.controller.appDefaults = self.mockAppDefaults);
    XCTAssertEqualObjects(self.controller.appDefaults, self.mockAppDefaults);
}

- (void)testColors
{
    XCTAssertNoThrow(self.controller.appDefaults = self.mockAppDefaults);

    [[[self.mockAppDefaults expect] andReturn:[UIColor redColor]] colorNamed:@"standardColor"];
    [[[self.mockAppDefaults expect] andReturn:[UIColor brownColor]] colorNamed:@"routeVerteColor"];
    [[[self.mockAppDefaults expect] andReturn:[UIColor yellowColor]] colorNamed:@"updateColor"];


    XCTAssertNoThrow([self.controller view]);
    XCTAssertEqualObjects(self.controller.mainPathColorView.backgroundColor, [UIColor redColor]);
    XCTAssertEqualObjects(self.controller.routeVerteColorView.backgroundColor, [UIColor brownColor]);
    XCTAssertEqualObjects(self.controller.updatedPathColorView.backgroundColor, [UIColor yellowColor]);

    XCTAssertNoThrow([self.mockAppDefaults verify]);

}

@end
