//
//  GVUserLocation.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-02.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVUserLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface GVUserLocation()

@property (strong) CLLocationManager *locationManager;
@property (copy) GVUserLocationCallback locationCallback;

@end

@implementation GVUserLocation

- (instancetype)init
{
    if (self = [super init])
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }

    return self;
}

- (BOOL)locationServicesEnabled
{
    return [CLLocationManager locationServicesEnabled];
}

- (void)locateUserPositionWithBlock:(GVUserLocationCallback)callback
{
    self.locationCallback = callback;
    [self.locationManager startUpdatingLocation];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation *location = [locations lastObject];
    NSDate *eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0)
    {
        [self.locationManager stopUpdatingLocation];
        if (self.locationCallback)
        {
            self.locationCallback(location.coordinate);
        }

    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"%zd", status);
}


@end
