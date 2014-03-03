//
//  GVPathLoader.h
//  GatineauVelo
//
//  Created by Philippe on 2014-03-01.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef void (^GVPathLoaderComplete)(void);

@class GVContext;

@interface GVPathLoader : NSObject

@property (readonly) GVContext *context;
@property (assign) MKCoordinateRegion boundingRegion;

- (instancetype)initWithContext:(GVContext *)context;

- (void)loadBikePathsAtURL:(NSURL *)url withCompletion:(GVPathLoaderComplete)completion;

@end
