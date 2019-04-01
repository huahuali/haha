//
//  XCYEQViewController.m
//  XCYBlueBox
//
//  Created by XCY on 2017/4/8.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYEQViewController.h"
//#import "XCYEQMainView.h"
#import "XCYUISystemAlertServer.h"
#import "XCYEQCommUtil.h"
//#import "XCYEQSaveViewController.h"
//#import "XCYEQLoadListViewController.h"

#import "XCYEQTestBusiness.h"

typedef NS_ENUM(NSInteger, XCYEQ_CMD_TYPE) {

    XCYEQ_CMD_TYPE_NONE = 0,
    XCYEQ_CMD_TYPE_START ,
    XCYEQ_CMD_TYPE_SEND_DATA,
    XCYEQ_CMD_TYPE_STOP,
    XCYEQ_CMD_TYPE_CMD_IIR_EQ

};


@interface XCYEQViewController ()

//当前用户选择的蓝牙设备
@property (strong, nonatomic) CBPeripheral *curPeripheral;
//@property (strong, nonatomic) XCYEQMainView *eqMainView;
@property (strong, nonatomic) XCYEQTestBusiness *eqBusiness;

@property (assign, nonatomic) BOOL bLocked;

@property (assign, nonatomic) XCYEQ_CMD_TYPE nextCMDType;

//已发送的Data长度
@property (assign, nonatomic) NSInteger curIsSendDataLength;
@property (strong, nonatomic) NSData *curSendData;

@property (assign, nonatomic) BOOL bIsError;
@end

@implementation XCYEQViewController
//- (void)dealloc
//{
//    [_eqMainView removeKeyBoardObserver];
//}

- (void)curentPeripheral:(CBPeripheral *)peripheral
{
    _curPeripheral = peripheral;
}

- (void)backToTop
{
    if ([_eventDelegate respondsToSelector:@selector(backToTop)]) {
        
        [_eventDelegate backToTop];
    }
    
    [super backToTop];
}

#pragma mark - XCYEQMainViewEventDelegate
- (void)enablePressed
{
    //当前正在发送
    if ([self p_isLocked]) {
        
        return;
    }
    
    //锁定
    [self p_lock];
    _bIsError = NO;
    
    __weak __typeof(self)weakSelf = self;
    [self p_connectAndDiscoverAllChist:^(BOOL isConnected) {
        
        if (isConnected) {
            
            _nextCMDType = XCYEQ_CMD_TYPE_START;
            _curIsSendDataLength = 0;
            
//            _curSendData = [self.eqMainView getEQFullData];
            
            [self p_writeToPeripheral];
        }
        else
        {
            [weakSelf p_unlock];
        }
        
    }];
}

- (void)disablePressed
{
    //当前正在发送
    if ([self p_isLocked]) {
        
        return;
    }
    
    //锁定
    [self p_lock];
    _bIsError = NO;
    
    
    __weak __typeof(self)weakSelf = self;
    [self p_connectAndDiscoverAllChist:^(BOOL isConnected) {
        
        if (isConnected) {
            
            _nextCMDType = XCYEQ_CMD_TYPE_START;
            _curIsSendDataLength = 0;
            
            _curSendData = [XCYEQCommUtil getDisableData];
            
            [weakSelf p_writeToPeripheral];
        }
        else
        {
            [weakSelf p_unlock];
        }
        
    }];
}

//- (void)savePressed
//{
//    XCYEQSaveViewController *vc = [[XCYEQSaveViewController alloc] init];
//    [vc setSaveData:[_eqMainView getEQFullDataDo]];
//
//    [self.navigationController pushViewController:vc animated:YES];
//}

//- (void)loadPressed
//{
//    XCYEQLoadListViewController *loadVc = [[XCYEQLoadListViewController alloc] init];
//    loadVc.eventDelegate = self;
//
//    [self.navigationController pushViewController:loadVc animated:YES];
//}

#pragma mark - XCYEQLoadListViewEventDelegate
//- (void)currentLoadEQTestData:(XCYEQDataDo *)aDataDo
//{
//    [_eqMainView loadCurEQData:aDataDo];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.mainTitle = @"IIR EQ设置";
//    [self p_addERMainView];
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.eqMainView addKeyBoardObserver];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self.eqMainView removeKeyBoardObserver];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - private
//- (void)p_addERMainView
//{
////    _eqMainView = [XCYEQMainView getEQMainView];
////    _eqMainView.viewEventDelegate = self;
//    CGSize titleSize = XCYTitleBarSize();
//    CGRect frame = CGRectMake(0, titleSize.height, self.view.frame.size.width, self.view.frame.size.height-titleSize.height);
//    _eqMainView.frame = frame;
//
//
//    [self.view addSubview:_eqMainView];
//}

- (void)p_lock
{
    _bLocked = YES;
}

- (void)p_unlock
{
    _bLocked = NO;
}

- (BOOL)p_isLocked
{
    return _bLocked;
}


- (BOOL)p_didConnected
{
    CBPeripheralState state = self.curPeripheral.state;
    if (state == CBPeripheralStateConnected) {
        return YES;
    }
    return NO;
}


- (void)p_connectAndDiscoverAllChist:(void(^)(BOOL isConnected))finished
{
    //如果已经连接并且已经发现chist
    BOOL connected = [self p_didConnected];
    if (connected) {
        if (finished) {
            finished(YES);
            
        }
        
        return;
    }
    __weak __typeof(self)weakSelf = self;
    [self.eqBusiness connectToPeripheral:_curPeripheral
                           finishHandler:^(BOOL isConnected) {
       
        [weakSelf hidenWaitingView];
        
        if (isConnected) {
            
            if (finished) {
                finished(YES);
            }
        }
        else
        {
            id<XCYUISystemAlertInterface> alert = [XCYUISystemAlertServer initSystemAlert];
            
            [alert showSysAlertTitle:@"提示" msg:@"无法向此设备发送配置" cancelButtonTitle:@"确定" cancelBlock:nil otherButtonTitle:nil otherBlock:nil];
            
            if (finished) {
                finished(NO);
            }
        }
        
    }];
}


- (void)p_writeDataToPeripheral:(NSData *)data
{
    
    if (_bIsError) {
        return;
    }
    __weak __typeof(self)weakSelf = self;
    [self.eqBusiness writeToPeripheral:_curPeripheral valueData:data complectionHandler:^(CBPeripheral *peripheral, CBCharacteristic *charactic, NSError *error) {
        
        if (error && !_bIsError) {
            
            [weakSelf p_showErrorAlert];
            _bIsError = YES;//发生错误
            [weakSelf p_unlock];
            return ;
        }
        
        
        //说明是最后一条数据发送，结束
        if (_nextCMDType == XCYEQ_CMD_TYPE_NONE) {
            
            [weakSelf p_unlock];
            return;
        }
        
        [weakSelf p_writeToPeripheral];
    }];
    
    //说明是最后一条数据发送，结束
    if (_nextCMDType == XCYEQ_CMD_TYPE_NONE) {
        
        [weakSelf p_unlock];
    }
}

- (void)p_writeStartCmdToPeripheral
{
     _nextCMDType = XCYEQ_CMD_TYPE_SEND_DATA;
    
    NSString *CMDStr = @"01000000";
    NSData *data = [CMDStr dataFromHexString_xcy];
    
    [self p_writeDataToPeripheral:data];
}

- (void)p_writeIIRDataToPeripheral
{
    NSString *firstStr = @"0000";
    NSMutableData *fullData = [[NSMutableData alloc] initWithCapacity:1];
    [fullData appendData:[firstStr dataFromHexString_xcy]];
    
    _nextCMDType = XCYEQ_CMD_TYPE_SEND_DATA;
    NSInteger length = 18;
    if ((_curIsSendDataLength+length) >= _curSendData.length) {
        
        length = _curSendData.length - _curIsSendDataLength;
        _nextCMDType = XCYEQ_CMD_TYPE_STOP;
    }
    
    NSData *subData = [_curSendData subdataWithRange:NSMakeRange(_curIsSendDataLength, length)];
    [fullData appendData:subData];
    _curIsSendDataLength += length;
    
    [self p_writeDataToPeripheral:fullData];

}

- (void)p_writeStopCmdToPeripheral
{
     _nextCMDType = XCYEQ_CMD_TYPE_CMD_IIR_EQ;
    
    NSString *CMDStr = @"02000000";
    NSData *data = [CMDStr dataFromHexString_xcy];
    [self p_writeDataToPeripheral:data];
}

- (void)p_writeIIR_EQToPeripheral
{
    _nextCMDType = XCYEQ_CMD_TYPE_NONE;//结束
    
    NSString *CMDStr = @"06000000";
    NSData *data = [CMDStr dataFromHexString_xcy];
    [self p_writeDataToPeripheral:data];
}


- (void)p_writeToPeripheral
{
    switch (_nextCMDType) {
        case XCYEQ_CMD_TYPE_START:
            
            [self p_writeStartCmdToPeripheral];
            break;
            
        case XCYEQ_CMD_TYPE_SEND_DATA:
            
            [self p_writeIIRDataToPeripheral];
            break;
            
        case XCYEQ_CMD_TYPE_STOP:
            [self p_writeStopCmdToPeripheral];
            break;
            
        case XCYEQ_CMD_TYPE_CMD_IIR_EQ:
            [self p_writeIIR_EQToPeripheral];
            break;
            
        default:
            break;
    }

}

- (void)p_showErrorAlert
{
    id<XCYUISystemAlertInterface> alert = [XCYUISystemAlertServer initSystemAlert];
    
    [alert showSysAlertTitle:@"提示" msg:@"指令发送失败" cancelButtonTitle:@"确定" cancelBlock:nil otherButtonTitle:nil otherBlock:nil];
}

- (void)p_showSuccessAlert
{
    id<XCYUISystemAlertInterface> alert = [XCYUISystemAlertServer initSystemAlert];
    
    [alert showSysAlertTitle:@"提示" msg:@"指令发送成功" cancelButtonTitle:@"确定" cancelBlock:nil otherButtonTitle:nil otherBlock:nil];
}

#pragma mark - getter or setter
- (XCYEQTestBusiness *)eqBusiness
{
    if (_eqBusiness) {
        
        return _eqBusiness;
    }
    
    _eqBusiness = [[XCYEQTestBusiness alloc] init];
    return _eqBusiness;
}
@end
