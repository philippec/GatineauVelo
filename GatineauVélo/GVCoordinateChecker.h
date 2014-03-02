//
//  GVCoordinateChecker.h
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GVCoordinateChecker : NSObject

+ (instancetype)coordinateCheckerWithRegion:(MKCoordinateRegion)region;

- (BOOL)coordinateInRegion:(CLLocationCoordinate2D)coordinates;

@end
