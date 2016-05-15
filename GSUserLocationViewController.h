//
//  UserLocationViewController.h
//  GSUserLocationAndNearbyPlaces
//
//  Created by Gowri Sammandhamoorthy on 5/11/16.
//  Copyright © 2016 Gowri Sammandhamoorthy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GSUserLocationViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *userLocationMapView;
- (IBAction)exitButtonPressed:(id)sender;

@end
