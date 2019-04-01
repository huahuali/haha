//
//  XCYSystemUserDefaultUtil
//  XCYSystemUserDefaultUtil
//
//  Created by  on 15/11/17.
//  Copyright © 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCYSystemUserDefaultUtil : NSObject
/**
 *  保存字符串数据至UserDefault
 *
 *  @param object   字符串对象
 *  @param storeKey 保存键值
 *
 *  @return 是否保存成功
 */
+(BOOL)saveStringToUserDefault:(NSString*)object
                           key:(NSString*)storeKey;

/**
 *  从userDefault获取对应数据
 *
 *  @param storeKey 保存键值
 *
 *  @return 目标数据
 */
+(NSString*)getStringFromUserDefault:(NSString*)storeKey;

/**
 *  保存数据(数组，自定义对象)至userdefault
 *
 *  @param object   数据对象
 *  @param storeKey 保存键值
 *
 *  @return 保存是否成功
 */
+(BOOL)saveDataToUserDefault:(id)object
                         key:(NSString*)storeKey;

/**
 *  获取数据
 *
 *  @param storeKey 保存键值
 *
 *  @return 数据对象
 */
+(id)getDataFromUserDefault:(NSString*)storeKey;


@end
