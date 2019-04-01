//
//  XCYEQViewController.h
//  XCYBlueBox
//
//  Created by XCY on 2017/4/8.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYBaseViewController.h"
#import "XCYEQViewEventDelegate.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface XCYEQViewController : XCYBaseViewController


@property (weak, nonatomic) id<XCYEQViewEventDelegate> eventDelegate;

- (void)curentPeripheral:(CBPeripheral *)peripheral;

@end
