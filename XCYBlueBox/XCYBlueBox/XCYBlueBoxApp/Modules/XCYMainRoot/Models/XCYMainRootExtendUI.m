//
//  XCYMainRootExtendUI.m
//  XCYSharKey
//
//  Created by XCY on 15/6/22.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "XCYMainRootExtendUI.h"
#import "XCYTopBarButtonItem.h"

@implementation XCYMainRootExtendUI


+(XCYTopBarButtonItem*)customLeftBarItemTarget:(id)target
                                        action:(SEL)action
{
    
    CGRect customframe = CGRectMake(0,
                                    iphoneStatusBarHeight,
                                    70,
                                    xcyTopBarHeight-iphoneStatusBarHeight);
    
    UIView *view = [[UIView alloc]initWithFrame:customframe];
    view.backgroundColor = [UIColor clearColor];
    
    CGRect imageViewframe = CGRectMake(0, (customframe.size.height-28.0)/2, 28, 28);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageViewframe];
    imageView.image = [UIImage imageNamed:@"xcy_LeftNavBarItem.png"];
    [view addSubview:imageView];
    
    CGRect labelframe = CGRectMake(imageViewframe.origin.x+imageViewframe.size.width, (customframe.size.height-28.0)/2, customframe.size.width-imageViewframe.origin.x-imageViewframe.size.width, 28);
    
    UILabel *label = [[UILabel alloc]initWithFrame:labelframe];
    label.text = @"导航";
    label.font = [UIFont systemFontOfSize:17.0f];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = view.bounds;
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    XCYTopBarButtonItem *item = [[XCYTopBarButtonItem alloc]initWithCustomView:view];
    
    return item;
}

@end
