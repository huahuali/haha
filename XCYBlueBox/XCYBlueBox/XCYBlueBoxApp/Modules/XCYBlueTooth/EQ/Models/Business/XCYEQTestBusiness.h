//
//  XCYEQTestBusiness.h
//  XCYBlueBox
//
//  Created by XCY on 2017/5/12.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface XCYEQTestBusiness : NSObject


- (void)connectToPeripheral:(CBPeripheral *)peripheral
              finishHandler:(void(^)(BOOL isConnected))finishHandler;



- (void)writeToPeripheral:(CBPeripheral *)peripheral
                valueData:(NSData *)valueData
       complectionHandler:(void(^)(CBPeripheral *peripheral, CBCharacteristic *charactic, NSError *error))finishHandler;
@end
