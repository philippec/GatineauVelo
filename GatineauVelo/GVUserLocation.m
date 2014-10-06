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
@property (copy) GVUserLocationEnabledCallback enabledCallback;
@property (assign) BOOL userHasAgreedToShareLocation;

@end

@implementation GVUserLocation

- (instancetype)initWithBlock:(GVUserLocationEnabledCallback)callback;
{
    if (self = [super init])
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [_locationManager requestWhenInUseAuthorization];
        }
        else
        {
            // Default on previous OS
            _userHasAgreedToShareLocation = YES;
        }
        _enabledCallback = [callback copy];
    }

    return self;
}

- (BOOL)locationServicesEnabled
{
    if (self.userHasAgreedToShareLocation)
    {
        return [CLLocationManager locationServicesEnabled];
    }
    return NO;
}

- (void)locateUserPositionWithBlock:(GVUserLocationCallback)callback
{
    self.locationCallback = callback;
    if (self.userHasAgreedToShareLocation)
    {
        [self.locationManager startUpdatingLocation];
    }
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
//    NSLog(@"%@", error);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (kCLAuthorizationStatusAuthorizedAlways == status || kCLAuthorizationStatusAuthorizedWhenInUse == status)
    {
        self.userHasAgreedToShareLocation = YES;
    }
    else
    {
        self.userHasAgreedToShareLocation = NO;
    }

    if (self.enabledCallback)
    {
        self.enabledCallback(self.userHasAgreedToShareLocation);
    }
}


@end
