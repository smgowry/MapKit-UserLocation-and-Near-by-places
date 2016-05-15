//
//  NearByShopsViewController.h
//  GSUserLocationAndNearbyPlaces
//
//  Created by Gowri Sammandhamoorthy on 5/15/16.
//  Copyright © 2016 Gowri Sammandhamoorthy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface GSNearByShopsViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *shopMapView;
- (IBAction)exitButtonPressed:(id)sender;

@end
