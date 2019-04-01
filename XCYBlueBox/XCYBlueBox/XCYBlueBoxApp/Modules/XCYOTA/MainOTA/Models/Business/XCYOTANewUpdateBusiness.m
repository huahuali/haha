//
//  XCYOTANewUpdateBusiness.m
//  XCYBlueBox
//
//  Created by zhouaitao on 2017/7/18.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYOTANewUpdateBusiness.h"
#import "XCYOTABusiness.h"
#import "XCYUISystemAlertServer.h"

@interface XCYOTANewUpdateBusiness ()

@property (weak, nonatomic) id<XCYOTAUpdateEventDelegate> curDelegate;
@property (strong, nonatomic) XCYOTABusiness *otaBusiness;

@property (strong, nonatomic) NSData *curTotalData; //总数据
@property (strong, nonatomic) NSMutableData *crc32Data;//crc32验证数据包
@property (strong, nonatomic) NSMutableData *curSendData;//当前已发送数据包
@property (assign, nonatomic) NSUInteger eachDataMaxLength;//单条数据长度
@property (strong, nonatomic) NSMutableData *curReSendData;//当前已重发的数据包

@property (strong, nonatomic) CBPeripheral *curPeripheral;

@property (strong, nonatomic) NSData *otaSettingData;//otaSetting总数据包
@property (strong, nonatomic) NSMutableData *curOtaSetSendData;//otaSetting已发送的数据包

@property (assign, nonatomic) NSUInteger breakPointLength; // 上次breakPoint长度

@property (assign, nonatomic) BOOL isSecondLap;

@property (assign, nonatomic) NSUInteger currentVersionType;

@end

@implementation XCYOTANewUpdateBusiness

#pragma mark - public
- (void)setViewDelegate:(id<XCYOTAUpdateEventDelegate>)aDelegate
{
    _curDelegate = aDelegate;
}
- (void)initResource
{
    _curTotalData = nil;
    _crc32Data = [[NSMutableData alloc] initWithCapacity:1];
    _curSendData = [[NSMutableData alloc] initWithCapacity:1];
    _curReSendData = [[NSMutableData alloc] initWithCapacity:1];
    _curOtaSetSendData = [[NSMutableData alloc] initWithCapacity:1];
    
    _curPeripheral = nil;
    _otaSettingData = nil;
    _eachDataMaxLength = 0;
//    _breakPointLength = 0;
}

- (void)setSecondLap:(BOOL)flag {
    self.isSecondLap = flag; // default is NO
}

- (void)setTotalSendData:(NSData *)totalData
{
    _curTotalData = totalData;
}

- (void)setOTASettgingData:(NSData *)aData
{
    _otaSettingData = aData;
}

- (void)setMaxSendDataLength:(NSUInteger)aMax
{
    _eachDataMaxLength = aMax;
}

- (void)setMaxCurrentVersionType:(NSUInteger)currentVersionType {
    _currentVersionType = currentVersionType;
}

- (void)setMaxBreakPointLength:(NSUInteger)length {
    _breakPointLength = length;
}

- (void)setUpdatePeripheral:(CBPeripheral *)aPeripheral
{
    _curPeripheral = aPeripheral;
}

- (void)otaUpdateStart
{
//    NSData *subdata = [self p_getSubData];
//    [self p_sendOtaData:subdata];
    //先发送配置信息
    [self p_sendOTASettingData];
}

#pragma mark - private
- (void)p_sendOTASettingData{

    BOOL isLast = NO;
    NSInteger length = _eachDataMaxLength;
    if (_curOtaSetSendData.length+length>= _otaSettingData.length) {
        
        length = _otaSettingData.length - _curOtaSetSendData.length;
        isLast = YES;
    }
    
    NSData *subData = [_otaSettingData subdataWithRange:NSMakeRange(_curOtaSetSendData.length, length)];
    [_curOtaSetSendData appendData:subData];
    NSData *paddingData = [@"86" dataFromHexString_xcy];
    NSMutableData *sendData = [[NSMutableData alloc] initWithData:paddingData];
    [sendData appendData:subData];
    
    [self p_addTimeoutNotification];
    
    __weak __typeof(self)weakSelf = self;
    if (!isLast) {
        
        //无需接收回应
        [self.otaBusiness writeToPeripheralWithoutNotify:_curPeripheral valueData:sendData complectionHandler:^(CBPeripheral *peripheral, CBCharacteristic *charactic, NSError *error) {
            
            [weakSelf p_removeTimeoutNotification];
            [weakSelf p_sendOTASettingData];
        }];
    }
    else{
        
        //最后一个包需要接收回调信息
        [self.otaBusiness writeToPeripheral:_curPeripheral curPeripheralType:XCYOTAPeripheralType_OTA valueData:sendData complectionHandler:^(CBPeripheral *peripheral, CBCharacteristic *charactic, NSError *error) {
            
            [weakSelf p_removeTimeoutNotification];
            NSData *data = charactic.value;
            if (!data) {
                if ([weakSelf.curDelegate respondsToSelector:@selector(otaUpdateFaildWithMsg:)]) {
                    
                    NSString *msg = kWeXLocalizedString(@"XCYOTANewUpdateBusiness_CRC_CheckFail_Msg", @"");
                    [weakSelf.curDelegate otaUpdateFaildWithMsg:msg];
                }
                
                return ;
            }
            
            NSData *predata = [data subdataWithRange:NSMakeRange(0, 1)];
            NSString *preStr = [NSString stringFromData_cmbc:predata];
            NSData *resultData = [data subdataWithRange:NSMakeRange(1, 1)];
            NSString *resultStr = [NSString stringFromData_cmbc:resultData];
            
            if ([preStr isEqualToString:@"87"]) {
                
                if ([resultStr isEqualToString:@"01"]) {
                    //开始发送OTA数据
                    NSData *subdata = [weakSelf p_getSubData];
                    [weakSelf p_sendOtaData:subdata];
                    return;
                }
                
                if ([weakSelf.curDelegate respondsToSelector:@selector(otaUpdateFaildWithMsg:)]) {
                    
                    NSString *msg = kWeXLocalizedString(@"XCYOTANewUpdateBusiness_OTA_SettingFail_Msg", @"");
                    [weakSelf.curDelegate otaUpdateFaildWithMsg:msg];
                }
            }
        }];
        
    }

    
}



//发送ota数据包
- (void)p_sendOtaData:(NSData *)subData
{
    CGFloat totalLength = _curTotalData.length + _breakPointLength;
    CGFloat percent = (_curSendData.length+_crc32Data.length+_breakPointLength)/totalLength;
//    CGFloat percent_breakPoint = _breakPointLength/totalLength;
    
    if ([_curDelegate respondsToSelector:@selector(setProgress:animated:)]) {
        //设置进度条
        [_curDelegate setProgress:percent animated:YES];
    }
    
    [self p_addTimeoutNotification];
    
    __weak __typeof(self)weakSelf = self;
    [self.otaBusiness writeToPeripheralWithoutNotify:_curPeripheral valueData:subData complectionHandler:^(CBPeripheral *peripheral, CBCharacteristic *charactic, NSError *error) {
        
        [weakSelf p_removeTimeoutNotification];
        
        //最后一个单元包已发送
        if (_curSendData.length+_crc32Data.length == _curTotalData.length) {
            
            [weakSelf p_sendCRCDataCheck];
            return ;
        }
        
        double percentN = (double)_crc32Data.length/((double)_curTotalData.length+(double)_breakPointLength);
        
        /*
         percentN = 0.02953756700281639
         _crc32Data.length = 32512bytes
         */
        if ((percentN>=0.01) && (_crc32Data.length%4 == 0) && (_crc32Data.length%256 == 0)) {
            //当CRC32数据包大于1%时，需要对整个crc32数据包校验，通过继续，不通过重发,长度是256的整数倍
            [self p_sendCRCDataCheck];
        }
        else{
            
            //没有达到继续发送
            NSData *data = [weakSelf p_getSubData];
            [weakSelf p_sendOtaData:data];
        }
    }];
}

//当CRC32数据包大于1%时，需要对整个crc32数据包校验，通过继续，不通过重发
- (void)p_sendCRCDataCheck
{
    NSMutableData *totalData = [[NSMutableData alloc] initWithCapacity:1];
    NSData *pre = [@"8242455354" dataFromHexString_xcy];
    [totalData appendData:pre];
    
    int32_t crc32 = [_crc32Data CRC32Value_xcy];
    NSData *crc32Data = [NSData dataWithBytes:&crc32 length:4];
    [totalData appendData:crc32Data];
    
    [self p_addTimeoutNotification];
    
    __weak __typeof(self)weakSelf = self;
    [self.otaBusiness writeToPeripheral:_curPeripheral curPeripheralType:XCYOTAPeripheralType_OTA valueData:totalData complectionHandler:^(CBPeripheral *peripheral, CBCharacteristic *charactic, NSError *error) {
       
        [weakSelf p_removeTimeoutNotification];
        
        NSData *data = charactic.value;
        if (!data) {
            if ([_curDelegate respondsToSelector:@selector(otaUpdateFaildWithMsg:)]) {
                
                NSString *msg = kWeXLocalizedString(@"XCYOTANewUpdateBusiness_CRC_CheckFail_Msg", @"");
                [_curDelegate otaUpdateFaildWithMsg:msg];
            }
            
            return ;
        }
        
        NSData *predata = [data subdataWithRange:NSMakeRange(0, 1)];
        NSString *preStr = [NSString stringFromData_cmbc:predata];
        
        NSData *resultData = [data subdataWithRange:NSMakeRange(1, 1)];
        NSString *resultStr = [NSString stringFromData_cmbc:resultData];

        NSLog(@"max preStr resultStr:%@%@", preStr, resultStr);
        //不是升级完成，也不是校验标识，则错误
        if (![preStr isEqualToString:@"83"]) {
            
            if ([_curDelegate respondsToSelector:@selector(otaUpdateFaildWithMsg:)]) {
                
                NSString *dataStr = [NSString stringFromData_cmbc:data];
                NSString *msg = [NSString stringWithFormat:kWeXLocalizedString(@"XCYOTANewUpdateBusiness_CRC_CheckFail_Msg2", @""), dataStr];
                
                [_curDelegate otaUpdateFaildWithMsg:msg];
            }
            
            return;
        }
        
        //校验通过，继续发下一组数据
        if ([resultStr isEqualToString:@"01"]) {
            
            [weakSelf.curSendData appendData:_crc32Data];
            _crc32Data = [[NSMutableData alloc] initWithCapacity:1];
            
            //最后一组已发完，发送"88"数据做最后确认
            if (weakSelf.curSendData.length == weakSelf.curTotalData.length) {
                
                [weakSelf p_sendSuccessedCheck];

                return;
            }
            
            NSData *subData = [weakSelf p_getSubData];
            [weakSelf p_sendOtaData:subData];
            
            return;
        }
        
        _curReSendData = [[NSMutableData alloc] initWithCapacity:1];
        [weakSelf p_sendLastData];
    }];
}

//重发上一次的包
- (void)p_sendLastData
{
    NSData *subData = nil;
    if (_curReSendData.length+_eachDataMaxLength > _crc32Data.length) {
        
        subData = [_crc32Data subdataWithRange:NSMakeRange(_curReSendData.length, _crc32Data.length - _curReSendData.length)];
    }
    else
    {
        subData = [_crc32Data subdataWithRange:NSMakeRange(_curReSendData.length, _eachDataMaxLength)];
    }
    
    [_curReSendData appendData:subData];
    
    NSMutableData *totalData = [[NSMutableData alloc] initWithCapacity:1];
    NSData *pre = [@"85" dataFromHexString_xcy];
    [totalData appendData:pre];
    [totalData appendData:subData];
    NSLog(@"totalData length %lu", (unsigned long)totalData.length);
    
    [self p_addTimeoutNotification];
    
    __weak __typeof(self)weakSelf = self;
    
    [self.otaBusiness writeToPeripheralWithoutNotify:_curPeripheral valueData:totalData complectionHandler:^(CBPeripheral *peripheral, CBCharacteristic *charactic, NSError *error) {
        
        [weakSelf p_removeTimeoutNotification];
        
        if (_curReSendData.length == _crc32Data.length) {
            
            [weakSelf p_sendCRCDataCheck];
            return ;
        }
        
        [weakSelf p_sendLastData];
    }];
}

//发送"88"给设备，最后确认是否成功
- (void)p_sendSuccessedCheck
{
    [self p_addTimeoutNotification];
    
    NSData *data = [@"88" dataFromHexString_xcy];
    __weak __typeof(self)weakSelf = self;
    [self.otaBusiness writeToPeripheral:_curPeripheral curPeripheralType:XCYOTAPeripheralType_OTA valueData:data complectionHandler:^(CBPeripheral *peripheral, CBCharacteristic *charactic, NSError *error){
        
        [weakSelf p_removeTimeoutNotification];
        
        NSData *data = charactic.value;
        if (!data) {
            if ([_curDelegate respondsToSelector:@selector(otaUpdateFaildWithMsg:)]) {
                
                NSString *msg = kWeXLocalizedString(@"XCYOTANewUpdateBusiness_UpdateFile_LastPacketFail_Msg", @"");
                [_curDelegate otaUpdateFaildWithMsg:msg];
            }
            
            return ;
        }
        
        NSData *predata = [data subdataWithRange:NSMakeRange(0, 1)];
        NSString *preStr = [NSString stringFromData_cmbc:predata];
        
        NSData *resultData = [data subdataWithRange:NSMakeRange(1, 1)];
        NSString *resultStr = [NSString stringFromData_cmbc:resultData];
        
        //如果校验通过之后，并且数据已全部发送完，此时设备会再次发送一条信息，标识升级完成
        if ([preStr isEqualToString:@"84"]) {
            
            if ([resultStr isEqualToString:@"01"]) {
                
                /*
                 BesFileSelectViewType_None = 0,
                 BesFileSelectViewType_Same,
                 BesFileSelectViewType_No_Same,
                 BesFileSelectViewType_Left,
                 BesFileSelectViewType_Right,
                 BesFileSelectViewType_Stereo,
                 */
                // 如果是二对二升级，92协议发最后发（保证92只发一次）
                if (_currentVersionType == 2 && self.isSecondLap == NO) {
                    
                    if ([_curDelegate respondsToSelector:@selector(otaUpdateSuccessd:)]) {
                        
                        [_curDelegate otaUpdateSuccessd:self.isSecondLap];
                    }
                    return;
                }
                // 旧协议，跳过92
                if (_currentVersionType == 0) {
                    
                    if ([_curDelegate respondsToSelector:@selector(otaUpdateSuccessd:)]) {
                        
                        [_curDelegate otaUpdateSuccessd:self.isSecondLap];
                    }
                    return;
                    
                }
                
                [self getImageOverWritingConfirmation];
                
            }
            else{
                if ([_curDelegate respondsToSelector:@selector(otaUpdateFaildWithMsg:)]) {
                    
                    [_curDelegate otaUpdateFaildWithMsg:kWeXLocalizedString(@"XCYOTANewUpdateBusiness_UpdateFile_Fail_Msg", @"")];
                }
            }
            
//            return;
        }
    
    }];
}

// 92数据, 确认最终覆盖 (之前逻辑发送88回复8401, 现在增加了92) by max
- (void)getImageOverWritingConfirmation
{
    NSString *dataStr = @"9242455354";
    NSMutableData *fullData = [[NSMutableData alloc] initWithCapacity:1];
    [fullData appendData:[dataStr dataFromHexString_xcy]];
    
    NSData *currentData = fullData;
    
    [self.otaBusiness writeToPeripheral:_curPeripheral curPeripheralType:XCYOTAPeripheralType_OTA valueData:currentData complectionHandler:^(CBPeripheral *peripheral, CBCharacteristic *charactic, NSError *error) {
        
        NSData *typeData = charactic.value;
        NSString *typeStr = [NSString stringFromData_cmbc:typeData];
        NSLog(@"%@", typeStr);
        
        NSString *prefixStr = [typeStr substringWithRange:NSMakeRange(0, 2)];
        NSString *resultStr = [typeStr substringWithRange:NSMakeRange(2, 2)];
        
        if ([prefixStr isEqualToString:@"93"]) {
            if ([resultStr isEqualToString:@"01"]) {
                // success
                if ([_curDelegate respondsToSelector:@selector(otaUpdateSuccessd:)]) {
                    
                    [_curDelegate otaUpdateSuccessd:self.isSecondLap];
                }
                
            } else {
                // fail
                if ([_curDelegate respondsToSelector:@selector(otaUpdateFaildWithMsg:)]) {
                    
                    [_curDelegate otaUpdateFaildWithMsg:kWeXLocalizedString(@"XCYOTANewUpdateBusiness_UpdateFile_Fail_Msg", @"")];
                }
            }
        }
    }];
}

- (void)max_disConnectPeripheral {
    [self.otaBusiness disConnectPeripheral:_curPeripheral notifyBlock:nil];
}

- (NSData *)p_getSubData
{
    // _crc32Data.length 508
    NSInteger index = _curSendData.length + _crc32Data.length;
    
    NSData *subData = nil;
    if (index+_eachDataMaxLength > _curTotalData.length) {
        
        subData = [_curTotalData subdataWithRange:NSMakeRange(index, _curTotalData.length - index)];
    }
    else{
        subData = [_curTotalData subdataWithRange:NSMakeRange(index, _eachDataMaxLength)];
    }
    NSLog(@"subData:\n%@", subData);
    
    [_crc32Data appendData:subData];
    
    NSMutableData *totalData = [[NSMutableData alloc] initWithCapacity:1];
    NSData *pre = [@"85" dataFromHexString_xcy];
    [totalData appendData:pre];
    [totalData appendData:subData];
    
    return totalData;
}

//在OTA过程中，APP等待回复的超时时间为5秒，超时时间到达还未收到回复，则认为升级失败
- (void)p_addTimeoutNotification
{
    [self performSelector:@selector(p_updatTimeout) withObject:nil afterDelay:5.0];
}

- (void)p_removeTimeoutNotification
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(p_updatTimeout) object:nil];
}

- (void)p_updatTimeout
{
    if ([_curDelegate respondsToSelector:@selector(otaUpdateFaildWithMsg:)]) {
        
        [_curDelegate otaUpdateFaildWithMsg:kWeXLocalizedString(@"XCYOTANewUpdateBusiness_Timeout_UpdateFail_Msg", @"")];
    }
}

#pragma mark - getter setter
- (XCYOTABusiness *)otaBusiness
{
    if (_otaBusiness) {
        return _otaBusiness;
    }
    
    _otaBusiness = [[XCYOTABusiness alloc] init];
    
    return _otaBusiness;
}

@end
