//
//  UIImage+XCYCoreAdditions.h
//  XCY
//
//  Created by XCY on 15/8/4.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XCYCoreAdditions)

/**
 *  获取主bundle中的图片
 *
 *  @param aFileName 文件名称
 *
 *  @return 图片
 */
+ (UIImage*)imageFromMainBundleFile_xcy:(NSString*)aFileName;

/**
 *  获取bundle中的图片
 *
 *  @param aBundle   bundle名称
 *  @param aFileName 文件名称
 *
 *  @return 图片
 */
+ (UIImage *)imageFromBundle:(NSString *)aBundle fileName_xcy:(NSString *)aFileName;

/**
 *  截取图片
 *
 *  @param image 图片名称
 *  @param rect  截取矩形
 *
 *  @return 截取后的图片
 */
+ (UIImage *)imageFromImage:(UIImage *)image inRect_xcy:(CGRect)rect;
@end
