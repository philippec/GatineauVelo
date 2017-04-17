//
//  GVMainViewController.m
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVMainViewController.h"
#import "GVPisteCyclable.h"
#import "GVPoint.h"
#import "GVColorPolyline.h"
#import "GVUserLocation.h"
#import "GVAppDefaults.h"
#import "GVCoordinateChecker.h"
#import "GVPathLoader.h"
#import "GVReviewController.h"
#import "GVContext.h"
#import "MBProgressHUD.h"

@interface GVMainViewController ()

@property (strong) GVAppDefaults *appDefaults;
@property (assign) MKCoordinateRegion selectedRegion;
@property (assign) CFTimeInterval updateTimerInterval;
@property (strong) NSDate *userLocationCalledDate;
@property (strong) GVReviewController *reviewController;

@end

static const double kUpdateInterval = 300.0;

@implementation GVMainViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.selectedRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(45.4728, -75.7949), MKCoordinateSpanMake(0.25, 0.22));
    self.routeVerteColor = [UIColor greenColor];
    self.standardColor = [UIColor orangeColor];

    self.appDefaults = [[GVAppDefaults alloc] init];
    self.updateTimerInterval = kUpdateInterval;
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:self.updateTimerInterval target:self selector:@selector(updateUserLocation) userInfo:nil repeats:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.context.needsContent)
    {
        self.pathLoader.boundingRegion = self.appDefaults.maximumCityRegion;

        NSURL *url = [[NSBundle mainBundle] URLForResource:self.appDefaults.csvFileName withExtension:@"csv"];

        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.pathLoader loadBikePathsAtURL:url withCompletion:^(void) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }

    self.mapView.region = self.selectedRegion;

    [self.updateTimer fire];

    [self updateAllOverlays];

    if (!self.reviewController)
    {
        self.reviewController = [[GVReviewController alloc] initWithDefaults:self.userDefaults];
    }
    [self.reviewController requestReview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.reviewController = nil;
}

- (void)appDidBecomeActive
{
	[self.updateTimer fire];
}


- (NSUserDefaults *)userDefaults
{
    if (!_userDefaults)
    {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }

    return _userDefaults;
}

#pragma mark - User location

- (GVUserLocation *)userLocation
{
    if (!_userLocation)
    {
        _userLocation = [[GVUserLocation alloc] initWithBlock:^(BOOL enabled) {
            [self updateUserLocation:enabled];
        }];
    }

    return _userLocation;
}

- (void)updateUserLocation
{
    [self updateUserLocation:self.userLocation.locationServicesEnabled];
}

- (void)updateUserLocation:(BOOL)locationEnabled
{
    if (locationEnabled)
    {
        [self.userLocation locateUserPositionWithBlock:^(CLLocationCoordinate2D userPosition) {
            GVCoordinateChecker *checker = [GVCoordinateChecker coordinateCheckerWithRegion:self.appDefaults.maximumCityRegion];
            if ([checker coordinateInRegion:userPosition])
            {
                MKCoordinateSpan localSpan = self.selectedRegion.span;

                // Only do this once at startup
                if (!self.userLocationCalledDate)
                {
                    self.userLocationCalledDate = [NSDate dateWithTimeIntervalSinceNow:self.updateTimerInterval];
                }

                if (NSOrderedDescending == [self.userLocationCalledDate compare:[NSDate date]])
                {
                    // This span represents a "neighbourhood" area, so only use it if the userPosition is within the city boundaries
                    localSpan = MKCoordinateSpanMake(0.02, 0.02);
                }

                MKCoordinateRegion region = MKCoordinateRegionMake(userPosition, localSpan);
                [self.mapView setRegion:region animated:YES];
            }
        }];
    }
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(GVFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self updateAllOverlays];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        GVFlipsideViewController *vc = (GVFlipsideViewController *)segue.destinationViewController;
        vc.delegate = self;
    }
}

#pragma mark - MapView delegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    self.selectedRegion = self.mapView.region;
//    NSLog(@"selectedRegion: CLLocationCoordinate2DMake(%g, %g), MKCoordinateSpanMake(%g, %g)", self.selectedRegion.center.latitude, self.selectedRegion.center.longitude, self.selectedRegion.span.latitudeDelta, self.selectedRegion.span.longitudeDelta);
}

- (NSArray *)polyLinesForBikePaths:(NSArray *)bikePaths withColor:(UIColor *)color
{
    NSMutableArray *visibleBikePaths = [NSMutableArray array];
    for (GVPisteCyclable *pisteCyclable in bikePaths)
    {
//        NSLog(@"%@", pisteCyclable);
        // All the coordinates of the pisteCyclable, in order
        NSSet *points = pisteCyclable.geom;
        NSArray *orderedPoints = [points sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]]];
        CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D) * orderedPoints.count);
        NSUInteger count = 0;
        for (NSUInteger i = 0; i < orderedPoints.count; i++)
        {
            GVPoint *pt = (GVPoint *)orderedPoints[i];

            coords[count] = CLLocationCoordinate2DMake(pt.latitude.doubleValue, pt.longitude.doubleValue);
            count++;
        }
        GVColorPolyline *polyLine = [GVColorPolyline polylineWithCoordinates:coords count:count];
        polyLine.color = color;
        [visibleBikePaths addObject:polyLine];
        free(coords);
    }

    return [NSArray arrayWithArray:visibleBikePaths];
}

- (void)updateMapType
{
    // Defaults to 0 for MKMapTypeStandard
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"mapType"];

    self.mapView.mapType = mapType;
}

- (void)updateAllOverlays
{
    [self updateMapType];
    [self.mapView removeOverlays:self.mapView.overlays];

    // Filter out the map points that can be shown on the map
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"GVPisteCyclable"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"codeID" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context.managedObjectContext sectionNameKeyPath:nil cacheName:nil];

    BOOL hideRouteVerte = [[NSUserDefaults standardUserDefaults] boolForKey:@"routeVertePathsHidden"];
    if (!hideRouteVerte)
    {
        // route_verte
        NSPredicate *p = [NSPredicate predicateWithFormat:@"route_verte == 1"];
        fetchRequest.predicate = p;

        NSError *error;
        [frc performFetch:&error];
        if (error)
        {
            NSLog(@"fetch error: %@", error);
            return;
        }

        NSArray *pistesCyclables = [self polyLinesForBikePaths:frc.fetchedObjects withColor:self.routeVerteColor];
        [self.mapView addOverlays:pistesCyclables];
    }

    BOOL hideMainPaths = [[NSUserDefaults standardUserDefaults] boolForKey:@"mainPathsHidden"];
    if (!hideMainPaths)
    {
        // Not route_verte
        NSPredicate *p = [NSPredicate predicateWithFormat:@"route_verte == 0"];
        fetchRequest.predicate = p;

        NSError *error;
        [frc performFetch:&error];
        if (error)
        {
            NSLog(@"fetch error: %@", error);
            return;
        }

        NSArray *pistesCyclables = [self polyLinesForBikePaths:frc.fetchedObjects withColor:self.standardColor];
        [self.mapView addOverlays:pistesCyclables];
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    if ([overlay isKindOfClass:[GVColorPolyline class]])
    {
        GVColorPolyline *polyLine = (GVColorPolyline *)overlay;
        renderer.strokeColor = polyLine.color;
    }
    renderer.lineWidth = 4.0;
    return renderer;
}

#pragma mark - Path Loader

- (GVPathLoader *)pathLoader
{
    if (!_pathLoader)
    {
        _pathLoader = [[GVPathLoader alloc] initWithContext:self.context];
    }

    return _pathLoader;
}

@end
