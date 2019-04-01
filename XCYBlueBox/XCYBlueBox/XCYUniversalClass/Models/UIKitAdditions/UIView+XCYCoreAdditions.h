//
//  UIView+XCYCoreAdditions.h
//  XCY
//
//  Created by XCY on 15/8/20.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XCYCoreAdditions)

/**
 为view添加阴影
 @param color 阴影颜色
 @param offset The offset (in points) of the layer’s shadow.
 @param opacity The opacity of the layer’s shadow.
 @param radius blur radius (in points) used to render the layer’s shadow.
 */
- (void)showShadowWithColor:(UIColor *)color
                     offset:(CGSize)offset
                    opacity:(CGFloat)opacity
                 radius_xcy:(CGFloat)radius;

@end
