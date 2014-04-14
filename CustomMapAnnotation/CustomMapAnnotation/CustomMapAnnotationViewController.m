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
#import "CustomLocation.h"

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
@synthesize selectedAnnotationView = _selectedAnnotationView;
@synthesize customMapAnnotation = _customMapAnnotation;
@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
	self.mapView.delegate = self;
    
	CLLocationCoordinate2D mapCoordinates = {57.392, 21.563295};
    MKCoordinateRegion coordinateOptions = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(mapCoordinates, 800, 800)];
    coordinateOptions.span.longitudeDelta  = 0.01;
    coordinateOptions.span.latitudeDelta  = 0.01;
	[self.mapView setRegion:coordinateOptions animated:YES];
    
    [self readJsonFile];
    
    int len = [dataArray count];
    for(int i = 0; i < len; i++) {
        CustomLocation *location = (CustomLocation *)[dataArray objectAtIndex:i];
        DefaultAnnotation *loc = [[DefaultAnnotation alloc] initWithLatitude:[location.latitude doubleValue] andLongitude:[location.longitude doubleValue] andLocationId:location.locationId];
        [self.mapView addAnnotation:loc];
    }
}

- (void)viewDidUnload {
	self.mapView = nil;
	self.customAnnotation = nil;
	self.defaultAnnotation = nil;
}

- (void)viewWillAppear:(BOOL)animated {}

- (void)readJsonFile {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"mapdata" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *jsonError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    
    if (jsonError != nil) {
        NSLog(@"ERROR! No data read! %@", [jsonError localizedDescription]);
    } else {
        dataArray = [[NSMutableArray alloc] init];
        
        NSArray *results = [parsedObject valueForKey:@"locations"];
        NSLog(@"Count %d", results.count);
        
        for (NSDictionary *location in results) {
            CustomLocation *customLocation = [[CustomLocation alloc] init];
            
            for (NSString *key in location) {
                if ([customLocation respondsToSelector:NSSelectorFromString(key)]) {
                    [customLocation setValue:[location valueForKey:key] forKey:key];
                }
            }
            [dataArray addObject:customLocation];
        }
    }
}


#pragma mark - Map methods

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if (self.customMapAnnotation == nil) {
        self.customMapAnnotation = [[CustomMapAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude andLongitude:view.annotation.coordinate.longitude andLocationId:view.annotation.title];
    } else {
        self.customMapAnnotation.latitude = view.annotation.coordinate.latitude;
        self.customMapAnnotation.longitude = view.annotation.coordinate.longitude;
        self.customMapAnnotation.title = view.annotation.title;
    }
    
    // TODO: add locations here!!!
    
    [self.mapView addAnnotation:self.customMapAnnotation];
    self.selectedAnnotationView = view;
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
	if (self.customMapAnnotation ) {
		[self.mapView removeAnnotation: self.customMapAnnotation];
	}
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if (annotation == self.customMapAnnotation) {
		CustomMapAnnotationView *customMapAnnotationView = (CustomMapAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutAnnotation"];
		if (!customMapAnnotationView) {
			customMapAnnotationView = [[CustomMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutAnnotation"];
            
            UIView *customDisplayView = [[UIView alloc] init];
            
            CustomLocation *location = (CustomLocation *)[dataArray objectAtIndex:([annotation.title intValue] - 1)];
            
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 150, 20)];
            nameLabel.text = location.name;
            nameLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:17];
            
            UILabel *streetLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 20, 150, 20)];
            streetLabel.text = location.address;
            streetLabel.font = [UIFont fontWithName:@"Verdana" size:13];

            UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 40, 150, 20)];
            cityLabel.text = location.city;
            cityLabel.font = [UIFont fontWithName:@"Verdana" size:13];

            UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 60, 150, 20)];
            phoneLabel.text = location.phoneNumber;
            phoneLabel.font = [UIFont fontWithName:@"Verdana" size:13];
            phoneLabel.textColor = [UIColor blueColor];
            
/*            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 74, 74)];
            imageView.image = [UIImage imageNamed:@"me.png"];

            [customDisplayView addSubview:imageView];
 */
            [customDisplayView addSubview:nameLabel];
            [customDisplayView addSubview:streetLabel];
            [customDisplayView addSubview:cityLabel];
            [customDisplayView addSubview:phoneLabel];
            [customMapAnnotationView.contentView addSubview:customDisplayView];
            
		}
		customMapAnnotationView.parentAnnotationView = self.selectedAnnotationView;
		customMapAnnotationView.mapView = self.mapView;
		return customMapAnnotationView;
	} else {
		MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomAnnotation"];
		annotationView.canShowCallout = NO;
		annotationView.pinColor = MKPinAnnotationColorRed;
 		return annotationView;
    }
	return nil;
}

@end
