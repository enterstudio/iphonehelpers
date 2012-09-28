//
//  SmplPhoneFormatter.h
//  SmplPhoneFormatter
//
//  Created by iPhone Dev2 on 9/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmplPhoneFormatter : NSObject {
    NSArray *usPhoneFormats;
}
@property (nonatomic, strong) NSArray *usPhoneFormats;

- (id)init;
- (NSString *)stripToNumbers:(NSString *)phoneNumber;
- (BOOL)containsOnlyDigits:(NSString *)phoneNumber;
- (NSString *)formatPhoneNumber:(NSString *)phoneNumber withLocale:(NSString *)locale;
- (NSString *)formatPhoneNumber:(NSString *)phoneNumber;
- (NSString *)formatToStyle:(NSString *)phoneNumber withStyle:(NSString *)styleFormat;
- (NSString *)removeLeadingZeros:(NSString *)phoneNumber;

@end
