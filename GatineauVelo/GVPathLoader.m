//
//  GVPathLoader.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-01.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVPathLoader.h"
#import "GVPisteCyclable.h"
#import "GVPoint.h"
#import "GVCoordinateChecker.h"
#import "GVContext.h"

@interface GVPathLoader()

@property (strong) GVContext *context;

@end

@implementation GVPathLoader

- (instancetype)initWithContext:(GVContext *)context
{
    if (self = [super init])
    {
        _context = context;
    }

    return self;
}

- (NSSet *)extractCoordsFromArray:(NSArray *)coords
{
    NSMutableSet *s = [NSMutableSet setWithCapacity:0];

    GVCoordinateChecker *checker = [GVCoordinateChecker coordinateCheckerWithRegion:self.boundingRegion];

    NSUInteger count = 0;
    for (NSDictionary *oneCoord in coords)
    {
        double latitude = [oneCoord[@"latitude"] doubleValue];
        double longitude = [oneCoord[@"longitude"] doubleValue];

        if (![checker coordinateInRegion:CLLocationCoordinate2DMake(latitude, longitude)])
        {
            continue;
        }

        GVPoint *pt = [NSEntityDescription insertNewObjectForEntityForName:@"GVPoint" inManagedObjectContext:self.context.managedObjectContext];

        pt.latitude = [NSNumber numberWithDouble:latitude];
        pt.longitude = [NSNumber numberWithDouble:longitude];
        pt.order = [NSNumber numberWithUnsignedInteger:count];

        [s addObject:pt];
        count++;
    }

    return [NSSet setWithSet:s];
}

- (void)loadBikePathsAtURL:(NSURL *)url withCompletion:(GVPathLoaderComplete)completion
{
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (![json isKindOfClass:[NSArray class]])
    {
        NSLog(@"Erreur: %@", error);
        return;
    }

    for (NSDictionary *dict in json)
    {
        if (dict.count == 12)
        {
            GVPisteCyclable *pisteCyclable = [NSEntityDescription insertNewObjectForEntityForName:@"GVPisteCyclable" inManagedObjectContext:self.context.managedObjectContext];
            pisteCyclable.entiteID = dict[@"entiteID"];
            pisteCyclable.munID = dict[@"munID"];
            pisteCyclable.codeID = dict[@"codeID"];
            pisteCyclable.type = dict[@"type"];
            pisteCyclable.route_verte = [dict[@"route_verte"] isEqualToString:@"Oui"] ? @YES : @NO;
            pisteCyclable.direc_uniq = [dict[@"direc_uniq"] isEqualToString:@"Oui"] ? @YES : @NO;
            pisteCyclable.status = dict[@"status"];
            pisteCyclable.revetement = dict[@"revetement"];
            pisteCyclable.proprio = dict[@"proprio"];
            pisteCyclable.largeur = dict[@"largeur"];
            pisteCyclable.longueur = dict[@"longueur"];

            pisteCyclable.geom = [self extractCoordsFromArray:dict[@"geom"]];
        }
    }

    if (![self.context.managedObjectContext save:&error])
    {
        NSLog(@"Erreur: %@", error);
    }

    if (completion)
    {
        completion();
    }
}

@end
