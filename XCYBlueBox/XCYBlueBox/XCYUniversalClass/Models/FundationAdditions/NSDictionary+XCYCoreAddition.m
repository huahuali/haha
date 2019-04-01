//
//  NSDictionary+XCYCoreAddition.m
//  XCY
//
//  Created by XCY on 15/7/23.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "NSDictionary+XCYCoreAddition.h"
#import "NSString+XCYCoreJudge.h"


@implementation NSDictionary (XCYCoreAddition)
+ (NSMutableDictionary *)getNoRetainMutableDictionary_xcy
{
    return (__bridge_transfer NSMutableDictionary *)CFDictionaryCreateMutable(nil, 0, nil, nil);
}


- (NSArray*)arrayForKey_xcy:(id)key
{
    id object = [self objectForKey:key];
    
    // if it's not an array, then make it a 1-element array
    if (![object isKindOfClass:[NSArray class]]) {
        object = [NSArray arrayWithObject:object];
    }
    
    return object;
}

- (id)objectForKey_xcy:(NSString *)key withValueClass:(Class)valueClass
{
    if (![key isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    if (valueClass == NULL) {
        return nil;
    }
    
    id value = [self objectForKey:key];
    
    if (!value) {
        return nil;
    }
    
    if (valueClass == [NSArray class] && ![value isKindOfClass:[NSArray class]]) {
        return [NSArray arrayWithObjects:value, nil];
    }
    
    if (![value isKindOfClass:valueClass]) {
        return nil;
    }
    
    return value;

}

- (NSString *)stringForKey_xcy:(NSString *)key
{
    NSString *value = [self objectForKey_xcy:key
                               withValueClass:[NSString class]];
    if ([NSString strNilOrEmpty_xcy:value])
    {
        value = @"";
    }
    return value;
}

@end
