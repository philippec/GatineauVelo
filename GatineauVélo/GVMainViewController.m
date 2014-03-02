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

@interface GVMainViewController ()

@property (assign) MKCoordinateRegion selectedRegion;

@end

@implementation GVMainViewController

- (void)awakeFromNib
{
    self.selectedRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(45.4728, -75.7949), MKCoordinateSpanMake(0.25, 0.22));
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.region = self.selectedRegion;
    [self updateAllOverlays];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(GVFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

#pragma mark - MapView delegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    self.selectedRegion = self.mapView.region;
    NSLog(@"selectedRegion: CLLocationCoordinate2DMake(%g, %g), MKCoordinateSpanMake(%g, %g)", self.selectedRegion.center.latitude, self.selectedRegion.center.longitude, self.selectedRegion.span.latitudeDelta, self.selectedRegion.span.longitudeDelta);
}

- (void)updateAllOverlays
{
    // Filter out the map points that can be shown on the map
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"GVPisteCyclable"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"codeID" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];

    NSError *error;
    [frc performFetch:&error];
    if (error)
    {
        NSLog(@"fetch error: %@", error);
        return;
    }

    NSMutableArray *pistesCyclablesVisibles = [NSMutableArray array];
    for (GVPisteCyclable *pisteCyclable in frc.fetchedObjects)
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
        MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coords count:count];
        [pistesCyclablesVisibles addObject:polyLine];
        free(coords);
    }

    [self.mapView removeOverlays:self.mapView.overlays];

    [self.mapView addOverlays:pistesCyclablesVisibles];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    renderer.strokeColor = [UIColor orangeColor];
    renderer.lineWidth = 4.0;
    return renderer;
}


@end
