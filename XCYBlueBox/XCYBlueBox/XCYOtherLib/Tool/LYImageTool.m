//
//  LYImageTool.m
//  MusicPlayer
//
//  Created by Y Liu on 15/12/27.
//  Copyright © 2015年 CoderYLiu. All rights reserved.
//

#import "LYImageTool.h"

@implementation LYImageTool

+ (UIImage *)createImageWithText:(NSString *)text inImage:(UIImage *)image
{
    UIGraphicsBeginImageContext(image.size);
    
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    
    NSDictionary *dict = @{
                          NSForegroundColorAttributeName : [UIColor colorWithRed:250 / 250.0 green:191 / 250.0 blue:20 / 250.0 alpha:1.0],
                          NSParagraphStyleAttributeName : style,
                          NSFontAttributeName : [UIFont systemFontOfSize:20]
                          };
    [text drawInRect:CGRectMake(0, image.size.height - 26, image.size.width, 26) withAttributes:dict];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

@end
