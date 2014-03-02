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

- (NSSet *)extractCoordsFromString:(NSString *)coords
{
    NSMutableSet *s = [NSMutableSet setWithCapacity:0];

    CGFloat minLat =  -90.0;
    CGFloat maxLat =   90.0;
    CGFloat minLong = -90.0;
    CGFloat maxLong =  90.0;

    if (self.boundingRegion.span.latitudeDelta > 0 && self.boundingRegion.span.longitudeDelta > 0)
    {
        minLat = self.boundingRegion.center.latitude - self.boundingRegion.span.latitudeDelta / 2.0;
        maxLat = self.boundingRegion.center.latitude + self.boundingRegion.span.latitudeDelta / 2.0;
        minLong = self.boundingRegion.center.longitude - self.boundingRegion.span.longitudeDelta / 2.0;
        maxLong = self.boundingRegion.center.longitude + self.boundingRegion.span.longitudeDelta / 2.0;
    }

    NSString *coordsWithoutLinestring = [coords substringFromIndex:@"LINESTRING (".length];
    NSString *coordsWithoutBraces = [coordsWithoutLinestring substringToIndex:coordsWithoutLinestring.length - 2];
    NSArray *allCoords = [coordsWithoutBraces componentsSeparatedByString:@","];
    NSUInteger count = 0;
    for (NSString *oneCoord in allCoords)
    {
        NSScanner *scanner = [NSScanner scannerWithString:oneCoord];

        double latitude, longitude;
        [scanner scanDouble:&longitude];
        [scanner scanDouble:&latitude];

        if (latitude < minLat || latitude > maxLat || longitude < minLong || longitude > maxLong)
        {
            NSLog(@"pt outside of coord space {%g %g}", latitude, longitude);
            continue;
        }

        GVPoint *pt = [NSEntityDescription insertNewObjectForEntityForName:@"GVPoint" inManagedObjectContext:self.managedObjectContext];

        pt.latitude = [NSNumber numberWithDouble:latitude];
        pt.longitude = [NSNumber numberWithDouble:longitude];
        pt.order = [NSNumber numberWithUnsignedInteger:count];

        [s addObject:pt];
        count++;
    }

    return [NSSet setWithSet:s];
}

- (void)loadBikePathsAtURL:(NSURL *)url
{
    DDFileReader *reader = [[DDFileReader alloc] initWithFilePath:url.filePathURL.path];
    reader.lineDelimiter = @"\r";
    NSUInteger lineCounter = 0;
    NSString *line;
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];

    while ((line = [reader readLine]))
    {
        // Skip the first line as it contains just the headers
        if (lineCounter > 0)
        {
            NSArray *elements = [line componentsSeparatedByString:@"|"];
            if (elements.count == 12)
            {
                GVPisteCyclable *pisteCyclable = [NSEntityDescription insertNewObjectForEntityForName:@"GVPisteCyclable" inManagedObjectContext:self.managedObjectContext];
                pisteCyclable.entiteID = elements[0];
                pisteCyclable.munID = elements[1];
                pisteCyclable.codeID = elements[2];
                pisteCyclable.type = elements[3];
                pisteCyclable.route_verte = [elements[4] isEqualToString:@"Oui"] ? @YES : @NO;
                pisteCyclable.direc_uniq = [elements[5] isEqualToString:@"Oui"] ? @YES : @NO;
                pisteCyclable.status = elements[6];
                pisteCyclable.revetement = elements[7];
                pisteCyclable.proprio = elements[8];
                pisteCyclable.largeur = [f numberFromString:elements[9]];
                pisteCyclable.longueur = [f numberFromString:elements[10]];

                pisteCyclable.geom = [self extractCoordsFromString:elements[11]];
            }
        }
        lineCounter++;
    }

    NSError *error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Erreur: %@", error);
    }
}

@end
