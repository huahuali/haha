//
//  XCYOTASettingMainViewEventDelegate.h
//  XCYBlueBox
//
//  Created by zhouaitao on 2017/8/20.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCYOTASettingDataDo.h"

@protocol XCYOTASettingMainViewEventDelegate <NSObject>

@required

- (void)okBtnPressedWithData:(XCYOTASettingDataDo *)aData;

- (void)cancelButtonPressed;

@end
