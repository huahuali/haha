//
//  UIImage+XCYCoreAdditions.m
//  XCY
//
//  Created by XCY on 15/8/4.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "UIImage+XCYCoreAdditions.h"
#import "NSArray+XCYCoreAddition.h"

@implementation UIImage (XCYCoreAdditions)

+ (UIImage*)imageFromMainBundleFile_xcy:(NSString*)aFileName
{
    NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", bundlePath,aFileName]];
}

+ (UIImage *)imageFromBundle:(NSString *)aBundle fileName_xcy:(NSString *)aFileName
{
    NSArray *tempArray = [aFileName componentsSeparatedByString:@"."];
    //如果文件不包含后缀，返回空
    if (tempArray.count != 2)
    {
        return nil;
    }
    
    NSString *name = [tempArray objectAtIndex_xcy:0];
    NSString *suffix = [tempArray objectAtIndex_xcy:1];
    //获取图片时不能直接使用包含@x的图片名称
    if ([name hasSuffix:@"@x"])
    {
        return nil;
    }
    
    //当前屏幕倍数
    NSInteger currentScale = (NSInteger)[[UIScreen mainScreen] scale];
    //获取当前分辨率的图片
    UIImage *image = [self p_getImageFromBundle:aBundle
                                           name:name
                                         suffix:suffix
                                      scale_xcy:currentScale];
    if (image) {
        
        return image;
    }
    
    //如果当前分辨率图片不存在，则查找其它分辨率图片，从高分辨率开始查找
    for (NSInteger tempScale = 3;tempScale >= 1;tempScale--)
    {
        if (tempScale == currentScale)
        {
            continue;
        }
        
        //获取当前分辨率的图片
        UIImage *image = [self p_getImageFromBundle:aBundle
                                               name:name
                                             suffix:suffix
                                          scale_xcy:tempScale];
        if (image) {
            
            return image;
        }
    }
    return nil;
}

+ (UIImage *)imageFromImage:(UIImage *)image inRect_xcy:(CGRect)rect
{
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

#pragma mark - Private Method
+ (NSString *)p_getFileName:(NSString *)aFile
                     suffix:(NSString *)aSuffix
                  scale_xcy:(NSInteger)aScale
{
    NSString *result = @"";
    switch (aScale)
    {
        case 2:
        case 3:
        {
            result = [NSString stringWithFormat:@"%@@%ldx.%@",aFile,(long)aScale,aSuffix];
            break;
        }
        default:
            result = [NSString stringWithFormat:@"%@.%@",aFile,aSuffix];
            break;
    }
    return result;
}

+ (UIImage *)p_getImageFromBundle:(NSString *)aBundleName imageFullName_xcy:(NSString *)aImageFullName
{
    NSString *mainBundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *customBundlePath = [mainBundlePath stringByAppendingPathComponent:aBundleName];
    NSString *filePath = [customBundlePath stringByAppendingPathComponent:aImageFullName];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
    
}

+ (UIImage *)p_getImageFromBundle:(NSString *)aBundleName
                             name:(NSString *)aName
                           suffix:(NSString *)aSuffix
                        scale_xcy:(NSInteger)aScale
{
    //获取当前分辨率的图片
    NSString *fileFullName = [self p_getFileName:aName suffix:aSuffix scale_xcy:aScale];
    UIImage *image = [self p_getImageFromBundle:aBundleName imageFullName_xcy:fileFullName];
    return image;
}

@end
