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

- (NSSet *)extractCoordsFromString:(NSString *)coords
{
    NSMutableSet *s = [NSMutableSet setWithCapacity:0];

    GVCoordinateChecker *checker = [GVCoordinateChecker coordinateCheckerWithRegion:self.boundingRegion];

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

// String elements are quoted, we will remove the start-end quotes from them
- (NSArray *)removeQuotes:(NSArray *)elements
{
    NSMutableArray *result = [NSMutableArray arrayWithArray:elements];

    for (NSUInteger i = 0; i < result.count; i++)
    {
        NSString *oneElement = result[i];
        if ([oneElement hasPrefix:@"\""])
        {
            oneElement = [oneElement substringFromIndex:1];
        }
        if ([oneElement hasSuffix:@"\""])
        {
            oneElement = [oneElement substringToIndex:oneElement.length - 1];
        }
        result[i] = oneElement;
    }

    return [NSArray arrayWithArray:result];
}

- (void)loadBikePathsAtURL:(NSURL *)url withCompletion:(GVPathLoaderComplete)completion
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
            NSArray *elements = [[line stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsSeparatedByString:@","];
            elements = [self removeQuotes:elements];
            if (elements.count >= 12)
            {
                GVPisteCyclable *pisteCyclable = [NSEntityDescription insertNewObjectForEntityForName:@"GVPisteCyclable" inManagedObjectContext:self.context.managedObjectContext];
                pisteCyclable.munID = elements[0];
                pisteCyclable.codeID = elements[1];
                pisteCyclable.type = elements[2];
                pisteCyclable.route_verte = [elements[3] isEqualToString:@"Oui"] ? @YES : @NO;
                pisteCyclable.direc_uniq = [elements[4] isEqualToString:@"Oui"] ? @YES : @NO;
                pisteCyclable.status = elements[5];
                pisteCyclable.revetement = elements[6];
                pisteCyclable.proprio = elements[7];
                pisteCyclable.largeur = [f numberFromString:elements[8]];
                pisteCyclable.longueur = [f numberFromString:elements[9]];
                pisteCyclable.entiteID = elements[10];

                // Create a new string re-joining elements 11 to n
                NSArray *geom = [elements subarrayWithRange:NSMakeRange(11, elements.count - 11)];
                pisteCyclable.geom = [self extractCoordsFromString:[geom componentsJoinedByString:@","]];
            }
        }
        lineCounter++;
    }

    NSError *error;
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
