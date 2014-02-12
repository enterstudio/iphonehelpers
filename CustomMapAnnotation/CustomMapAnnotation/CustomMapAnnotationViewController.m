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

@interface CustomMapAnnotationViewController ()
@property (nonatomic, retain) DefaultAnnotation *customAnnotation;
@property (nonatomic, retain) DefaultAnnotation *defaultAnnotation;
@property (nonatomic, retain) CustomMapAnnotation *customMapAnnotation;
@end

@implementation CustomMapAnnotationViewController

@synthesize customAnnotation = _customAnnotation;
@synthesize defaultAnnotation = _defaultAnnotation;
@synthesize mapView = _mapView;
@synthesize selectedAnnotation=_selectedAnnotation;
@synthesize customMapAnnotation=_customMapAnnotation;

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if (view.annotation == self.customAnnotation) {
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
    if (self.customMapAnnotation && view.annotation == self.customAnnotation) {
        [self.mapView removeAnnotation: self.customMapAnnotation];
    }
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if (annotation == self.customMapAnnotation) {
        CustomMapAnnotationView *customMapAnnotationView = (CustomMapAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomMapAnnotation"];
        if (!customMapAnnotationView) {
            customMapAnnotationView = [[CustomMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomMapAnnotation"];
            customMapAnnotationView.contentHeight = 78.0f;
            UIImage *asynchronyLogo = [UIImage imageNamed:@"me.png"];
            UIImageView *asynchronyLogoView = [[UIImageView alloc] initWithImage:asynchronyLogo];
            asynchronyLogoView.frame = CGRectMake(5, 2, asynchronyLogoView.frame.size.width, asynchronyLogoView.frame.size.height);
            [customMapAnnotationView.contentView addSubview:asynchronyLogoView];
        }
        customMapAnnotationView.mapView = self.mapView;
        return customMapAnnotationView;
    } else if (annotation == self.customAnnotation) {
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
    
    self.defaultAnnotation = [[DefaultAnnotation alloc] initWithCoordinates:defaultCoordinates.latitude longitude:defaultCoordinates.longitude];
    self.defaultAnnotation.title = @"City Center";
    [self.mapView addAnnotation:self.defaultAnnotation];

    self.customAnnotation = [[DefaultAnnotation alloc] initWithCoordinates:customCoordinates.latitude longitude:customCoordinates.longitude];
    [self.mapView addAnnotation:self.customAnnotation];
    
	MKCoordinateRegion coordinateOptions = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(customCoordinates, 800, 800)];

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
