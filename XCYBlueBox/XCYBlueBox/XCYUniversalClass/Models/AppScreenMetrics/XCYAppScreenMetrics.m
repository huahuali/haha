//
//  XCYAppScreenMetrics.m
//  XCY
//
//  Created by XCY on 15/9/18.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "XCYAppScreenMetrics.h"
#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "Nimbus requires ARC support."
#endif

CGSize XCYTitleBarSize(void)
{
    static CGSize titleBarSize;
    static BOOL isGet = NO;
    if (!isGet)
    {
        titleBarSize = CGSizeMake([UIDevice getScreenSize_xcy].width, (44.0f + XCYTitleBarOffsetY()));
        isGet = YES;
    }
    return titleBarSize;
}


CGFloat XCYTitleBarOffsetY(void)
{
    static CGFloat offsetY = 0.0;
    if (offsetY == 0.0) {
        offsetY = ([UIDevice currentVersionIsAffterOrEqual_xcy:@"7.0"]?20.0:0.0);
    }
    return offsetY;
    
}


CGSize XCYTabBarSize(void)
{
    CGSize size = CGSizeMake([UIDevice getScreenSize_xcy].width, 53.0f);
    return size;
}

CGFloat XCYAppStatusBarStatusHeight(void)
{
    return CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);

}

CGSize XCYAppScreenSize(void)
{
    CGSize screenSize = [UIDevice getScreenSize_xcy];
    CGFloat offsetY = XCYAppStatusBarStatusHeight();
    CGFloat statusBarHeight = XCYAppStatusBarStatusHeight();
    if([UIDevice currentVersionIsAffterOrEqual_xcy:@"7.0"])
    {
        offsetY = 0.0;
    }
    //如果有热点栏
    if (statusBarHeight == 40) {
        offsetY = 20.0f;
    }
    
    CGSize appScreenSize = CGSizeMake(screenSize.width, screenSize.height - offsetY);
    
    return appScreenSize;
}

CGRect XCYAppStatusBarFrame(void)
{
    CGRect frame = CGRectMake(0.0, 0.0f, XCYAppScreenSize().width, 20.0f);
    return frame;
}

