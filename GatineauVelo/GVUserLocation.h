//
//  GVUserLocation.h
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


typedef void (^GVUserLocationCallback)(CLLocationCoordinate2D userPosition);

@interface GVUserLocation : NSObject <CLLocationManagerDelegate>

- (BOOL)locationServicesEnabled;

- (void)locateUserPositionWithBlock:(GVUserLocationCallback)callback;

@end
