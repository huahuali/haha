//
//  LYTimeTool.m
//  MusicPlayer
//
//  Created by Y Liu on 15/12/21.
//  Copyright © 2015年 CoderYLiu. All rights reserved.
//

#import "LYTimeTool.h"

@implementation LYTimeTool

+ (NSString *)getFormatTimeWithTimeInterval:(NSTimeInterval)timeInterval
{
    NSInteger min = timeInterval / 60;
    NSInteger sec = (NSInteger)timeInterval % 60;
    return [NSString stringWithFormat:@"%02zd:%02zd", min, sec];
}

+ (NSTimeInterval)getTimeIntervalWithFormatTime:(NSString *)format
{
    NSArray *minAsec = [format componentsSeparatedByString:@":"];
    
    NSString *min = [minAsec firstObject];
    NSString *sec = [minAsec lastObject];
    
    return min.intValue * 60 + sec.floatValue;
}

@end
