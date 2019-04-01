//
//  XCYCommonUIUtil.h
//  XCYBlueBox
//
//  Created by XCY on 16/12/31.
//  Copyright © 2016年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCYCommonUIUtil : NSObject

+ (CGFloat)getLineViewHeight;

+ (nonnull UIView *)addBottomLineToView:(nonnull UIView *)view
                              withColor:(nonnull UIColor *)aColor;

+ (nonnull UIView *)addTopLineToView:(nonnull UIView *)view
                           withColor:(nonnull UIColor *)aColor;


+ (nonnull UIView *)addBottomLineToView:(nonnull UIView *)view
                              withColor:(nonnull UIColor *)aColor
                                originX:(CGFloat)oringinX;

+ (nonnull UIView *)addTopLineToView:(nonnull UIView *)view
                           withColor:(nonnull UIColor *)aColor
                             originX:(CGFloat)oringinX;

+ (nonnull UIView *)addBottomLineToView:(nonnull UIView *)view
                              withColor:(nonnull UIColor *)aColor
                                originX:(CGFloat)oringinX
                      rightIntervalWdth:(CGFloat)rightWdth;

+ (nonnull UIView *)addTopLineToView:(nonnull UIView *)view
                           withColor:(nonnull UIColor *)aColor
                             originX:(CGFloat)oringinX
                   rightIntervalWdth:(CGFloat)rightWdth;

@end
