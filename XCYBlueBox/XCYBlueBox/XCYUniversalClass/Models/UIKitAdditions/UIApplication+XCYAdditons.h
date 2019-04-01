//
//  UIApplication+XCYAdditons.h
//  XCY
//
//  Created by XCY on 16/9/18.
//  Copyright © 2016年 XCY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (XCYAdditons)
//获取应用窗口
+ (UIWindow *)applicationWindow_xcy;
//获取应用根视图管理器
+ (UINavigationController *)applicationRootViewController_xcy;

/**
 跳转到应用设置
 */
+ (BOOL)goToAppSettings_xcy;
@end
