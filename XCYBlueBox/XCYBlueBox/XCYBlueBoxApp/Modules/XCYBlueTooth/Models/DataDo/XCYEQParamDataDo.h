//
//  XCYEQParamDataDo.h
//  XCYBlueBox
//
//  Created by XCY on 2017/4/10.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCYEQParamDataDo : NSObject

- (instancetype)initWithDict:(NSDictionary *)aDict;


- (void)setGain:(NSString *)aGain;
- (void)setFreq:(NSString *)aFreq;
- (void)setQStr:(NSString *)qStr;

- (NSString *)getGain;
- (NSString *)getFreq;
- (NSString *)getQ;

- (NSDictionary *)getParamDict;
@end
