//
//  UIColor+XCY
//  XCY
//
//  Created by XCY on 15/9/15.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "UIColor+XCYCoreAvailability.h"

@implementation UIColor (XCYCoreAvailability)

+ (UIColor*)hexColor_xcy:(NSString*)hexColor
{
    //hexColor 长度必须大于等于6位
    if (!hexColor || hexColor.length < 6) {
        
        return [UIColor blackColor];
    }
    
    unsigned int red, green, blue, alpha;
    alpha = 100;
    NSRange range;
    range.length = 2;
    @try {
        if ([hexColor hasPrefix:@"#"]) {
            hexColor = [hexColor stringByReplacingOccurrencesOfString:@"#" withString:@""];
        }
        range.location = 0;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
        range.location = 2;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
        range.location = 4;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
        
        if ([hexColor length] > 6) {
            range.location = 6;
            [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&alpha];
        }
    }
    @catch (NSException * e) {
    
        
        return [UIColor blackColor];
    }
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:(float)(alpha/100.0f)];
}

@end
