//
//  CustomMapAnnotation.m
//  CustomMapAnnotation
//
//  Created by mike.tihonchik on 2/11/14.
//  Copyright (c) 2014 mike.tihonchik. All rights reserved.
//

#import "CustomMapAnnotation.h"

@implementation CustomMapAnnotation

@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize title = _title;

- (id)initWithLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude andLocationId:(NSString *)locationId; {
	if (self = [super init]) {
		self.latitude = latitude;
		self.longitude = longitude;
        self.title = locationId;
	}
	return self;
}

- (CLLocationCoordinate2D)coordinate {
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = self.latitude;
	coordinate.longitude = self.longitude;
	return coordinate;
}

@end
