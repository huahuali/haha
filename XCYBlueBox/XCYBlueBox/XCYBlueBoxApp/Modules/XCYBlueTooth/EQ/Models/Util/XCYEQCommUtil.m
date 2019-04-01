//
//  XCYEQCommUtil.m
//  XCYBlueBox
//
//  Created by XCY on 2017/4/8.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYEQCommUtil.h"

@implementation XCYEQCommUtil

+ (BOOL)isVaildNumber:(NSString *)string
{
    NSString *allowCharacters = @"0123456789-.";
    NSCharacterSet *setOfnonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:allowCharacters] invertedSet];
    if ([string stringByTrimmingCharactersInSet:setOfnonNumberSet].length > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


//IIR_CFG_T audio_eq_iir_cfg = {
//    .gain0 = -4,
//    . gain1= -4,
//    .num = 5,
//    .param = {
//        {0.0,   50.0,   0.7},
//        {0.0,   250.0,  0.7},
//        {0.0,   1000.0, 0.7},
//        {12.0,   4000.0, 0.7},
//        {12.0,   8000.0, 0.7}
//    }
//};
+ (NSData *)getDisableData
{
    NSMutableData *fullData = [[NSMutableData alloc] initWithCapacity:1];
    
    float leftGainf = -4;
    NSData *leftGainData = [NSData dataWithBytes:&leftGainf length:sizeof(float)];
    [fullData appendData:leftGainData];
    
    float rightGainf = -4;
    NSData *rightGainData = [NSData dataWithBytes:&rightGainf length:sizeof(float)];
    [fullData appendData:rightGainData];
    
    int num = 5;
    NSData *numData = [NSData dataWithBytes:&num length:sizeof(int)];
    [fullData appendData:numData];
    
    
    //IIR_PARAM_T 1
    NSData *paramData = [XCYEQCommUtil p_getIIRPARAMDataWithG:0.0 F:50.0 Q:0.7];
    [fullData appendData:paramData];
    
    
    //IIR_PARAM_T 2
    paramData = [XCYEQCommUtil p_getIIRPARAMDataWithG:0.0 F:250.0 Q:0.7];
    [fullData appendData:paramData];
    
    //IIR_PARAM_T 3
    paramData = [XCYEQCommUtil p_getIIRPARAMDataWithG:0.0 F:1000.0 Q:0.7];
    [fullData appendData:paramData];
    
    //IIR_PARAM_T 4
    paramData = [XCYEQCommUtil p_getIIRPARAMDataWithG:12.0 F:4000.0 Q:0.7];
    [fullData appendData:paramData];
    
    //IIR_PARAM_T 5
    paramData = [XCYEQCommUtil p_getIIRPARAMDataWithG:12.0 F:8000.0 Q:0.7];
    [fullData appendData:paramData];
    
 
    return fullData;
}



+ (NSData *)p_getIIRPARAMDataWithG:(float)g F:(float)f Q:(float)q
{
    NSMutableData *fullData = [[NSMutableData alloc] initWithCapacity:1];
    NSData *gData = [NSData dataWithBytes:&g length:sizeof(float)];
    [fullData appendData:gData];
    NSData *fData = [NSData dataWithBytes:&f length:sizeof(float)];
    [fullData appendData:fData];
   
    NSData *qData = [NSData dataWithBytes:&q length:sizeof(float)];
    [fullData appendData:qData];

    return fullData;
}
@end
