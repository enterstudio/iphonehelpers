//
//  CustomLocation.h
//  CustomMapAnnotation
//
//  Created by mike.tihonchik on 4/9/14.
//  Copyright (c) 2014 mike.tihonchik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomLocation : NSObject

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* address;
@property (nonatomic, retain) NSString* city;
@property (nonatomic, retain) NSString* state;
@property (nonatomic, retain) NSString* zipcode;
@property (nonatomic, retain) NSString* phoneNumber;
@property (nonatomic, retain) NSString* latitude;
@property (nonatomic, retain) NSString* longitude;

- (id)initWithJSON:(NSDictionary*)json;

@end
