//
//  XCYOTASettingViewController.h
//  XCYBlueBox
//
//  Created by zhouaitao on 2017/8/19.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYBaseViewController.h"
#import "XCYOTASettingMainViewEventDelegate.h"

@interface XCYOTASettingViewController : XCYBaseViewController


- (void)setEventDelegate:(id<XCYOTASettingMainViewEventDelegate>)aDelegate;
@end
