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

@interface GVMainViewController : UIViewController <GVFlipsideViewControllerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong) UIColor *standardColor;
@property (strong) UIColor *routeVerteColor;

@property (strong) IBOutlet MKMapView *mapView;

@end
