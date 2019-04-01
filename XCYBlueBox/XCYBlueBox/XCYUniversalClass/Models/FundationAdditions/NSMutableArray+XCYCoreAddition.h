//
//  NSMutableArray+XCYCoreAddition.h
//  XCY
//
//  Created by XCY on 16/2/29.
//  Copyright © 2016年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (XCYCoreAddition)

/**
 *  删除数组中的数据
 *
 *  @param index 索引
 */
- (void)removeObjectAtIndex_xcy:(NSUInteger)index;

/**
 *  向数组中添加数据
 *
 *  @param anObject 元素
 */
- (void)addObject_xcy:(id)anObject;

/**
 *  添加数据
 *
 *  @param anObject 元素
 *  @param index 索引
 */
- (void)insertObject_xcy:(id)anObject atIndex:(NSUInteger)index;

@end
