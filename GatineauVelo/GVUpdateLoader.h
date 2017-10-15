//
//  GVUpdateLoader.h
//  GatineauVelo
//
//  Created by Philippe on 2017-10-14.
//  Copyright (c) 2017 Philippe Casgrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GVUpdateLoader : NSObject

- (NSArray *)loadUpdatesAtURL:(NSURL *)url;

@end
