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

- (void)loopFor:(NSTimeInterval)duration runloopMode:(NSString *)mode withCondition:(BOOL(^)(void))condition
{
    CFRunLoopTimerRef dummyTimer = CFRunLoopTimerCreate(NULL, INFINITY, 0, 0, 0, NULL, NULL);
    CFRunLoopAddTimer([[NSRunLoop currentRunLoop] getCFRunLoop], dummyTimer,(__bridge CFStringRef)mode);

    NSDate *start = [NSDate date];
    do
    {
        if (-[start timeIntervalSinceNow] > duration)
        {
            [NSException raise:NSGenericException format:@"Timed out"];
            break;
        }

        NSDate *beforeDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0.1];
        [[NSRunLoop currentRunLoop] runMode:mode beforeDate:beforeDate];
    }
    while (condition());

    CFRunLoopTimerInvalidate(dummyTimer);
    CFRelease(dummyTimer);
}

- (void)loopFor:(NSTimeInterval)interval withCondition:(BOOL(^)(void))condition
{
    [self loopFor:interval runloopMode:NSDefaultRunLoopMode withCondition:condition];
}

@end
