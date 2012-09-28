//
//  SmplPhoneFormatter.m
//  SmplPhoneFormatter
//
//  Created by iPhone Dev2 on 9/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SmplPhoneFormatter.h"

@implementation SmplPhoneFormatter
@synthesize usPhoneFormats;

- (id)init {
    usPhoneFormats = [NSArray arrayWithObjects:
                      @"(###) ###-####",
                      @"1 (###) ###-####",
                      @"###-####",
                      @"+1 (###) ###-####", nil];
    return self;
}

- (NSString *)formatPhoneNumber:(NSString *)phoneNumber {
    return [self formatPhoneNumber:phoneNumber withLocale:nil];
}

- (NSString *)formatPhoneNumber:(NSString *)phoneNumber withLocale:(NSString *)locale {
    
    if (![self containsOnlyDigits:phoneNumber]) {
        phoneNumber = [self stripToNumbers:phoneNumber];
    }
    phoneNumber = [self removeLeadingZeros:phoneNumber];
    
    if ([phoneNumber length] == 10) {
        phoneNumber = [self formatToStyle:phoneNumber withStyle:[usPhoneFormats objectAtIndex:0]];
    } else if ([phoneNumber length] == 11) {
        phoneNumber = [self formatToStyle:phoneNumber withStyle:[usPhoneFormats objectAtIndex:1]];
    } else if ([phoneNumber length] == 7) {
        phoneNumber = [self formatToStyle:phoneNumber withStyle:[usPhoneFormats objectAtIndex:2]];
    }
    return phoneNumber;
}

- (BOOL)containsOnlyDigits:(NSString *)phoneNumber {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES '[0-9]+'"];
    if ([predicate evaluateWithObject:phoneNumber]) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)stripToNumbers:(NSString *)phoneNumber {
    NSString *returnString = @"";
    if (phoneNumber == nil) {
        returnString = @"";
    } else if ([phoneNumber length] == 0) {
        returnString = @"";
    } else {
        phoneNumber = [phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([phoneNumber length] == 0) {
            returnString = @"";
        } else {
            NSCharacterSet *charactersToRemove = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
            returnString = [[phoneNumber componentsSeparatedByCharactersInSet:charactersToRemove ] componentsJoinedByString:@"" ];
        }
    }
    return returnString;
}

- (NSString *)removeLeadingZeros:(NSString *)phoneNumber {
    if ([phoneNumber length] == 10 && [[phoneNumber substringWithRange:NSMakeRange(0, 3)] isEqualToString:@"000"]) {
        phoneNumber = [phoneNumber substringFromIndex:3];
    } else if ([phoneNumber length] == 11 && [[phoneNumber substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"0000"]) {
        phoneNumber = [phoneNumber substringFromIndex:4];
    }
    return phoneNumber;
}

- (NSString *)formatToStyle:(NSString *)phoneNumber withStyle:(NSString *)styleFormat {
    NSMutableString *finalPhoneNumber = [[NSMutableString alloc] init];
    int i = 0;
    for (int counter = 0; counter < [styleFormat length]; counter++) {
        char styleChar = [styleFormat characterAtIndex:counter];
        char phoneChar = [phoneNumber characterAtIndex:i];
        switch(styleChar) {
            case '(':
            case ')':
            case '-':
            case ' ':
                [finalPhoneNumber appendFormat:@"%c", styleChar];
                break;    
            default:
                [finalPhoneNumber appendFormat:@"%c", phoneChar];
                i++;
                break;
        }
    }
    return finalPhoneNumber;
}

@end
