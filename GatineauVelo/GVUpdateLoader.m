//
//  GVUpdateLoader.m
//  GatineauVelo
//
//  Created by Philippe on 2017-10-14.
//  Copyright (c) 2017 Philippe Casgrain. All rights reserved.
//

#import "GVUpdateLoader.h"


@implementation GVUpdateLoader

- (NSArray *)loadUpdatesAtURL:(NSURL *)url
{
    NSData *data = [NSData dataWithContentsOfURL:url];

    if (data.length == 0)
    {
        return nil;
    }

    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error)
    {
        NSLog(@"Error reading update file: %@", error);
    }

    return array;
}

@end
