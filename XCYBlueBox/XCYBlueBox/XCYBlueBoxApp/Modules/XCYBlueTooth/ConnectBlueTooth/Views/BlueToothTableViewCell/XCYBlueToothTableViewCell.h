//
//  XCYBlueToothTableViewCell.h
//  XCYBlueBox
//
//  Created by XCY on 2017/4/7.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCYBaseTableViewCell.h"

@interface XCYBlueToothTableViewCell : XCYBaseTableViewCell


- (void)setBLEName:(NSString *)name;


/**
 There are several services for setting the current device

 @param serviceNum nsstring
 */
- (void)setBLEServiceNumber:(NSInteger)serviceNum;


/**
 Set the device wifi intensity, the maximum is 100

 @param strength Device wifi intensity
 */
- (void)setWifiStrength:(NSInteger)strength;


@end
