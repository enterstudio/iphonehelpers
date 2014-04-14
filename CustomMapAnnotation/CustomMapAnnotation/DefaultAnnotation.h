//
//  DefaultAnnotation.h
//  CustomMapAnnotation
//
//  Created by mike.tihonchik on 2/11/14.
//  Copyright (c) 2014 mike.tihonchik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DefaultAnnotation : NSObject <MKAnnotation> {
	CLLocationDegrees _latitude;
	CLLocationDegrees _longitude;
    int _locationId;
	NSString *_title;
}

@property (nonatomic, copy) NSString *title;

- (id)initWithLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude andLocationId:(NSString *)locationId;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
