//
//  XCYAppScreenMetrics.h
//  XCY
//
//  Created by XCY on 15/9/18.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#if defined __cplusplus
extern "C" {
#endif
#pragma mark - 通用UI数值获取
    CGSize XCYTitleBarSize(void);
    CGFloat XCYTitleBarOffsetY(void);
    CGSize XCYTabBarSize(void);
    CGFloat XCYAppStatusBarStatusHeight(void);
    CGSize XCYAppScreenSize(void);
    CGRect XCYAppStatusBarFrame(void);
#if defined __cplusplus
};
#endif
