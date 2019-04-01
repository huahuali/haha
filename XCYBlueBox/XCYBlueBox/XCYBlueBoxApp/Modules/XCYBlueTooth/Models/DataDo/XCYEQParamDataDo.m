//
//  XCYEQParamDataDo.m
//  XCYBlueBox
//
//  Created by XCY on 2017/4/10.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYEQParamDataDo.h"

@interface XCYEQParamDataDo ()

@property (strong, nonatomic) NSMutableDictionary *curDict;

@end

@implementation XCYEQParamDataDo

- (instancetype)init
{
    if (self = [super init]) {
        
        _curDict = [[NSMutableDictionary alloc] initWithCapacity:1];
    }
    
    return self;
}

- (instancetype)initWithDict:(NSDictionary *)aDict
{
    if (self = [super init]) {
        
        if (aDict) {
            
            _curDict = [NSMutableDictionary dictionaryWithDictionary:aDict];
        }
        else
        {
            _curDict = [[NSMutableDictionary alloc] initWithCapacity:1];
        }
    }
    
    return self;
}


- (void)setGain:(NSString *)aGain
{
    _curDict[@"gain"] = [NSString safeGet_xcy:aGain];
}
- (void)setFreq:(NSString *)aFreq
{
    _curDict[@"freq"] = [NSString safeGet_xcy:aFreq];
}
- (void)setQStr:(NSString *)qStr
{
    _curDict[@"q"] = [NSString safeGet_xcy:qStr];
}

- (NSString *)getGain
{
    NSString *str = _curDict[@"gain"];
    
    return [NSString safeGet_xcy:str];
}

- (NSString *)getFreq
{
    NSString *str = _curDict[@"freq"];
    
    return [NSString safeGet_xcy:str];
}
- (NSString *)getQ
{
    NSString *str = _curDict[@"q"];
    
    return [NSString safeGet_xcy:str];
}


- (NSDictionary *)getParamDict
{
    return _curDict;
}
@end
