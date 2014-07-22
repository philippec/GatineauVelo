//
//  GVTestCase.m
//  Check-In
//
//  Created by Philippe on 2014-02-13.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVTestCase.h"

@implementation GVTestCase

- (NSURL *)dataFolder
{
    NSURL *resourcesURL = [[NSBundle bundleForClass:self.class] resourceURL];
    NSURL *testFolderURL = [resourcesURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@Data/", NSStringFromClass([self class])]];

    return testFolderURL;
}

@end
