//
//  CustomMapAnnotationViewController.h
//  CustomMapAnnotation
//
//  Created by mike.tihonchik on 2/11/14.
//  Copyright (c) 2014 mike.tihonchik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CustomMapAnnotation.h"
#import "DefaultAnnotation.h"

@interface CustomMapAnnotationViewController : UIViewController <MKMapViewDelegate> {
	MKMapView *_mapView;
	DefaultAnnotation *_customAnnotation;
    DefaultAnnotation *_defaultAnnotation;
    CustomMapAnnotation *_customMapAnnotation;
    MKAnnotationView *_selectedAnnotation;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) MKAnnotationView *selectedAnnotation;

@end
