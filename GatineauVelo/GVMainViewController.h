//
//  GVMainViewController.h
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVFlipsideViewController.h"

#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@class GVUserLocation;
@class GVPathLoader;
@class GVUpdateLoader;
@class GVContext;

@interface GVMainViewController : UIViewController <GVFlipsideViewControllerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) GVContext *context;
@property (copy, nonatomic) NSArray *updateCodes;
@property (strong) UIColor *standardColor;
@property (strong) UIColor *routeVerteColor;
@property (strong) UIColor *updateColor;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, strong) GVUserLocation *userLocation;
@property (strong, nonatomic) GVPathLoader *pathLoader;
@property (strong, nonatomic) GVUpdateLoader *updateLoader;
@property (strong) NSTimer *updateTimer;
@property (readonly) CFTimeInterval updateTimerInterval;

@property (strong) IBOutlet MKMapView *mapView;

- (void)appDidBecomeActive;

@end
