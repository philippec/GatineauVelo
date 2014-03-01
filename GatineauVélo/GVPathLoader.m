//
//  GVPathLoader.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-01.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVPathLoader.h"
#import "DDFileReader.h"
#import "GVPisteCyclable.h"
#import "GVPoint.h"

@interface GVPathLoader()

@property (strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation GVPathLoader

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context
{
    if (self = [super init])
    {
        _managedObjectContext = context;
    }

    return self;
}

@end
