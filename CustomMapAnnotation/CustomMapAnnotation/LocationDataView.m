//
//  LocationDataView.m
//  CustomMapAnnotation
//
//  Created by mike.tihonchik on 2/12/14.
//  Copyright (c) 2014 mike.tihonchik. All rights reserved.
//

#import "LocationDataView.h"

@implementation LocationDataView

+ (id)loadCustomView {
    LocationDataView *customView = [[[NSBundle mainBundle] loadNibNamed:@"LocationDataView" owner:nil options:nil] lastObject];
    return customView;
}

@end
