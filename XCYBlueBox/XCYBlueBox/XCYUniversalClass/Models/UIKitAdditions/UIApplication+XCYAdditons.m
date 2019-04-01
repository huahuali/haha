//
//  UIApplication+XCYAdditons.m
//  XCY
//
//  Created by XCY on 16/9/18.
//  Copyright © 2016年 XCY. All rights reserved.
//

#import "UIApplication+XCYAdditons.h"

@implementation UIApplication (XCYAdditons)
+ (UIWindow *)applicationWindow_xcy
{
    id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    return [delegate window];

}

+ (UINavigationController *)applicationRootViewController_xcy
{
    UIWindow *window = [UIApplication applicationWindow_xcy];
    return (UINavigationController *)window.rootViewController;
}

+ (BOOL)goToAppSettings_xcy
{

    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if (!url) {
        return NO;
    }
    
    return [[UIApplication sharedApplication] openURL:url];

}
@end
