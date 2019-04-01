//
//  UIView+XCYCoreCoordinate.m
//  XCY
//
//  Created by XCY on 15/8/27.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "UIView+XCYCoreCoordinate.h"

@implementation UIView (XCYCoreCoordinate)
- (CGFloat)height_xcy
{
    return self.frame.size.height;
}

- (CGFloat)width_xcy
{
    return self.frame.size.width;
}

- (CGFloat)x_xcy
{
    return self.frame.origin.x;
}

- (CGFloat)y_xcy
{
    return self.frame.origin.y;
}

- (CGSize)size_xcy
{
    return self.frame.size;
}

- (CGPoint)origin_xcy
{
    return self.frame.origin;
}

- (CGFloat)centerX_xcy
{
    return self.center.x;
}

- (CGFloat)centerY_xcy
{
    return self.center.y;
}

- (CGFloat)bottom_xcy
{
    return self.frame.size.height + self.frame.origin.y;
}

- (CGFloat)right_xcy
{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setHeight_xcy:(CGFloat)height
{
    CGRect newFrame = CGRectMake(self.x_xcy, self.y_xcy, self.width_xcy, height);
    self.frame = newFrame;
}

- (void)setWidth_xcy:(CGFloat)width
{
    CGRect newFrame = CGRectMake(self.x_xcy, self.y_xcy, width, self.height_xcy);
    self.frame = newFrame;
}

- (void)setX_xcy:(CGFloat)x
{
    self.frame = CGRectMake(x, self.y_xcy, self.size_xcy.width, self.size_xcy.height);

}

- (void)setY_xcy:(CGFloat)y
{
    self.frame = CGRectMake(self.x_xcy, y, self.size_xcy.width, self.size_xcy.height);

}

- (void)setCenterX_xcy:(CGFloat)centerX
{
    CGPoint center = CGPointMake(self.centerX_xcy, self.centerY_xcy);
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY_xcy:(CGFloat)centerY
{
    
    CGPoint center = CGPointMake(self.centerX_xcy, self.centerY_xcy);
    center.y = centerY;
    self.center = center;
}


@end
