//
//  UIView+XCYCoreAdditions.m
//  XCY
//
//  Created by XCY on 15/8/20.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "UIView+XCYCoreAdditions.h"

@implementation UIView (XCYCoreAdditions)

- (void)showShadowWithColor:(UIColor *)color
                     offset:(CGSize)offset
                    opacity:(CGFloat)opacity
                 radius_xcy:(CGFloat)radius {
    ///<提高渲染性能
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    CGPathRef path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    [self.layer setShadowPath:path];
    //>>
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
}

@end
