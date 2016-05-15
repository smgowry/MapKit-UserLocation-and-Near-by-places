//
//  GSCustomAnnotation.h
//  GSUserLocationAndNearbyPlaces
//
//  Created by Gowri Sammandhamoorthy on 5/11/16.
//  Copyright © 2016 Gowri Sammandhamoorthy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GSCustomAnnotation : NSObject<MKAnnotation>{
    
}

@property (copy, nonatomic) NSString* title;
@property(readonly, nonatomic) CLLocationCoordinate2D coordinate;

@property(strong,nonatomic) NSString* address;
@property(strong,nonatomic) NSString* phoneNumber;

-(id)initWithTitle:(NSString*)newTitle Location:(CLLocationCoordinate2D)location;
-(MKAnnotationView* )customAnnotation;

@end
