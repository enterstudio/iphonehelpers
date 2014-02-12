//
//  DefaultAnnotation.h
//  CustomMapAnnotation
//
//  Created by mike.tihonchik on 2/11/14.
//  Copyright (c) 2014 mike.tihonchik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DefaultAnnotation : NSObject<MKAnnotation> {
	CLLocationDegrees _latitude;
	CLLocationDegrees _longitude;
    NSString *_title;
}

@property (nonatomic, retain) NSString *title;

- (id)initWithCoordinates:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;

@end
