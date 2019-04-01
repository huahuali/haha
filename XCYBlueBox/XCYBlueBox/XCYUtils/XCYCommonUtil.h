//
//  XCYCommonUtil.h
//  XCYBusinessCard
//
//  Created by XCY on 15-2-10.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

//是否输出日志
#define xcyShowLogFlag YES

extern const struct CommonUtil
{
    void (*showLog)(NSString*,...);
    
}commonFunction;


@interface XCYCommonUtil : NSObject

/*
 *  获取字符串的首字母，首字母大写
 */
+ (NSString *)firstCharactorWithString:(NSString *)string;


/**
 根据字体大小和长度，获取label的size

 @param aFont 字体大小
 @param aTextStr 内容
 @return size
 */
+ (CGSize)getLabelSizeWithFont:( UIFont *)aFont
                    textString:( NSString *)aTextStr;
@end
