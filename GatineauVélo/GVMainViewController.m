//
//  GVMainViewController.m
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVMainViewController.h"

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

@end
