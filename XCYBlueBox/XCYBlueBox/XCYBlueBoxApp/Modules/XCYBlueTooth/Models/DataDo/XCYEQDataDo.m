//
//  XCYEQDataDo.m
//  XCYBlueBox
//
//  Created by XCY on 2017/4/10.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYEQDataDo.h"

@interface XCYEQDataDo ()

@property (strong, nonatomic) NSMutableDictionary *curDict;

@end

@implementation XCYEQDataDo

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
    }
    
    return self;
}

- (void)setEqSaveName:(NSString *)saveName
{
    _curDict[@"eqSaveName"] = [NSString safeGet_xcy:saveName];
}

- (void)setLeftGain:(NSString *)leftGain
{
    _curDict[@"leftGain"] = [NSString safeGet_xcy:leftGain];
}
- (void)setRightGain:(NSString *)rightGain
{
    _curDict[@"rightGain"] = [NSString safeGet_xcy:rightGain];
}

- (void)setParamDataList:(NSArray<XCYEQParamDataDo *> *)paramDataList
{
    _curDict[@"paramNum"] = [NSString stringWithFormat:@"%ld",(unsigned long)paramDataList.count];
    if (paramDataList.count == 0) {
        return;
    }
    
    
    NSMutableArray *dataList = [[NSMutableArray alloc] initWithCapacity:1];
    for (XCYEQParamDataDo *dataDo in paramDataList) {
        
        NSDictionary *dict = [dataDo getParamDict];
        [dataList addObject:dict];
    }

    _curDict[@"paramData"] = dataList;
}

- (NSString *)getEqSaveName
{
    NSString *str = _curDict[@"eqSaveName"];
    
    return [NSString safeGet_xcy:str];
}

- (NSString *)getLeftGain
{
    NSString *str = _curDict[@"leftGain"];
    
    return [NSString safeGet_xcy:str];
}

- (NSString *)getRightGain
{
    NSString *str = _curDict[@"rightGain"];
    
    return [NSString safeGet_xcy:str];
}
- (NSArray<XCYEQParamDataDo *> *)getParamDataList
{
    NSArray *dataList = _curDict[@"paramData"];
    
    NSMutableArray *paramDataArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (NSDictionary *dict in dataList) {
        
        XCYEQParamDataDo *dataDo = [[XCYEQParamDataDo alloc] initWithDict:dict];
        [paramDataArray addObject:dataDo];
    }
    
    return paramDataArray;
}

- (NSDictionary *)getDataDict
{
    return _curDict;
}

@end
