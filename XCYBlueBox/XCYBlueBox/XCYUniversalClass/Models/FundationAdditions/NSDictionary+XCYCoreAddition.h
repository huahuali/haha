//
//  NSDictionary+XCYCoreAddition.h
//  XCY
//
//  Created by XCY on 15/7/23.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (XCYCoreAddition)
/**
 *  创建noretain字典
 */
+ (NSMutableDictionary *)getNoRetainMutableDictionary_xcy;
/**
 *  制定获取为数组
 *
 *  @return 数组
 */
- (NSArray*)arrayForKey_xcy:(id)key;

/**
 *  获取服务器返回数据，指定类型返回，如果不符合类型，那么返回nil
 *
 *  @param key NSString
 *  @param valueClass value类类型
 *
 *  @return value
 */
- (id)objectForKey_xcy:(NSString *)key withValueClass:(Class)valueClass;

/**
 *  获取字符串，未找到则返回 @“”
 *
 *  @param key NSString
 */
- (NSString *)stringForKey_xcy:(NSString *)key;

@end
