//
//  UIView+XCYCoreCoordinate.h
//  XCY
//
//  Created by XCY on 15/8/27.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XCYCoreCoordinate)
//getter
- (CGFloat)height_xcy;
- (CGFloat)width_xcy;
- (CGFloat)x_xcy;
- (CGFloat)y_xcy;
- (CGSize)size_xcy;
- (CGPoint)origin_xcy;
- (CGFloat)centerX_xcy;
- (CGFloat)centerY_xcy;
- (CGFloat)bottom_xcy;
- (CGFloat)right_xcy;

//setter
- (void)setHeight_xcy:(CGFloat)height;
- (void)setWidth_xcy:(CGFloat)width;
- (void)setX_xcy:(CGFloat)x;
- (void)setY_xcy:(CGFloat)y;
- (void)setCenterX_xcy:(CGFloat)centerX;
- (void)setCenterY_xcy:(CGFloat)centerY;










@end
