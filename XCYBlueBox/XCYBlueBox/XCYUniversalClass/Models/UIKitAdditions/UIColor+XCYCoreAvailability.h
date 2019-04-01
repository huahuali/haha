//
//  UIColor+XCYAvailability.h
//  XCY
//
//  Created by XCY on 15/9/15.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XCYCoreAvailability)

/**
 *  获取颜色
 *
 *  @param hexColor 十六进制的颜色值字符串，hexColor不存在或空字符串时，返回[UIColor blackColor]
 *
 *  @return UIColor 对象
 */
+ (UIColor*)hexColor_xcy:(NSString*)hexColor;

@end
