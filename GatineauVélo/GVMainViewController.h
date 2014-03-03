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

@interface GVMainViewController : UIViewController <GVFlipsideViewControllerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong) UIColor *standardColor;
@property (strong) UIColor *routeVerteColor;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, strong) GVUserLocation *userLocation;
@property (strong, nonatomic) GVPathLoader *pathLoader;


@property (strong) IBOutlet MKMapView *mapView;

@end
