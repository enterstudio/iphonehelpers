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
@property (nonatomic, retain) CustomLocation *location;

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *streetLabel;
@property (nonatomic, retain) UILabel *cityLabel;
@property (nonatomic, retain) UILabel *phoneLabel;
@property (nonatomic, retain) UIView *customDisplayView;

@end

@implementation CustomMapAnnotationViewController

@synthesize customAnnotation = _customAnnotation;
@synthesize customAnnotation2 = _customAnnotation2;
@synthesize defaultAnnotation = _defaultAnnotation;
@synthesize mapView = _mapView;
@synthesize selectedAnnotationView = _selectedAnnotationView;
@synthesize customMapAnnotation = _customMapAnnotation;
@synthesize dataArray;
@synthesize location = _location;

@synthesize nameLabel = _nameLabel;
@synthesize streetLabel = _streetLabel;
@synthesize cityLabel = _cityLabel;
@synthesize phoneLabel = _phoneLabel;
@synthesize customDisplayView = _customDisplayView;

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
        _location = (CustomLocation *)[dataArray objectAtIndex:i];
        DefaultAnnotation *loc = [[DefaultAnnotation alloc] initWithLatitude:[_location.latitude doubleValue] andLongitude:[_location.longitude doubleValue] andLocationId:_location.locationId];
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
            _location = [[CustomLocation alloc] init];
            
            for (NSString *key in location) {
                if ([_location respondsToSelector:NSSelectorFromString(key)]) {
                    [_location setValue:[location valueForKey:key] forKey:key];
                }
            }
            [dataArray addObject:_location];
        }
    }
}

- (void)createCustomOverlay {
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 150, 20)];
    _nameLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:17];
    
    _streetLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 20, 150, 20)];
    _streetLabel.font = [UIFont fontWithName:@"Verdana" size:13];
    
    _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 40, 150, 20)];
    _cityLabel.font = [UIFont fontWithName:@"Verdana" size:13];
    
    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 60, 150, 20)];
    _phoneLabel.font = [UIFont fontWithName:@"Verdana" size:13];
    _phoneLabel.textColor = [UIColor blueColor];
    
    _customDisplayView = [[UIView alloc] init];
    [_customDisplayView addSubview:_nameLabel];
    [_customDisplayView addSubview:_streetLabel];
    [_customDisplayView addSubview:_cityLabel];
    [_customDisplayView addSubview:_phoneLabel];
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
    
    _location = (CustomLocation *)[dataArray objectAtIndex:([view.annotation.title intValue] - 1)];
    
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
            
/*            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 74, 74)];
            imageView.image = [UIImage imageNamed:@"me.png"];

            [customDisplayView addSubview:imageView];
 */
		}
        
        [_customDisplayView removeFromSuperview];
        [self createCustomOverlay];
        _nameLabel.text = _location.name;
        _streetLabel.text = _location.address;
        _cityLabel.text = _location.city;
        _phoneLabel.text = _location.phoneNumber;
        
        [customMapAnnotationView.contentView addSubview:_customDisplayView];
      
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
