//
//  XCYOTASettingView.h
//  XCYBlueBox
//
//  Created by zhouaitao on 2017/8/19.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCYOTASettingDataDo.h"
#import "XCYOTASettingMainViewEventDelegate.h"

@interface XCYOTASettingMainView : UIView

+ (XCYOTASettingMainView *)getOTASettingView;

- (void)setEventDelegate:(id<XCYOTASettingMainViewEventDelegate>)aDelegate;
@end
