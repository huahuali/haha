//
//  NSString+XCYStrJudge.m
//
//  Created by XCY on 15/7/22.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "NSString+XCYCoreJudge.h"


@implementation NSString (XCYCoreJudge)

+ (BOOL)strNilOrEmpty_xcy:(NSString *)str
{
    if (!str||![str isKindOfClass:[NSString class]])
    {
        return YES;
    }
    return [str isStringEmpty_xcy];
}

- (BOOL)isStringEmpty_xcy
{
    return (0 == self.length) ? YES : NO;

}

- (BOOL)isWhitespaceAndNewlines_xcy
{
    NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![whitespace characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}

@end
