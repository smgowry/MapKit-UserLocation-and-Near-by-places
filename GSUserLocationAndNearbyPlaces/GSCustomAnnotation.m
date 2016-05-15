//
//  GSCustomAnnotation.m
//  GSUserLocationAndNearbyPlaces
//
//  Created by Gowri Sammandhamoorthy on 5/11/16.
//  Copyright © 2016 Gowri Sammandhamoorthy. All rights reserved.
//

#import "GSCustomAnnotation.h"

@implementation GSCustomAnnotation

@synthesize title, coordinate, phoneNumber, address;

-(id)initWithTitle:(NSString*)newTitle Location:(CLLocationCoordinate2D)location{
    self = [super init];
    if (self) {
        title = newTitle;
        coordinate = location;
    }
    return self;
}


-(MKAnnotationView *)customAnnotation{
    MKAnnotationView* annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"MapCustomAnnotation"];
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.image = [UIImage imageNamed:@"map_icon.png"];
    annotationView.centerOffset = CGPointMake(0, -annotationView.image.size.height / 2);
    annotationView.detailCalloutAccessoryView = [self detailViewForAnnotation];
    return annotationView;
    
}


- (UIView *)detailViewForAnnotation {
    
    
    UIView *view = [[UIView alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = false;
    
    
    UIView *subviewTwo=[[UIView alloc]init];
    subviewTwo.translatesAutoresizingMaskIntoConstraints = false;
    [view addSubview:subviewTwo];
    //subviewTwo.backgroundColor = [UIColor redColor];
    
    UIButton* directionButton = [[UIButton alloc]init];
    directionButton.enabled = FALSE;
    directionButton.titleLabel.textColor = [UIColor blueColor];
    directionButton.enabled = YES;
    
    [directionButton setTitle:@"Direction" forState:UIControlStateNormal];
    directionButton.titleLabel.textAlignment=NSTextAlignmentLeft;
    // directionButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
    
    
    [directionButton addTarget:self action:@selector(showingAddressOnMap) forControlEvents:UIControlEventTouchUpInside];
    [directionButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    directionButton.titleLabel.font = [UIFont systemFontOfSize:12];
    directionButton.translatesAutoresizingMaskIntoConstraints = false;
    [view addSubview:directionButton];
    
    
    UIButton *phoneButton = [[UIButton alloc] init];
    
    phoneButton.titleLabel.textAlignment=NSTextAlignmentLeft;
    phoneButton.enabled = FALSE;
    phoneButton.titleLabel.textColor = [UIColor blueColor];
    phoneButton.enabled = YES;
    
    [phoneButton setTitle:phoneNumber forState:UIControlStateNormal];
    
    [phoneButton addTarget:self action:@selector(phonecallButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [phoneButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    phoneButton.titleLabel.font = [UIFont systemFontOfSize:12];
    phoneButton.translatesAutoresizingMaskIntoConstraints = false;
    [view addSubview:phoneButton];
    
    
    UILabel *addressText = [[UILabel alloc] init];
    addressText.text = address;
    addressText.textAlignment=NSTextAlignmentLeft;
    addressText.textColor = [UIColor darkGrayColor];
    addressText.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    addressText.translatesAutoresizingMaskIntoConstraints = false;
    addressText.numberOfLines = 0;
    [view addSubview:addressText];
    
    
    NSDictionary *subviewsTwo = NSDictionaryOfVariableBindings(directionButton,phoneButton);
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:directionButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[directionButton]-20-[phoneButton]" options:NSLayoutFormatAlignAllBottom metrics:nil views:subviewsTwo]];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(addressText,subviewTwo);
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[addressText]|" options:0 metrics:nil views:views]];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subviewTwo]|" options:0 metrics:nil views:views]];

    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=-10)-[addressText]-25-[subviewTwo]|" options:0 metrics:nil views:views]];
    
    
    return view;
}


-(void)phonecallButtonClicked:(id)sender{
    
    UIButton *btn=(id)sender;
    NSString *phoneNum = btn.currentTitle;
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phoneNum]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
    
}


-(void)showingAddressOnMap{
    
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]){
        
        
        NSString* addressTitle = [NSString stringWithFormat:@"%@",address];
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:addressTitle
                     completionHandler:^(NSArray *placemarks, NSError *error) {
                         if(!error){
                             
                             CLPlacemark *geocodedPlacemark = [placemarks objectAtIndex:0];
                             
                             MKPlacemark *placemark = [[MKPlacemark alloc]
                                                       initWithCoordinate:geocodedPlacemark.location.coordinate
                                                       addressDictionary:geocodedPlacemark.addressDictionary];
                             
                             // Create a map item for the geocoded address to pass to Maps app
                             MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
                             [mapItem setName:geocodedPlacemark.name];
                             
                             [MKMapItem openMapsWithItems:@[mapItem] launchOptions:nil];
                         }
                     }];
        
    }
}


- (void)tapCount:(UITapGestureRecognizer*)sender {
    NSLog(@"mapview:");
}


@end
