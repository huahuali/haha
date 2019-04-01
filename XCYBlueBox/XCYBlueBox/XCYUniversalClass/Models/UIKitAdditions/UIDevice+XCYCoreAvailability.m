//
//  UIDevice+XCYDeviceAvailability.m
//  XCY
//
//  Created by XCY on 15/7/22.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "sys/utsname.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "UIDevice+XCYCoreAvailability.h"
@import UIKit;


@implementation UIDevice (XCYCoreAvailability)

#pragma mark - 设备硬件信息
+ (BOOL)isIphoneDevice_xcy
{
    static NSInteger isPhone;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      isPhone = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? 1 : 0;
    });
    
    return isPhone > 0;

}

+ (BOOL)isIpadDevice_xcy
{
    static NSInteger isPad;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isPad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ? 1 : 0;
    });
    
    return isPad > 0;

}

+ (CGFloat)screenScale_xcy
{
    return [[UIScreen mainScreen] scale];
}

+ (CGSize)mainScreenSize_xcy
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (size.width < size.height)
    {
        size = CGSizeMake(size.height, size.width);
    }
    
    return size;
}

+ (BOOL)isRetina_xcy
{
    return [UIDevice screenScale_xcy] > 1.f;

}

+ (CGSize)getScreenSize_xcy
{
    static CGSize size;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        size = [[UIScreen mainScreen] bounds].size;
    });
    return size;
}

+ (BOOL)is4inchScreen_xcy
{
   
    CGFloat deviceHeight = [UIDevice getScreenSize_xcy].height;
    if (deviceHeight == 568) {
        return YES;
    }
    return NO;
}

+ (BOOL)is3Point5inchScreen_xcy
{
    CGFloat deviceHeight = [UIDevice getScreenSize_xcy].height;
    if (deviceHeight == 480) {
        return YES;
    }
    return NO;

}

+ (BOOL)is4Point7inchScreen_xcy
{
    CGFloat deviceHeight = [UIDevice getScreenSize_xcy].height;
    if (deviceHeight == 667) {
        return YES;
    }
    
    return NO;


}

+ (BOOL)is5Point5inchScreen_xcy
{
    CGFloat deviceHeight = [UIDevice getScreenSize_xcy].height;
    if (deviceHeight == 736) {
        return YES;
    }
    return NO;

}


#pragma mark - 设备软件信息
+ (NSString *)getSystemVersion_xcy
{

    static NSString *systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = [[UIDevice currentDevice] systemVersion];
    });
    
    return systemVersion;
}

//获取设备的机型
+ (NSString *)getMachineName_xcy
{
    static  NSString* deviceString;
    static  dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        struct utsname systemInfo;
        uname(&systemInfo);
        deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    });

    return deviceString;
}

+ (NSString *)getTelCarrierName_xcy
{
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier*carrier = [netInfo subscriberCellularProvider];
    
    NSString *name = carrier.carrierName;
    if (!name) {
        name = @"";
    }
    
    return name;
}

+ (NSString *)getWifiSSID_xcy
{
    NSString *ssid = @"";

    NSArray *ifs = (__bridge NSArray *)CNCopySupportedInterfaces();
    
    if (ifs.count > 0) {
        NSString *ifName = [ifs objectAtIndex:0];
        NSDictionary *info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifName);
        NSDictionary *infoDict = [NSDictionary dictionaryWithDictionary:info];
        ssid = [infoDict valueForKey:@"SSID"];
        //对象为空时，调用CFRelease会造成闪退
        if (info) {
            CFRelease((__bridge CFTypeRef)(info));info = NULL;
        }
    }
    if (ifs) {
        CFRelease((__bridge CFTypeRef)(ifs));ifs = NULL;
    }
    
  
    
    return ssid;
}

//接入点的mac地址
+ (NSString *)getWifiMacAddress_xcy
{
    NSString *bssid = nil;
    NSArray *ifs = (NSArray *)CFBridgingRelease(CNCopySupportedInterfaces());
    
    if (ifs.count > 0) {
        NSString *ifName = [ifs objectAtIndex:0];
        NSDictionary *info = (id)CFBridgingRelease(CNCopyCurrentNetworkInfo((CFStringRef)ifName));
        NSDictionary *infoDict = [NSDictionary dictionaryWithDictionary:info];
        bssid = [infoDict valueForKey:@"BSSID"];
    }
    
    if(!bssid)
    {
        bssid = NSLocalizedString(@"emptyString", nil);
    }
    
    return bssid;
}

//wifi下设备ip地址
+ (NSString *)getCustomWifiIP
{
    BOOL success;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    
    success = getifaddrs(&addrs) == 0;
    NSString *wifiIP = nil;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            // the second test keeps from picking up the loopback address
            if ((cursor->ifa_addr->sa_family == AF_INET ||cursor->ifa_addr->sa_family == AF_INET6)&& (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"])  // Wi-Fi adapter
                {
                    wifiIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                    break;
                }
            }
            cursor = cursor->ifa_next;
        }
        
    }
    freeifaddrs(addrs);
    if(!wifiIP)
    {
        wifiIP = NSLocalizedString(@"emptyString", nil);;
    }
    return wifiIP;
}

//是否越狱
+ (BOOL)isJailbroken_xcy
{
    BOOL jailbroken = NO;
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        jailbroken = YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        jailbroken = YES;
    }
    return jailbroken;
}



+ (NSString *)macAddress_xcy
{
    static NSString *outstring = @"";

    if ([outstring isEqualToString:@""]) {
        int                 mib[6];
        size_t              len;
        char                *buf;
        unsigned char       *ptr;
        struct if_msghdr    *ifm;
        struct sockaddr_dl  *sdl;
        
        mib[0] = CTL_NET;
        mib[1] = AF_ROUTE;
        mib[2] = 0;
        mib[3] = AF_LINK;
        mib[4] = NET_RT_IFLIST;
        
        if ((mib[5] = if_nametoindex("en0")) == 0) {
            printf("Error: if_nametoindex error\n");
            return NULL;
        }
        
        if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
            printf("Error: sysctl, take 1\n");
            return NULL;
        }
        
        if ((buf = malloc(len)) == NULL) {
            printf("Could not allocate memory. error!\n");
            return NULL;
        }
        
        if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
            printf("Error: sysctl, take 2");
            free(buf);
            return NULL;
        }
        
        ifm = (struct if_msghdr *)buf;
        sdl = (struct sockaddr_dl *)(ifm + 1);
        ptr = (unsigned char *)LLADDR(sdl);
        outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                               *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
        free(buf);

    }
    
    return outstring;
}


+ (BOOL)currentVersionIsAffterOrEqual_xcy:(NSString *)aTargetVersion
{
    NSParameterAssert(aTargetVersion);
    NSString *currentVersion = [UIDevice getSystemVersion_xcy];
    NSComparisonResult compareResult = [currentVersion compare:aTargetVersion options:NSNumericSearch];
    BOOL compareBool = (compareResult != NSOrderedAscending);
    return compareBool;

}

+ (BOOL)currentVersionIsBefore_xcy:(NSString *)aTargetVersion
{
    NSParameterAssert(aTargetVersion);
    NSString *currentVersion = [UIDevice getSystemVersion_xcy];
    NSComparisonResult compareResult = [currentVersion compare:aTargetVersion options:NSNumericSearch];
    BOOL compareBool = (compareResult == NSOrderedAscending);
    return compareBool;
}

+ (NSString *)getNetworkType2g3g4g_xcy
{
    NSString *networkState = @"unknown";
    if ([self currentVersionIsAffterOrEqual_xcy:@"7.0"])
    {
        CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
        NSString *networkStatus = networkInfo.currentRadioAccessTechnology;
        if ([networkStatus isEqualToString:CTRadioAccessTechnologyGPRS] ||
            [networkStatus isEqualToString:CTRadioAccessTechnologyEdge])
        {
            networkState = @"2g";
        }
        else if ([networkStatus isEqualToString:CTRadioAccessTechnologyWCDMA] ||
                 [networkStatus isEqualToString:CTRadioAccessTechnologyHSDPA] ||
                 [networkStatus isEqualToString:CTRadioAccessTechnologyHSUPA] ||
                 [networkStatus isEqualToString:CTRadioAccessTechnologyCDMA1x] ||
                 [networkStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0] ||
                 [networkStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA] ||
                 [networkStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB] ||
                 [networkStatus isEqualToString:CTRadioAccessTechnologyeHRPD])
        {
            networkState = @"3g";
        }
        else if ([networkStatus isEqualToString:CTRadioAccessTechnologyLTE])
        {
            networkState = @"4g";
        }
    }
    else
    {
        NSNumber *dataNewtworkItemView = nil;
        UIApplication *app = [UIApplication sharedApplication];
        NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
        if (subviews && [subviews isKindOfClass:[NSArray class]] && 0 < subviews.count)
        {
            for (id subview in subviews)
            {
                if ([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]])
                {
                    dataNewtworkItemView = subview;
                    break;
                }
            }
        }
        NSNumber *num = [dataNewtworkItemView valueForKey:@"dataNetworkType"];
        if (num != nil)
        {
            int n = [num intValue];
            if (n == 1)
            {
                networkState = @"2g";
            }
            else if (n == 2)
            {
                networkState = @"3g";
            }
            else if (n == 3)
            {
                networkState = @"4g";
            }
        }
        
    }
    return networkState;

}


//add by zat 2016.10.19
+ (NSString *)createUUID_xcy
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    if (uuidRef != NULL)
    {
        CFRelease(uuidRef);uuidRef = NULL;
    }
    
    NSString *uuid = (__bridge NSString *)uuidStringRef;
    if (uuidStringRef != NULL) {
        CFRelease(uuidStringRef);uuidStringRef = NULL;
    }
    return uuid;
}
//end

@end
