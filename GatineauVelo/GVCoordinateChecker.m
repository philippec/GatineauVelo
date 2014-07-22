//
//  GVCoordinateChecker.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVCoordinateChecker.h"

@interface GVCoordinateChecker()

@property (assign) MKCoordinateRegion region;

@end

@implementation GVCoordinateChecker

+ (instancetype)coordinateCheckerWithRegion:(MKCoordinateRegion)region
{
    GVCoordinateChecker *checker = [[GVCoordinateChecker alloc] init];
    checker.region = region;

    return checker;
}

- (BOOL)coordinateInRegion:(CLLocationCoordinate2D)coordinates
{
    CGFloat minLat =  -90.0;
    CGFloat maxLat =   90.0;
    CGFloat minLong = -90.0;
    CGFloat maxLong =  90.0;

    if (self.region.span.latitudeDelta > 0 && self.region.span.longitudeDelta > 0)
    {
        minLat = self.region.center.latitude - self.region.span.latitudeDelta / 2.0;
        maxLat = self.region.center.latitude + self.region.span.latitudeDelta / 2.0;
        minLong = self.region.center.longitude - self.region.span.longitudeDelta / 2.0;
        maxLong = self.region.center.longitude + self.region.span.longitudeDelta / 2.0;
    }

    if (coordinates.latitude < minLat || coordinates.latitude > maxLat || coordinates.longitude < minLong || coordinates.longitude > maxLong)
    {
        //NSLog(@"pt outside of coord space {%g %g}", coordinates.latitude, coordinates.longitude);
        return NO;
    }

    return YES;
}

@end
