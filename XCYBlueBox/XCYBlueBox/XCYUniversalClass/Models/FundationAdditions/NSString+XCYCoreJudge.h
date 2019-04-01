//
//  NSString+XCYStrJudge.h
//  XCY
//
//  Created by XCY on 15/7/22.
//  Copyright (c) 2015年 XCY. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (XCYCoreJudge)
+ (BOOL)strNilOrEmpty_xcy:(NSString *)str;

- (BOOL)isStringEmpty_xcy;

- (BOOL)isWhitespaceAndNewlines_xcy;
@end
