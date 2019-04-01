//
//  XCYCommonUIUtil.m
//  XCYBlueBox
//
//  Created by XCY on 16/12/31.
//  Copyright © 2016年 XCY. All rights reserved.
//

#import "XCYCommonUIUtil.h"

@implementation XCYCommonUIUtil

+ (CGFloat)getLineViewHeight
{
    CGFloat screenSale = [UIDevice screenScale_xcy];
    static CGFloat lineHeight = 0;
    if (lineHeight == 0) {
        lineHeight = 1.0f/screenSale;
    }
    return lineHeight;
}


+ (nonnull UIView *)addBottomLineToView:(nonnull UIView *)view
                              withColor:(nonnull UIColor *)aColor
{
    
    CGRect viewframe = view.frame;
    CGFloat lineHeight = [XCYCommonUIUtil getLineViewHeight];
    CGRect bottomLineFrame = CGRectMake(0.0, CGRectGetHeight(viewframe) - lineHeight, CGRectGetWidth(viewframe), lineHeight);
    UIView *btomView = [[UIView alloc]initWithFrame:bottomLineFrame];
    [btomView setBackgroundColor:aColor];
    
    [view addSubview:btomView];
    return view;
}


+ (nonnull UIView *)addTopLineToView:(nonnull UIView *)view
                           withColor:(nonnull UIColor *)aColor
{
    CGRect viewframe = view.frame;
    CGFloat lineHeight = [XCYCommonUIUtil getLineViewHeight];
    CGRect topLineFrame = CGRectMake(0.0, 0.0, CGRectGetWidth(viewframe), lineHeight);
    UIView *topView = [[UIView alloc]initWithFrame:topLineFrame];
    [topView setBackgroundColor:aColor];
    
    [view addSubview:topView];
    return view;
}

+ (nonnull UIView *)addBottomLineToView:(nonnull UIView *)view
                              withColor:(nonnull UIColor *)aColor
                                originX:(CGFloat)oringinX
{
    CGRect viewframe = view.frame;
    CGFloat lineHeight = [XCYCommonUIUtil getLineViewHeight];
    CGRect bottomLineFrame = CGRectMake(oringinX, CGRectGetHeight(viewframe) - lineHeight, CGRectGetWidth(viewframe) - oringinX, lineHeight);
    UIView *btomView = [[UIView alloc]initWithFrame:bottomLineFrame];
    [btomView setBackgroundColor:aColor];
    
    [view addSubview:btomView];
    return view;
}

+ (nonnull UIView *)addTopLineToView:(nonnull UIView *)view
                           withColor:(nonnull UIColor *)aColor
                             originX:(CGFloat)oringinX
{
    CGRect viewframe = view.frame;
    CGFloat lineHeight = [XCYCommonUIUtil getLineViewHeight];
    CGRect topLineFrame = CGRectMake(oringinX, 0.0, CGRectGetWidth(viewframe)-oringinX, lineHeight);
    UIView *topView = [[UIView alloc]initWithFrame:topLineFrame];
    [topView setBackgroundColor:aColor];
    
    [view addSubview:topView];
    return view;
}
+ (nonnull UIView *)addBottomLineToView:(nonnull UIView *)view
                              withColor:(nonnull UIColor *)aColor
                                originX:(CGFloat)oringinX
                      rightIntervalWdth:(CGFloat)rightWdth
{
    CGRect viewframe = view.frame;
    CGFloat lineHeight = [XCYCommonUIUtil getLineViewHeight];
    CGRect bottomLineFrame = CGRectMake(oringinX, CGRectGetHeight(viewframe) - lineHeight, CGRectGetWidth(viewframe) - oringinX - rightWdth, lineHeight);
    UIView *btomView = [[UIView alloc]initWithFrame:bottomLineFrame];
    [btomView setBackgroundColor:aColor];
    
    [view addSubview:btomView];
    return view;
}

+ (nonnull UIView *)addTopLineToView:(nonnull UIView *)view
                           withColor:(nonnull UIColor *)aColor
                             originX:(CGFloat)oringinX
                   rightIntervalWdth:(CGFloat)rightWdth
{
    CGRect viewframe = view.frame;
    CGFloat lineHeight = [XCYCommonUIUtil getLineViewHeight];
    CGRect topLineFrame = CGRectMake(oringinX, 0.0, CGRectGetWidth(viewframe)-oringinX-rightWdth, lineHeight);
    UIView *topView = [[UIView alloc]initWithFrame:topLineFrame];
    [topView setBackgroundColor:aColor];
    
    [view addSubview:topView];
    return view;
}
@end
