//
//  UIDevice+XCYDeviceAvailability.h
//  XCY
//  设备信息类（包含了软件和硬件信息以及判断）
//  Created by XCY on 15/7/22.
//  Copyright (c) 2015年 XCY. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface UIDevice (XCYCoreAvailability)
#pragma mark - 设备硬件信息
/**
 *  是否iphone设备
 *
 *  @return YES/NO
 */
+ (BOOL)isIphoneDevice_xcy;
/**
 *  是否ipad设备
 *
 *  @return YES/NO
 */
+ (BOOL)isIpadDevice_xcy;
/**
 *  屏幕比例数值
 *
 *  @return 比例大小
 */
+ (CGFloat)screenScale_xcy;

/**
 *  获取ipad屏幕size
 *
 *  @return 屏幕size
 */
+ (CGSize)mainScreenSize_xcy;
/**
 *  是否retina屏幕
 *
 *  @return YES/NO
 */
+ (BOOL)isRetina_xcy;
/**
 *  是否是4inch屏幕
 *
 *  @return YES/NO
 */
+ (BOOL)is4inchScreen_xcy;
/**
 *  是否是3.5inch屏幕
 *
 *  @return YES/NO
 */
+ (BOOL)is3Point5inchScreen_xcy;

/**
 *  是否是4.7inch屏幕
 *
 *  @return YES/NO
 */
+ (BOOL)is4Point7inchScreen_xcy;

/**
 *  是否是5.5inch屏幕
 *
 *  @return YES/NO
 */
+ (BOOL)is5Point5inchScreen_xcy;

/**
 *  获取屏幕尺寸
 *
 *  @return 尺寸
 */
+ (CGSize)getScreenSize_xcy;

#pragma mark - 设备软件信息

/**
 *  获取当前系统版本
 *
 *  @return 系统版本号
 */
+ (NSString *)getSystemVersion_xcy;

/**
 *  获取系统中设备的名称
 *
 *  @return 机型的字符串
 */
+ (NSString *)getMachineName_xcy;

/**
 *  获取运营商名称(中国联通，中国移动，中国电信等)
 *
 *  @return 运营商名称
 */
+ (NSString *)getTelCarrierName_xcy;

/**
 *  获取当前wifi的SSID
 *
 *  @return wifi SSID
 */
+ (NSString *)getWifiSSID_xcy;


/**
 *  获取当前wifi的接入点的mac地址
 *
 *  @return wifi mac地址(BSSID)
 */
+ (NSString *)getWifiMacAddress_xcy;

/**
 *  是否越狱
 *
 *  @return YES:越狱设备 NO:非越狱设备
 */
+ (BOOL)isJailbroken_xcy;

/**
 *  获取mac地址(未做任何变形)
 *
 *  @return Mac地址字符串
 */
+ (NSString *)macAddress_xcy;

/**
 *  当前版本是在目标版本之后
 *
 *  @param aTargetVersion 目标版本
 *
 *  @return YES/NO
 */
+ (BOOL)currentVersionIsAffterOrEqual_xcy:(NSString *)aTargetVersion;

/**
 *  当前版本是在目标版本之前
 *
 *  @param aTargetVersion 目标版本
 *
 *  @return YES/NO
 */
+ (BOOL)currentVersionIsBefore_xcy:(NSString *)aTargetVersion;
/**
 *  网络类型
 *
 *
 *  @return /2g/3g/4g
 */
+ (NSString *)getNetworkType2g3g4g_xcy;

/**
 *  创建UUID
 *
 */
+ (NSString *)createUUID_xcy;
@end
