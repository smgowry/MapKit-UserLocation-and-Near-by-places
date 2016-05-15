//
//  UserLocationViewController.m
//  GSUserLocationAndNearbyPlaces
//
//  Created by Gowri Sammandhamoorthy on 5/11/16.
//  Copyright © 2016 Gowri Sammandhamoorthy. All rights reserved.
//

#import "GSUserLocationViewController.h"


@interface GSUserLocationViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>

@end

@implementation GSUserLocationViewController{
    CLLocationManager* locationManager;
}
@synthesize userLocationMapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
    userLocationMapView.delegate = self;
    userLocationMapView.showsUserLocation = YES;
    
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error");
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
//    NSLog(@"NewLocation: %@", locations[0]);
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.2;
    mapRegion.span.longitudeDelta = 0.2;
    
    [mapView setRegion:mapRegion animated: YES];
}

- (IBAction)exitButtonPressed:(id)sender {
    exit(0);
}
@end
