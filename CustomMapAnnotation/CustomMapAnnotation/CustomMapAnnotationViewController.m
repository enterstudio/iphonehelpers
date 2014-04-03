//
//  CustomMapAnnotationViewController.m
//  CustomMapAnnotation
//
//  Created by mike.tihonchik on 2/11/14.
//  Copyright (c) 2014 mike.tihonchik. All rights reserved.
//

#import "CustomMapAnnotationViewController.h"
#import "CustomMapAnnotation.h"
#import "CustomMapAnnotationView.h"
#import "DefaultAnnotation.h"
#import "LocationDataView.h"

@interface CustomMapAnnotationViewController ()
@property (nonatomic, retain) DefaultAnnotation *customAnnotation;
@property (nonatomic, retain) DefaultAnnotation *customAnnotation2;
@property (nonatomic, retain) DefaultAnnotation *defaultAnnotation;
@property (nonatomic, retain) CustomMapAnnotation *customMapAnnotation;
@end

@implementation CustomMapAnnotationViewController

@synthesize customAnnotation = _customAnnotation;
@synthesize customAnnotation2 = _customAnnotation2;
@synthesize defaultAnnotation = _defaultAnnotation;
@synthesize mapView = _mapView;
@synthesize selectedAnnotation=_selectedAnnotation;
@synthesize customMapAnnotation=_customMapAnnotation;

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if (view.annotation == self.customAnnotation || view.annotation == self.customAnnotation2) {
        if (self.customMapAnnotation == nil) {
            self.customMapAnnotation = [[CustomMapAnnotation alloc] initWithCoordinates:view.annotation.coordinate.latitude longitude:view.annotation.coordinate.longitude];
        } else {
            self.customMapAnnotation.latitude = view.annotation.coordinate.latitude;
            self.customMapAnnotation.longitude = view.annotation.coordinate.longitude;
        }
        [self.mapView addAnnotation:self.customMapAnnotation];
        self.selectedAnnotation = view;
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if (self.customMapAnnotation &&
        (view.annotation == self.customAnnotation || view.annotation == self.customAnnotation2)) {
        [self.mapView removeAnnotation: self.customMapAnnotation];
    }
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if (annotation == self.customMapAnnotation) {
        CustomMapAnnotationView *customMapAnnotationView = (CustomMapAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomMapAnnotation"];
        if (!customMapAnnotationView) {
            customMapAnnotationView = [[CustomMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomMapAnnotation"];
            customMapAnnotationView.contentHeight = 78.0f;
            UIView *customDisplayView = [[UIView alloc] init];
/*            UIImageView *displayImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me.png"]];
            displayImage.frame = CGRectMake(2.0f, 2.0f, 74.0f, 74.0f);
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 150, 20)];
            nameLabel.text = @"Lota";
            nameLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:17];
            UILabel *streetLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 20, 150, 20)];
            streetLabel.text = @"Raiņa iela 5";
            streetLabel.font = [UIFont fontWithName:@"Verdana" size:13];
            UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 40, 150, 20)];
            cityLabel.text = @"Ventspils, LV-3601, Латвия";
            cityLabel.font = [UIFont fontWithName:@"Verdana" size:13];
            UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 60, 150, 20)];
            phoneLabel.text = @"63620275";
            phoneLabel.font = [UIFont fontWithName:@"Verdana" size:13];
            phoneLabel.textColor = [UIColor blueColor];
            [customDisplayView addSubview:displayImage];
            [customDisplayView addSubview:nameLabel];
            [customDisplayView addSubview:streetLabel];
            [customDisplayView addSubview:cityLabel];
            [customDisplayView addSubview:phoneLabel]; */
            [customMapAnnotationView.contentView addSubview:customDisplayView];
        }
        customMapAnnotationView.mapView = self.mapView;
        return customMapAnnotationView;
    } else if (annotation == self.customAnnotation || annotation == self.customAnnotation2) {
        MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomAnnotation"];
        annotationView.canShowCallout = NO;
        annotationView.pinColor = MKPinAnnotationColorGreen;
        return annotationView;
    } else {
        MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"NormalAnnotation"];
		annotationView.canShowCallout = YES;
		annotationView.pinColor = MKPinAnnotationColorRed;
		return annotationView;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.mapView.delegate = self;
    
    CLLocationCoordinate2D defaultCoordinates = {57.391635,21.563295};
    CLLocationCoordinate2D customCoordinates = {57.393716, 21.564763};
    CLLocationCoordinate2D customCoordinates2 = {57.392271, 21.564163};
    
    self.defaultAnnotation = [[DefaultAnnotation alloc] initWithCoordinates:defaultCoordinates.latitude longitude:defaultCoordinates.longitude];
    self.defaultAnnotation.title = @"City Center";
    [self.mapView addAnnotation:self.defaultAnnotation];

    self.customAnnotation = [[DefaultAnnotation alloc] initWithCoordinates:customCoordinates.latitude longitude:customCoordinates.longitude];
    [self.mapView addAnnotation:self.customAnnotation];

    self.customAnnotation2 = [[DefaultAnnotation alloc] initWithCoordinates:customCoordinates2.latitude longitude:customCoordinates2.longitude];
    [self.mapView addAnnotation:self.customAnnotation2];
    
	MKCoordinateRegion coordinateOptions = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(customCoordinates, 800, 800)];

    coordinateOptions.span.longitudeDelta  = 0.01;
    coordinateOptions.span.latitudeDelta  = 0.01;
    
	[self.mapView setRegion:coordinateOptions animated:YES];
}

- (void)viewDidUnload {
	self.mapView = nil;
    self.customAnnotation = nil;
    self.customAnnotation2 = nil;
	self.defaultAnnotation = nil;
}

@end
