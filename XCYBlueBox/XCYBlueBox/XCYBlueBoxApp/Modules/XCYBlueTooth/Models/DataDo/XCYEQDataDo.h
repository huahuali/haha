//
//  XCYEQDataDo.h
//  XCYBlueBox
//
//  Created by XCY on 2017/4/10.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCYEQParamDataDo.h"

@interface XCYEQDataDo : NSObject


- (instancetype)initWithDict:(NSDictionary *)aDict;

- (void)setEqSaveName:(NSString *)saveName;

- (void)setLeftGain:(NSString *)leftGain;
- (void)setRightGain:(NSString *)rightGain;
- (void)setParamDataList:(NSArray<XCYEQParamDataDo *> *)paramDataList;


- (NSString *)getEqSaveName;

- (NSString *)getLeftGain;
- (NSString *)getRightGain;
- (NSArray<XCYEQParamDataDo *> *)getParamDataList;

- (NSDictionary *)getDataDict;
@end
