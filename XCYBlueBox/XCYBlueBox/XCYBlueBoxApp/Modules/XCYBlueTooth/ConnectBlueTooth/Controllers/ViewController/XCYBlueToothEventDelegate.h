//
//  XCYBlueToothEventDelegate.h
//  XCYBlueBox
//
//  Created by XCY on 2017/4/23.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol XCYBlueToothEventDelegate <NSObject>


@required

- (void)userChoicePeripheral:(CBPeripheral *)aPeripheral;
@end
