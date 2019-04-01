//
//  XCYSystemUserDefaultUtil.m
//
//
//  Created by  on 15/11/17.
//  Copyright © 2015年 . All rights reserved.
//

#import "XCYSystemUserDefaultUtil.h"

@implementation XCYSystemUserDefaultUtil

+(BOOL)saveStringToUserDefault:(NSString*)object
                           key:(NSString*)storeKey
{
    NSAssert(object != nil, @"参数不能为空");
    NSAssert(storeKey != nil,@"参数不能为空");
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:object forKey:storeKey];
    return [userDefault synchronize];
    
}

+(NSString*)getStringFromUserDefault:(NSString*)storeKey
{
    NSAssert(storeKey != nil, @"参数不能为空");
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:storeKey];
    
}

+(BOOL)saveDataToUserDefault:(id)object
                         key:(NSString*)storeKey
{
    
    NSAssert(storeKey != nil, @"参数不能为空");
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    [userDefault setObject:udObject forKey:storeKey];
    return [userDefault synchronize];
    
}


+(id)getDataFromUserDefault:(NSString*)storeKey
{
    
    NSAssert(storeKey != nil, @"参数不能为空");
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *objectData = [userDefault objectForKey:storeKey];
    if (![objectData isKindOfClass:[NSData class]]) {
        return nil;
    }
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:objectData];
    return object;
}

@end
