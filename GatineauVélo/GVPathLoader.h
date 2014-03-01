//
//  GVPathLoader.h
//  GatineauVelo
//
//  Created by Philippe on 2014-03-01.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GVPathLoader : NSObject

@property (readonly) NSManagedObjectContext *managedObjectContext;

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context;

- (void)loadBikePathsAtURL:(NSURL *)url;

@end
