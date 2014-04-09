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
@synthesize selectedAnnotationView =_selectedAnnotationView;
@synthesize customMapAnnotation =_customMapAnnotation;

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
	if (view.annotation == self.customAnnotation || view.annotation == self.customAnnotation2) {
		if (self.customMapAnnotation == nil) {
			self.customMapAnnotation = [[CustomMapAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude andLongitude:view.annotation.coordinate.longitude];
        } else {
			self.customMapAnnotation.latitude = view.annotation.coordinate.latitude;
			self.customMapAnnotation.longitude = view.annotation.coordinate.longitude;
		}
		[self.mapView addAnnotation:self.customMapAnnotation];
		self.selectedAnnotationView = view;
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
		CustomMapAnnotationView *customMapAnnotationView = (CustomMapAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutAnnotation"];
		if (!customMapAnnotationView) {
			customMapAnnotationView = [[CustomMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutAnnotation"];
            
            UIView *customDisplayView = [[UIView alloc] init];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 74, 74)];
            imageView.image = [UIImage imageNamed:@"me.png"];
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
            [customDisplayView addSubview:imageView];
            [customDisplayView addSubview:nameLabel];
            [customDisplayView addSubview:streetLabel];
            [customDisplayView addSubview:cityLabel];
            [customDisplayView addSubview:phoneLabel];

            [customMapAnnotationView.contentView addSubview:customDisplayView];
		}
		customMapAnnotationView.parentAnnotationView = self.selectedAnnotationView;
		customMapAnnotationView.mapView = self.mapView;
		return customMapAnnotationView;
	} else if (annotation == self.customAnnotation) {
		MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomAnnotation"];
		annotationView.canShowCallout = NO;
		annotationView.pinColor = MKPinAnnotationColorGreen;
		return annotationView;
	} else if (annotation == self.defaultAnnotation) {
		MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"NormalAnnotation"];
		annotationView.canShowCallout = YES;
		annotationView.pinColor = MKPinAnnotationColorPurple;
		return annotationView;
	}
	
	return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.mapView.delegate = self;
	
	self.customAnnotation = [[DefaultAnnotation alloc] initWithLatitude:57.393716 andLongitude:21.564763];
	[self.mapView addAnnotation:self.customAnnotation];

    self.customAnnotation2 = [[DefaultAnnotation alloc] initWithLatitude:57.392271 andLongitude:21.564163];
	[self.mapView addAnnotation:self.customAnnotation2];

	self.defaultAnnotation = [[DefaultAnnotation alloc] initWithLatitude:57.391635 andLongitude:21.563295];
	self.defaultAnnotation.title = @"Default Marker";
	[self.mapView addAnnotation:self.defaultAnnotation];
	
	CLLocationCoordinate2D mapCoordinates = {57.392, 21.563295};
    MKCoordinateRegion coordinateOptions = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(mapCoordinates, 800, 800)];
    coordinateOptions.span.longitudeDelta  = 0.01;
    coordinateOptions.span.latitudeDelta  = 0.01;
	[self.mapView setRegion:coordinateOptions animated:YES];
}

- (void)viewDidUnload {
	self.mapView = nil;
	self.customAnnotation = nil;
	self.defaultAnnotation = nil;
}

@end

/*
 CLLocationCoordinate2D defaultCoordinates = {57.391635,21.563295};
 CLLocationCoordinate2D customCoordinates = {57.393716, 21.564763};
 CLLocationCoordinate2D customCoordinates2 = {57.392271, 21.564163};
*/