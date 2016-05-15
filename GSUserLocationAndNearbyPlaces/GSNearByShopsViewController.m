//
//  NearByShopsViewController.m
//  GSUserLocationAndNearbyPlaces
//
//  Created by Gowri Sammandhamoorthy on 5/15/16.
//  Copyright © 2016 Gowri Sammandhamoorthy. All rights reserved.
//

#import "GSNearByShopsViewController.h"
#import "GSCustomAnnotation.h"


@interface GSNearByShopsViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>

@end

@implementation GSNearByShopsViewController{
    NSArray* dataArray;
}

@synthesize shopMapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    shopMapView.delegate = self;
    self.title = NSLocalizedString(@"NearBy Stores", nil);
    
    dataArray= [NSArray new];
    dataArray = @[ @{@"Lat": @"37.19" ,
                     @"Lon": @"-121.03",
                     @"Store": @"Target" ,
                     @"PhoneNumber": @"+1(888)984-8780" ,
                     @"Address": @"Stevens Creek Blvd, Cupertino, CA 95014"},
                   @{@"Lat": @"36.33" ,
                     @"Lon": @"-122.03",
                     @"Store": @"Ross" ,
                     @"PhoneNumber": @"+1(408)873-8763" ,
                     @"Address": @"Homestead Rd, Cupertino, CA 95014"},
                   @{@"Lat": @"38.33" ,
                     @"Lon": @"-121.43",
                     @"Store": @"VitaminShop" ,
                     @"PhoneNumber": @"+1(408)873-8461" ,
                     @"Address": @"Lochinvar Ave, Sunnyvale, CA 94087"}
                   ];
    
    //MapView
   CLLocationManager* locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
   
//    shopMapView.showsUserLocation = YES;
    
    
    [self createAnnotations];

    
}

-(NSMutableArray*)createAnnotations{
    NSMutableArray* annotations = [NSMutableArray new];
    for (int i = 0; i < [dataArray count] ; i++) {
        NSString* title = [NSString stringWithFormat:@"%@", dataArray[i][@"Address"]];
  
    
    CLGeocoder* geoCoder = [[CLGeocoder alloc]init];
                            [geoCoder geocodeAddressString:title completionHandler:^(NSArray* placemarks, NSError* error){
                                if (!error) {
                                    CLPlacemark* placemark = [placemarks objectAtIndex:0];
                                    
                                    MKCoordinateRegion region = shopMapView.region;
                                    region.center = [(CLCircularRegion*) placemark.region center];
                                    region.span.latitudeDelta = 0.1;
                                    region.span.longitudeDelta = 0.1;
                                    [shopMapView setRegion:region];
                                    
                                    CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
                                    
                                    GSCustomAnnotation* annotation = [[GSCustomAnnotation alloc]initWithTitle:dataArray[i][@"Store"] Location:coordinates];
                                    annotation.phoneNumber = dataArray[i][@"PhoneNumber"];
                                    annotation.address = dataArray[i][@"Address"];
                                    [shopMapView addAnnotation:annotation];
                                }
                                else{
                                    NSLog(@"There was a forward geocoding error\n%@",[error localizedDescription]);
                                }
                            }];
    }
    
    return annotations;
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[GSCustomAnnotation class]]) {
        GSCustomAnnotation* myLocation = (GSCustomAnnotation*) annotation;
        MKAnnotationView* annotationView = [shopMapView dequeueReusableAnnotationViewWithIdentifier:@"MapCustomAnnotation"];
        if (annotationView == nil) {
            annotationView = myLocation.customAnnotation;
        }
        else{
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    
    return nil;
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views{
    [mapView selectAnnotation:[mapView.annotations objectAtIndex:0] animated:YES];
}


- (IBAction)exitButtonPressed:(id)sender {
      exit(0);
}
@end
