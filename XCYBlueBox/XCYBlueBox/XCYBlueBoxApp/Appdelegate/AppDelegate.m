//
//  AppDelegate.m
//  XCYBlueBox
//
//  Created by XCY on 16/12/30.
//  Copyright © 2016年 XCY. All rights reserved.
//

#import "AppDelegate.h"
#import "XCYMainRootViewController.h"
//#import "XCYAlarmClockNotificationCenter.h"
#import "XCYUISystemAlertServer.h"
#import <AVFoundation/AVFoundation.h>
#import "XCYBlueToothCentralManager.h"
//#import "XCYEQDataManager.h"

@interface AppDelegate ()

@property(nonatomic, retain)UINavigationController *rootVc;

@property (strong, nonatomic) XCYMainRootViewController *mainRoot;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 保存当前APP语言
    [self setLanguageFromSystem];
    
    [self p_initRootViewController];
    
    [self p_registeryNotificaiton];
    [self p_registeryInfo];

    [application setIdleTimerDisabled:YES];
    
    return YES;
}

- (void)p_initRootViewController
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    _mainRoot = [XCYMainRootViewController sharedInstance];
    
    self.rootVc = [[UINavigationController alloc]initWithRootViewController:_mainRoot];
    [_rootVc setNavigationBarHidden:YES];
    
    self.window.rootViewController = _rootVc;
}

- (void)p_registeryInfo
{

    // 获取音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 设置会话类别为后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)p_registeryNotificaiton
{
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
        
    {
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

    //从后台到前台，通知各模块处理
    [[NSNotificationCenter defaultCenter] postNotificationName:@"XCYapplicationDidBecomeActive" object:nil];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    
    commonFunction.showLog(@"退出应用断开BLE蓝牙连接");
    //断开BLE蓝牙连接
    XCYBlueToothCentralManager *centralManager = [XCYBlueToothCentralManager shareInstance];
    [centralManager clearCentralManager];
}

#pragma Lily - private
- (void)p_saveCurrentAppLanguage {
    if (![kUserDefaults objectForKey:kAppLanguage]) {
        // 默认为中文
        [kUserDefaults setObject:kChineseLanguage forKey:kAppLanguage];
    }
}

#pragma Lily - pulic
//- (void)resetRootViewController {
//    self.window.rootViewController = [[WexViewConfigManager getInstance] resetRootViewController];
//}

- (void)setLanguageFromSystem {
    // 根据系统语言设置中英文
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *language = [languages objectAtIndex:0];
    
    if ([language hasPrefix:kChineseLanguage]) {
        // 默认为中文
        [kUserDefaults setObject:kChineseLanguage forKey:kAppLanguage];
    } else {
        [kUserDefaults setObject:kEnglishLanguage forKey:kAppLanguage];
    }
}

@end
