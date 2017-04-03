//
//  GVReviewController.m
//  GatineauVelo
//
//  Created by Philippe on 17-04-03.
//  Copyright © 2017 Philippe Casgrain. All rights reserved.
//

#import "GVReviewController.h"
#import <StoreKit/StoreKit.h>

NSString * const kNumLaunches = @"Number of launches";
NSInteger const kNumLaunchesModulus = 10;

@interface GVReviewController()

@property (nonatomic, strong) NSUserDefaults *defaults;

@end

@implementation GVReviewController

- (instancetype)initWithDefaults:(NSUserDefaults *)defaults
{
    if (self = [super init])
    {
        self.defaults = defaults;
    }
    return self;
}

- (void)dealloc
{
    self.defaults = nil;
}

- (void)requestReview
{
    // Check if the app was already launched
    NSInteger numLaunches = [self.defaults integerForKey:kNumLaunches];
    [self.defaults setInteger:++numLaunches forKey:kNumLaunches];

    if ([SKStoreReviewController class] && (numLaunches % kNumLaunchesModulus == 0))
    {
        [SKStoreReviewController requestReview];
    }
}

@end
