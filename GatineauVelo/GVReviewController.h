//
//  GVReviewController.h
//  GatineauVelo
//
//  Created by Philippe on 17-04-03.
//  Copyright © 2017 Philippe Casgrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GVReviewController : NSObject

- (instancetype)initWithDefaults:(NSUserDefaults *)defaults;
- (void)requestReview;

@end
