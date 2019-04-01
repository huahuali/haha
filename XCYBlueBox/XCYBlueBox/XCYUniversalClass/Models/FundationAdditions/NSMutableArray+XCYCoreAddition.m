//
//  NSMutableArray+XCYCoreAddition.m
//  XCY
//
//  Created by XCY on 16/2/29.
//  Copyright © 2016年 XCY. All rights reserved.
//

#import "NSMutableArray+XCYCoreAddition.h"

@implementation NSMutableArray (XCYCoreAddition)

- (void)removeObjectAtIndex_xcy:(NSUInteger)index
{
    if (self.count == 0) {
        return;
    }
    if (index >= self.count) {
        return;
    }
    [self removeObjectAtIndex:index];
}

- (void)addObject_xcy:(id)anObject
{
    if (!anObject) {
        return;
    }
    [self addObject:anObject];
}

- (void)insertObject_xcy:(id)anObject atIndex:(NSUInteger)index
{
    if (!anObject) {
        return;
    }
    if (index > self.count) {
        return;
    }
    [self insertObject:anObject atIndex:index];
}

@end
