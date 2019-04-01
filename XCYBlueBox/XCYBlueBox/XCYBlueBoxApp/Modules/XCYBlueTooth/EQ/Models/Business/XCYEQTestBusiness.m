//
//  XCYEQTestBusiness.m
//  XCYBlueBox
//
//  Created by XCY on 2017/5/12.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYEQTestBusiness.h"
#import "XCYBlueToothCentralManager.h"

@interface XCYEQTestBusiness ()

@property (strong, nonatomic) XCYBlueToothCentralManager *centralManager;

@end

@implementation XCYEQTestBusiness

- (void)connectToPeripheral:(CBPeripheral *)peripheral
              finishHandler:(void(^)(BOOL isConnected))finishHandler
{
    
    if (!peripheral) {
        if (finishHandler) {
            finishHandler(NO);
        }
    }
    
    __weak __typeof(self)weakSelf = self;
    [self.centralManager connectPeripheral:peripheral options:nil compeletionHandler:^(CBPeripheral * _Nonnull peripheral, NSError * _Nonnull error) {
        
        if (error) {
            if (finishHandler) {
                finishHandler(NO);
            }
            
            return ;
        }
        
        [weakSelf p_discoverServices:peripheral complectionHandler:finishHandler];
    }];
}


- (void)writeToPeripheral:(CBPeripheral *)peripheral
                valueData:(NSData *)valueData
       complectionHandler:(void(^)(CBPeripheral *peripheral, CBCharacteristic *charactic, NSError *error))finishHandler
{
    CBUUID *uuid = [self p_getCharacteristicsUUID];
    [self.centralManager writeToPeripheral:peripheral characteristicsUUID:uuid value:valueData compeletionHandler:finishHandler];
}

#pragma mark - private
- (void)p_discoverServices:(CBPeripheral *)peripheral
        complectionHandler:(void(^)(BOOL isConnected))finishHandler
{
    __weak __typeof(self)weakSelf = self;
    
    NSArray *uuids = [self p_getUUIDForPeripheralService];
    [weakSelf.centralManager discoverServices:uuids inPeripheral:peripheral compeletionHandler:^(CBPeripheral * _Nonnull peripheral, NSError * _Nonnull error) {
        
        
        if (error) {
            
            if (finishHandler) {
                finishHandler(NO);
            }
            return;
        }
        NSArray<CBService *> *services = peripheral.services;
        for (CBService *service in services) {
            
            [weakSelf p_discoverCharacteristicsForService:service inPeripheral:peripheral complectionHandler:finishHandler];
        }
        
    }];

}

- (void)p_discoverCharacteristicsForService:(CBService *)service
                               inPeripheral:(CBPeripheral *)peripheral
                         complectionHandler:(void(^)(BOOL isConnected))finishHandler
{
    
    __weak __typeof(self)weakSelf = self;
    CBUUID *uuid = [weakSelf p_getCharacteristicsUUID];
    NSArray *uuids = [NSArray arrayWithObjects:uuid, nil];
    [weakSelf.centralManager discoverCharacteristics:uuids forService:service inPeripheral:peripheral compeletionHandler:^(CBPeripheral * _Nonnull peripheral, CBService * _Nonnull service, NSError * _Nonnull error) {
        if (error) {
            if (finishHandler) {
                finishHandler(NO);
            }
            return;
        }
        
        if (finishHandler) {
            finishHandler(YES);
        }
    }];
}











//过滤当前设备的service
- (NSArray<CBUUID*> *)p_getUUIDForPeripheralService
{
    NSString *dataStr = @"01000100000010008000009078563412";
    NSData *uuidData = [dataStr dataFromHexString_xcy];
    CBUUID *uuid = [CBUUID UUIDWithData:uuidData];
    
    
    NSArray *array = [NSArray arrayWithObjects:uuid, nil];
    
    return array;
}

- (CBUUID *)p_getCharacteristicsUUID
{
    NSString *dataStr = @"03000300000010008000009278563412";
    NSData *uuidData = [dataStr dataFromHexString_xcy];
    CBUUID *uuid = [CBUUID UUIDWithData:uuidData];
    
    return uuid;
}



#pragma mark - getter or setter
- (XCYBlueToothCentralManager *)centralManager
{
    if (_centralManager) {
        
        return _centralManager;
    }
    
    _centralManager = [XCYBlueToothCentralManager shareInstance];
    return _centralManager;
}

@end
