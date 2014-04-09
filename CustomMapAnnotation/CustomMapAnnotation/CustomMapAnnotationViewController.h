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
    MKAnnotationView *_selectedAnnotationView;
	DefaultAnnotation *_customAnnotation;
    DefaultAnnotation *_customAnnotation2;
    DefaultAnnotation *_defaultAnnotation;
    CustomMapAnnotation *_customMapAnnotation;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) MKAnnotationView *selectedAnnotationView;
@property (nonatomic, retain) NSMutableArray *dataArray;

@end
