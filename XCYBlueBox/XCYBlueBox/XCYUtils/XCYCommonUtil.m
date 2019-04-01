//
//  XCYCommonUtil.m
//  XCYBusinessCard
//
//  Created by  on 15-2-10.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "XCYCommonUtil.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/sysctl.h>

/**
 * 输出log
 */
static void showLog(NSString*,...);

/*---------------------------------------------------------------------------*/

/**
 * 输出log
 */
static void showLog(NSString *log,...)
{
    if (xcyShowLogFlag) {
        va_list args;
        va_start(args,log);
        NSString *str = [[NSString alloc] initWithFormat:log arguments:args];
        va_end(args);
        NSLog(@" %@ ",str);
    }
}




const struct CommonUtil commonFunction = {

    .showLog = showLog



};



@implementation XCYCommonUtil

+ (NSString *)firstCharactorWithString:(NSString *)string
{
    if ([NSString strNilOrEmpty_xcy:string]) {
        
        return @"";
    }
    
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    return [pinYin substringToIndex:1];
}


+ (CGSize)getLabelSizeWithFont:( UIFont *)aFont
                    textString:( NSString *)aTextStr
{
    CGSize labelSize = [aTextStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:aFont, NSFontAttributeName, nil]];
    return labelSize;
}

@end





