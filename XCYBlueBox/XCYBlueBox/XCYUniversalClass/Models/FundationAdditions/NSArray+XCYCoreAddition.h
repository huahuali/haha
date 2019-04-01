//
//  NSArray+XCYCoreAddition
//  XCY
//
//  Created by XCY on 15/7/23.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (XCYCoreAddition)

/**
 *  创建no retain数组
 *
 *  @return NSMutableArray
 */
+ (NSMutableArray *)getNoRetainMutableArray_xcy;

/**
 *  在数组中根据索引查找对象
 *
 *  @param index 索引
 *
 *  @return 查找的数据
 */
- (id)objectAtIndex_xcy:(NSUInteger)index;

@end
