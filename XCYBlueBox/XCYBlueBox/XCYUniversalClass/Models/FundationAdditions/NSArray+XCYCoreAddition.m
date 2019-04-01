//
//  NSArray+XCYCoreAddition.m
//  XCY
//
//  Created by XCY on 15/7/23.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "NSArray+XCYCoreAddition.h"

@implementation NSArray (XCYCoreAddition)

+ (NSMutableArray *)getNoRetainMutableArray_xcy
{
    return (__bridge_transfer NSMutableArray *)CFArrayCreateMutable(nil, 0, nil);
}

- (id)objectAtIndex_xcy:(NSUInteger)index
{
    if (self.count == 0) {
        return nil;
    }
    if (index >= self.count) {
        return nil;
    }
    
    return [self objectAtIndex:index];
}

@end
