//
//  XCYOTAViewController.m
//  XCYBlueBox
//
//  Created by XCY on 2017/4/21.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYOTAViewController.h"
#import "XCYOTAFileListViewController.h"
#import "XCYConnectBlueToothOutgoingFactory.h"
#import "BESHeader.h"

#import "NJKWebViewProgressView.h"
#import "XCYUISystemAlertServer.h"

#import "XCYOTAUpdateEventDelegate.h"
#import "XCYOTAInHouseFactory.h"

#import "XCYOTASettingViewController.h"
#import "BESCurrentVersionType.h"
#import "BesUpdataTypeSelectorView.h"
#import "BesFileSelectView.h"
#import "BesUser.h"

#define Randomcodekey (@"randomCodeStr")

@interface XCYOTAViewController ()
<XCYOTAFileEventDelegate,
XCYBlueToothEventDelegate,
XCYOTAUpdateEventDelegate,
XCYOTASettingMainViewEventDelegate,
BesUpdataTypeSelectorViewDelegate,
BesFileSelectViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *curDevicePromptLabel;
@property (strong, nonatomic) IBOutlet UILabel *curDeviceLabel;
@property (weak, nonatomic) IBOutlet UILabel *curVersionLabel;
@property (strong, nonatomic) IBOutlet UIButton *changeDeviceButton;
@property (weak, nonatomic) IBOutlet UIButton *startConnectingDeviceButton;
@property (strong, nonatomic) IBOutlet UILabel *curUpgradePromptLabel;
@property (strong, nonatomic) IBOutlet UILabel *curUpgradeLabel;
@property (strong, nonatomic) IBOutlet UIButton *choiceFileButton;
@property (strong, nonatomic) IBOutlet UILabel *curUpgradeProgressPromptLabel;
@property (strong, nonatomic) IBOutlet UILabel *curUpgradeProgressLabel;
@property (strong, nonatomic) IBOutlet UIView *curUpgradeProgressView;
@property (strong, nonatomic) IBOutlet UIButton *upgradeButton;

@property (strong, nonatomic) NJKWebViewProgressView *progressView;
@property (strong, nonatomic) XCYOTAFileListViewController *curFileListVc;

@property (strong, nonatomic) XCYOTASettingViewController *otaSettingVc;

@property (strong, nonatomic) XCYBlueToothTableViewController *curBlueListVc;

//@property (copy, nonatomic) NSString *curUpgradeFilePath;
@property (strong, nonatomic) NSString *left_curUpgradeFilePath;
@property (strong, nonatomic) NSString *right_curUpgradeFilePath;
@property (assign, nonatomic) NSInteger index_curUpgradeFil;

@property (strong, nonatomic) NSData *curTotalData;
@property (strong, nonatomic) CBPeripheral *curPeripheral;

@property (strong, nonatomic) XCYOTADataSource *otaDataSource;
@property (strong, nonatomic) XCYOTABusiness *otaBusiness;
@property (strong, nonatomic) id<XCYOTAUpdateBusinessInterface> updateBusiness;


@property (strong, nonatomic) XCYOTASettingDataDo *curSettingData;
@property (assign, nonatomic) XCYOTAPeripheralType curPeripheralType;
@property (strong, nonatomic) NSString *currentVersionStr;
@property (assign, nonatomic) BESCurrentVersionType currentVersionType;
@property (strong, nonatomic) BesUpdataTypeSelectorView *updataTypeSelectorView;

@property (strong, nonatomic) BesFileSelectView *fileSelectView;
@property (assign, nonatomic) BesFileSelectViewType fileType;
@property (assign, nonatomic) BOOL isSecondLap;
@property (assign, nonatomic) NSUInteger value_segment;

@end

@implementation XCYOTAViewController

#pragma mark - BesUpdataTypeSelectorViewDelegate
- (void)buttonClickIndex:(NSInteger)index {
    [self.updataTypeSelectorView removeFromSuperview];
    self.updataTypeSelectorView = nil;
    
    if (index == 3) {
        self.fileType = BesFileSelectViewType_No_Same;
    } else if (index == 0) {
        self.fileType = BesFileSelectViewType_Left;
    } else if (index == 1) {
        self.fileType = BesFileSelectViewType_Right;
    } else if (index == 2) {
        self.fileType = BesFileSelectViewType_Same;
    } else {
        self.fileType = BesFileSelectViewType_None;
    }
    
    [self.view addSubview:self.fileSelectView];
    
    // 选择了升级方式即认为更改了选择路径
    [BesUser sharedUser].selected_left_filePath = @"";
    [BesUser sharedUser].selected_right_filePath = @"";
    [BesUser sharedUser].is_secondLap = NO;
    _curUpgradeLabel.text = @"";
    
    // 初始化随机码
    NSString *randomCodeStr = @"0000000000000000000000000000000000000000000000000000000000000000";
    [[NSUserDefaults standardUserDefaults] setObject:randomCodeStr forKey:Randomcodekey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 缓存升级方式
    [BesUser sharedUser].user_fileType = self.fileType;
}

- (void)backButtonClick {
    [self.updataTypeSelectorView removeFromSuperview];
    self.updataTypeSelectorView = nil;
}

#pragma mark - BesFileSelectViewDelegate
- (void)BesFileSelecButtonClickIndex:(NSInteger)index {
    [self.fileSelectView removeFromSuperview];
    self.fileSelectView = nil;
}

- (void)BesFileSelecBackButtonClick {
    [self.fileSelectView removeFromSuperview];
    self.fileSelectView = nil;
}

// Select upgrade file
- (void)BesUpdataFileSelectedIndex:(NSInteger)index {
    self.index_curUpgradeFil = index;
    [self.navigationController pushViewController:self.curFileListVc animated:YES];
}

#pragma mark - XCYOTAFileEventDelegate
- (void)userChoiceOTAFile:(NSString *)filePath
{
    if (self.fileType == BesFileSelectViewType_No_Same) {
        
        if (self.index_curUpgradeFil == 100) {
            [self.fileSelectView setFirstViewContent:filePath];
            self.left_curUpgradeFilePath = filePath;
            // 缓存选取的路径
            [BesUser sharedUser].selected_left_filePath = filePath;
            
        } else if (self.index_curUpgradeFil == 101) {
            [self.fileSelectView setSecondViewContent:filePath];
            self.right_curUpgradeFilePath = filePath;
            // 缓存选取的路径
            [BesUser sharedUser].selected_right_filePath = filePath;
        }
        
        _curUpgradeLabel.text = [NSString stringWithFormat:kWeXLocalizedString(@"XCYOTAViewController_curUpgradeLabel_text", @""), self.left_curUpgradeFilePath, self.right_curUpgradeFilePath];
        
    } else {
        
        // 旧版本 & stereo 两种情况赋值
        if (self.currentVersionType == BESCurrentVersionType_None) {
           
            self.fileType = BesFileSelectViewType_None;
            [BesUser sharedUser].user_fileType = self.fileType;
            
        } else if (self.currentVersionType == BESCurrentVersionType_Stereo) {
           
            self.fileType = BesFileSelectViewType_Stereo;
            [BesUser sharedUser].user_fileType = self.fileType;
            
        } else {
            // steteo no alert (no fileSelectView)
            [self.fileSelectView setFirstViewContent:filePath];
        }
        
        self.left_curUpgradeFilePath = filePath;
        _curUpgradeLabel.text = self.left_curUpgradeFilePath;
        // 缓存选取的路径
        [BesUser sharedUser].selected_left_filePath = filePath;
    }
    
    [_curFileListVc.navigationController popViewControllerAnimated:YES];
}

#pragma mark - XCYBlueToothEventDelegate
- (void)userChoicePeripheral:(CBPeripheral *)aPeripheral
{
    if (_curPeripheral) {
        // Clear the last data
        [self.otaBusiness disConnectPeripheral:aPeripheral notifyBlock:nil];
        [self.progressView setProgress:0 animated:NO];
        _curUpgradeProgressLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_text", @"");
    }
    
    _curPeripheral = aPeripheral;
    _curDeviceLabel.text = _curPeripheral.name;
    
    _startConnectingDeviceButton.hidden = NO;
    
    [_curBlueListVc.navigationController popViewControllerAnimated:YES];
}

#pragma mark - XCYOTASettingMainViewEventDelegate
- (void)okBtnPressedWithData:(XCYOTASettingDataDo *)aData
{
    _curSettingData = aData;
    [_curSettingData updateFlashOffsetData:[self.otaDataSource getLastFourSizeDataWithDataName:_left_curUpgradeFilePath]];
    
    [_curSettingData getTotalSettingData];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.fileType == BesFileSelectViewType_None) {
        
        /*
         old version process
         get current version 5s timeout
         无90 92
         */
        // break point check
        [self pointCheck_writeToPeripheral];
        
    } else {
        
        // new version process
        [self performSelector:@selector(getImageSideWithType) withObject:nil afterDelay:0.2];
    }
}

- (void)cancelButtonPressed{

    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - XCYOTAUpdateEventDelegate
- (void)setProgress:(CGFloat)aProgress animated:(BOOL)animate
{
    [self.progressView setProgress:aProgress animated:animate];
    int progress = aProgress*100;
    _curUpgradeProgressLabel.text = [NSString stringWithFormat:kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_Connected_Transferring2", @""), progress];
}
- (void)otaUpdateSuccessd:(BOOL)laps
{
    self.curUpgradeProgressLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_complete_text", @"");
    [self.progressView setProgress:1 animated:YES];
    
    if (self.fileType == BesFileSelectViewType_No_Same) {
        self.isSecondLap = YES;
        [BesUser sharedUser].is_secondLap = self.isSecondLap;
        
        if (!laps) {
            
            [_curSettingData updateFlashOffsetData:[self.otaDataSource getLastFourSizeDataWithDataName:_right_curUpgradeFilePath]];
            
            [_curSettingData getTotalSettingData];
            
            [self performSelector:@selector(getImageSideWithType) withObject:nil afterDelay:0.2];
        } else {
            [self.updateBusiness max_disConnectPeripheral];
        }
    } else {
        [self.updateBusiness max_disConnectPeripheral];
    }
}

- (void)otaUpdateFaildWithMsg:(NSString *)errorMsg
{
    _curUpgradeProgressLabel.text = errorMsg;
}

- (void)backToTop
{
    [self p_clear];
    
    [super backToTop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTitle = kWeXLocalizedString(@"XCYOTAViewController_Nav_Title", @"");
    
    [_changeDeviceButton setX:(self.view.width_xcy - _changeDeviceButton.width_xcy - 10)];
    [_startConnectingDeviceButton setX:(self.view.width_xcy - _startConnectingDeviceButton.width_xcy - 10)];
    [_choiceFileButton setX:(self.view.width_xcy - _choiceFileButton.width_xcy - 10)];
    [_upgradeButton setX:(self.view.width_xcy - _upgradeButton.width_xcy - 10)];
    [_curUpgradeProgressView setWidth_xcy:(self.view.width_xcy - 20)];
    [_curUpgradeProgressLabel setWidth_xcy:(self.view.width_xcy - 20)];
    
    [self.view addSubview:self.progressView];
    
    _changeDeviceButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    _startConnectingDeviceButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    _choiceFileButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    _upgradeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.curVersionLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curVersionLabel_text", @"");
    self.curVersionLabel.adjustsFontSizeToFitWidth = YES;
    
    self.curDevicePromptLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curDevicePromptLabel_text", @"");
    [self.changeDeviceButton setTitle:kWeXLocalizedString(@"XCYOTAViewController_changeDeviceButton_Title", @"") forState:UIControlStateNormal];
    [self.startConnectingDeviceButton setTitle:kWeXLocalizedString(@"XCYOTAViewController_startConnectingDeviceButton_Title", @"") forState:UIControlStateNormal];
    self.curUpgradePromptLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curUpgradePromptLabel_Title", @"");
    [self.choiceFileButton setTitle:kWeXLocalizedString(@"XCYOTAViewController_choiceFileButton_Title", @"") forState:UIControlStateNormal];
    self.curUpgradeProgressPromptLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressPromptLabel_Title", @"");
    self.curUpgradeProgressLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_Title", @"");
    [self.upgradeButton setTitle:kWeXLocalizedString(@"XCYOTAViewController_upgradeButton_Title", @"") forState:UIControlStateNormal];
    
    [self resumeData];
}

// Restore data
- (void)resumeData {
    
    // 特殊处理
    _left_curUpgradeFilePath = [BesUser sharedUser].selected_left_filePath;
    _right_curUpgradeFilePath = [BesUser sharedUser].selected_right_filePath;
    _isSecondLap = [BesUser sharedUser].is_secondLap;
    
    if (![NSString strNilOrEmpty_xcy:_left_curUpgradeFilePath] &&
        ![NSString strNilOrEmpty_xcy:_right_curUpgradeFilePath]) {
        
        _curUpgradeLabel.text = [NSString stringWithFormat:kWeXLocalizedString(@"XCYOTAViewController_curUpgradeLabel_text", @""), self.left_curUpgradeFilePath, self.right_curUpgradeFilePath];
        //        self.fileType = BesFileSelectViewType_No_Same;
        
    } else {
        _curUpgradeLabel.text = [BesUser sharedUser].selected_left_filePath;
    }
    
    // 恢复升级方式
    self.fileType = [BesUser sharedUser].user_fileType;
}

- (void)p_clear
{
    if (_curPeripheral) {
        
        [self.otaBusiness disConnectPeripheral:_curPeripheral notifyBlock:nil];
    }
    _curPeripheral = nil;
    _curDeviceLabel.text = @"";
    [self.progressView setProgress:0 animated:NO];
    _curUpgradeProgressLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_text", @"");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.otaBusiness showAlertAfterDisconnected:YES];
    [self p_addNotification];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self p_removeNotification];
}

- (void)p_addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_becomeActive) name:@"XCYapplicationDidBecomeActive" object:nil];
}

- (void)p_removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)p_becomeActive
{
    if (self.navigationController.topViewController != self) {
        
        return;
    }
    
    _curUpgradeProgressLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_interrupt_text", @"");
}

- (IBAction)changeDeviceButtonPressed:(id)sender {
    
    _curBlueListVc = [XCYConnectBlueToothOutgoingFactory blueToothViewcontroller];
    _curBlueListVc.eventDelegate = self;
    [_curBlueListVc setMenufacture:@""];

    [self.navigationController pushViewController:self.curBlueListVc animated:YES];
    [_curBlueListVc prepareConnectBlueTooth];
}
- (IBAction)startConnectingDevicePressed:(id)sender {
    [self showWaitingView:kWeXLocalizedString(@"XCYOTAViewController_startConnectingDeviceButton_Title", @"")];
    [self performSelector:@selector(p_connect) withObject:nil afterDelay:0.2];
}

- (IBAction)choiceUpgradeFileButtonPressed:(id)sender {
    
    if (!_curPeripheral) {
        
        [self p_showAlertWithMsg:kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_Alert_Msg1", @"")];
        return;
    }
    
    // 初始化随机码(点击了选择升级按钮即为更改了升级文件)
    NSString *randomCodeStr = @"0000000000000000000000000000000000000000000000000000000000000000";
    [[NSUserDefaults standardUserDefaults] setObject:randomCodeStr forKey:Randomcodekey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    switch (self.currentVersionType) {
        case BESCurrentVersionType_None:
            [self.navigationController pushViewController:self.curFileListVc animated:YES];
            break;
        case BESCurrentVersionType_Stereo:
            [self.navigationController pushViewController:self.curFileListVc animated:YES];
            break;
            
        default:
            
            [self.view addSubview:self.updataTypeSelectorView];
            break;
    }
}

- (IBAction)startUpgradeButtonPressed:(id)sender {
    
    if ([self handle_curTotalData] == NO) {
        return;
    }
    
    // config
    _otaSettingVc = [[XCYOTASettingViewController alloc] init];
    [_otaSettingVc setEventDelegate:self];
    [self.navigationController pushViewController:_otaSettingVc animated:YES];

}

- (BOOL)handle_curTotalData {
    
    if (!_curPeripheral) {
        
        [self p_showAlertWithMsg:kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_Alert_Msg1", @"")];
        return NO;
    }
    
    if (self.fileType == BesFileSelectViewType_No_Same) {
        if ([NSString strNilOrEmpty_xcy:_left_curUpgradeFilePath] ||
            [NSString strNilOrEmpty_xcy:_right_curUpgradeFilePath]) {
            
            [self p_showAlertWithMsg:kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_Alert_Msg2", @"")];
            return NO;
        }
    }
    
    /*
     flag = 1 第一次upload
     flag = 2 第二次upload
     */
    if (self.isSecondLap == NO) {
     
        _curTotalData = [self.otaDataSource getDocumentDataWithDataName:_left_curUpgradeFilePath];
    } else {
        
        _curTotalData = [self.otaDataSource getDocumentDataWithDataName:_right_curUpgradeFilePath];
    }
    
    if (!_curTotalData) {
        
        [self p_showAlertWithMsg:kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_Alert_Msg3", @"")];
        return NO;
    }
    
    return YES;
}

- (void)p_startUpgradeFile
{
    [self.progressView setProgress:0.0 animated:NO];

    _curUpgradeProgressLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_text1", @"");
    
    __weak __typeof(self)weakSelf = self;
    if (self.curPeripheralType == XCYOTAPeripheralType_OTA) {
        //OTA模式
        weakSelf.curUpgradeProgressLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_text2", @"");
        
        [weakSelf performSelector:@selector(p_startSendOTAData) withObject:nil afterDelay:0.2];
    }
    else if (self.curPeripheralType == XCYOTAPeripheralType_Origin){
        //正常模式
        _curUpgradeProgressLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_text3", @"");
        _startConnectingDeviceButton.hidden = YES;
        //延时0.2秒，让文字展示出来
        [weakSelf performSelector:@selector(p_entryOTA) withObject:nil afterDelay:0.2];
    }
}

- (void)p_connect
{
    if (_curPeripheral == nil) {
        [self p_showAlertWithMsg:kWeXLocalizedString(@"XCYOTAViewController_selectDeviceFirst_Alert_Msg", @"")];
        [self hidenWaitingView];
        return;
    }
    _curDeviceLabel.text = [NSString stringWithFormat:kWeXLocalizedString(@"XCYOTAViewController_curDeviceLabel_Connecting_text", @""), _curPeripheral.name];

    [self performSelector:@selector(p_connectPeripheral) withObject:nil afterDelay:0.2];
}

- (void)p_connectPeripheral
{
    __weak __typeof(self)weakSelf = self;
    
    [self.otaBusiness connectPeripheral:_curPeripheral complectionHandler:^(XCYOTAPeripheralType curPeripheralType, BOOL isConnected) {
       
        if (!isConnected) {
            weakSelf.curDeviceLabel.text = [NSString stringWithFormat:kWeXLocalizedString(@"XCYOTAViewController_curDeviceLabel_failure_text", @""), weakSelf.curPeripheral.name];
            _startConnectingDeviceButton.hidden = NO;
            [self hidenWaitingView];
            return ;
        }
        self.curPeripheralType = curPeripheralType;
        
        if (curPeripheralType == XCYOTAPeripheralType_OTA){
            //OTA模式
            weakSelf.curDeviceLabel.text = [NSString stringWithFormat:kWeXLocalizedString(@"XCYOTAViewController_curDeviceLabel_connected_text", @""), weakSelf.curPeripheral.name];
            _startConnectingDeviceButton.hidden = YES;
            
            [self.otaBusiness notifyToOTAPeripheral:_curPeripheral compeletionHandler:^(CBPeripheral *peripheral, CBCharacteristic *chist, NSError *error) {
                
                if (error) {
                    
                    [self hidenWaitingView];
                    
                } else {
                    [self performSelector:@selector(max_getCurrentVersion) withObject:nil afterDelay:0.2];
                }
            }];
            
        }
        else if (curPeripheralType == XCYOTAPeripheralType_Origin){
            //正常模式
            weakSelf.curDeviceLabel.text = [NSString stringWithFormat:kWeXLocalizedString(@"XCYOTAViewController_curDeviceLabel_connected_text", @""), weakSelf.curPeripheral.name];
            _startConnectingDeviceButton.hidden = YES;
        }
        else{
            weakSelf.curDeviceLabel.text = [NSString stringWithFormat:kWeXLocalizedString(@"XCYOTAViewController_curDeviceLabel_failure_text", @""), weakSelf.curPeripheral.name];
            _startConnectingDeviceButton.hidden = NO;
        }
    }];
}

//正在进入OTA模式
- (void)p_entryOTA
{
    __weak __typeof(self)weakSelf = self;
    _curUpgradeProgressLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_EnteringOTA_Mode_Title", @"");
    NSData *otaData = [self.otaDataSource getOtaEntryData];
    [self.otaBusiness writeToPeripheral:_curPeripheral
                      curPeripheralType:XCYOTAPeripheralType_Origin
                              valueData:otaData
                     complectionHandler:^(CBPeripheral *peripheral, CBCharacteristic *charactic, NSError *error) {
        if (error) {
            
            weakSelf.curUpgradeProgressLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_EnteringOTA_Mode_Failure", @"");
            return ;
        }
    }];
    
    [self.otaBusiness showAlertAfterDisconnected:NO];
    
    [weakSelf performSelector:@selector(p_disconnectPeripheral) withObject:nil afterDelay:0.5];
    
}

- (void)p_disconnectPeripheral
{
    __weak __typeof(self)weakSelf = self;
    
    [self.otaBusiness disConnectPeripheral:_curPeripheral
                               notifyBlock:^(CBPeripheral *peripheral, NSError *error) {
       
        [weakSelf p_entryOTASuccessed];
                                   
    }];
}

- (void)p_entryOTASuccessed
{
     __weak __typeof(self)weakSelf = self;
    
    [self performSelector:@selector(p_timeOutForOTASearchPeripheral) withObject:nil afterDelay:15];
    
    
    NSString *curManuFature = [NSString stringFromData_cmbc:[self.otaDataSource getOTABLEData]];
    [self.otaBusiness startScanPeripheralWithManufacture:curManuFature complectionHandler:^(CBPeripheral *peripheral) {
       
        if (!peripheral) {
            return ;
        }
        
        [NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:@selector(p_timeOutForOTASearchPeripheral) object:nil];
        
        weakSelf.curPeripheral = peripheral;
        [weakSelf p_connectPeripheral];
        
    }];
}

- (void)p_startSendOTAData
{
    _curUpgradeProgressLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_Connected_Transferring", @"");

    __weak __typeof(self)weakSelf = self;
    [self.otaBusiness notifyToOTAPeripheral:_curPeripheral compeletionHandler:^(CBPeripheral *peripheral, CBCharacteristic *chist, NSError *error) {
       
        [weakSelf p_choiceOtaType];
    }];
}

- (void)p_choiceOtaType
{
    [self handle_curTotalData];
    NSData *chocieData = [self.otaDataSource chocieOTATypeData:_curTotalData];
    __weak __typeof(self)weakSelf = self;
    [self.otaBusiness writeToPeripheral:_curPeripheral curPeripheralType:XCYOTAPeripheralType_OTA valueData:chocieData complectionHandler:^(CBPeripheral *peripheral, CBCharacteristic *charactic, NSError *error) {
       
        NSData *typeData = charactic.value;
        NSString *typeStr = [NSString stringFromData_cmbc:typeData];
        if ([typeStr rangeOfString:@"8142455354"].location == NSNotFound) {
            
            return ;
        }
        
        [NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:@selector(p_sendOtaDataWithOldType) object:nil];
        
        NSData *lengthData = [typeData subdataWithRange:NSMakeRange(typeData.length-2, 2)];
        NSUInteger maxLength = 0;
        [lengthData getBytes:&maxLength length:2];
        
        if (maxLength == 0 ||
            maxLength > 509) {
            // Special handling
            // A value of 0 indicates that the MTU exchange failed
            maxLength = 509;
        }
        
        [BesUser sharedUser].MTU_Exchange = maxLength;
        
        [weakSelf p_sendOtaDataWithType:XCYOTAUpdateType_New maxLength:(maxLength-1)];
    }];
    
    // MTU exchange by max
    [self performSelector:@selector(p_sendOtaDataWithOldType) withObject:nil afterDelay:2.0];
}

- (void)max_getCurrentVersion
{
    [self showWaitingView:kWeXLocalizedString(@"XCYOTAViewController_startGetCurrentVersion_Title", @"")];
    NSData *currentVersionData = [self.otaDataSource getCurrentVersion];
    __weak __typeof(self)weakSelf = self;
    
    [self performSelector:@selector(p_timeOutForOTAGetCurrentVersion) withObject:nil afterDelay:5];

    [self.otaBusiness writeToPeripheral:_curPeripheral curPeripheralType:XCYOTAPeripheralType_OTA valueData:currentVersionData complectionHandler:^(CBPeripheral *peripheral, CBCharacteristic *charactic, NSError *error) {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:@selector(p_timeOutForOTAGetCurrentVersion) object:nil];

        NSData *typeData = charactic.value;
        NSString *typeStr = [NSString stringFromData_cmbc:typeData];
        NSLog(@"%@", typeStr);
        
        [self hidenWaitingView];
        
        if ([typeStr containsString:@"8F42455354"]) {
           weakSelf.currentVersionStr = [typeStr substringWithRange:NSMakeRange(@"8F42455354".length, 2)];
            NSString *left_earbud = [typeStr substringWithRange:NSMakeRange(@"8F42455354".length+weakSelf.currentVersionStr.length+4, 4)];
            NSString *right_earbud = [typeStr substringWithRange:NSMakeRange(@"8F42455354".length+weakSelf.currentVersionStr.length+left_earbud.length+4+4, 4)];
            
            left_earbud = [self getNewStringWithPoint:left_earbud];
            right_earbud = [self getNewStringWithPoint:right_earbud];
            
            if ([weakSelf.currentVersionStr isEqualToString:@"00"]) {
                
                // stereo device
                weakSelf.curVersionLabel.text = [NSString stringWithFormat:kWeXLocalizedString(@"XCYOTAViewController_curVersionLabel_Text1", @""), @"stereo device", left_earbud];
                weakSelf.currentVersionType = BESCurrentVersionType_Stereo;
                
            } else if ([weakSelf.currentVersionStr isEqualToString:@"01"]) {
                
                weakSelf.curVersionLabel.text = [NSString stringWithFormat:kWeXLocalizedString(@"XCYOTAViewController_curVersionLabel_Text2", @""), @"TWS device left earbud", left_earbud, right_earbud];
                weakSelf.currentVersionType = BESCurrentVersionType_TWS_Left;
                
            } else if ([weakSelf.currentVersionStr isEqualToString:@"02"]) {

                weakSelf.curVersionLabel.text = [NSString stringWithFormat:kWeXLocalizedString(@"XCYOTAViewController_curVersionLabel_Text3", @""), @"TWS device right earbud", right_earbud, left_earbud];
                weakSelf.currentVersionType = BESCurrentVersionType_TWS_Right;
                
            } else {
                weakSelf.curVersionLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curVersionLabel_Text4", @"");
                weakSelf.currentVersionType = BESCurrentVersionType_None;
            }
        } else {
            weakSelf.curVersionLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curVersionLabel_Text4", @"");
            weakSelf.currentVersionType = BESCurrentVersionType_None;
        }
    }];
}

- (NSString *)getNewStringWithPoint:(NSString *)number {
    if (number.length > 0) {
        NSString *doneTitle = @"";
        for (int i = 0; i < number.length; i++) {
            doneTitle = [doneTitle stringByAppendingString:[number substringWithRange:NSMakeRange(i, 1)]];
            
            if (i+1 != number.length) {
                
                doneTitle = [NSString stringWithFormat:@"%@.", doneTitle];
            }
        }
        NSLog(@"%@", doneTitle);
        return doneTitle;
    }
    return number;
}

- (NSInteger)getMaxFileType {
    
    // If you choose two files to upgrade the left and right ears of the case
    if (self.fileType == BesFileSelectViewType_No_Same) {
        if (self.isSecondLap == NO) {
            return 3;
        } else {
            return 4;
        }
    } else {
        return self.fileType;
    }
}

- (void)getImageSideWithType
{
    NSData *currentData = [self.otaDataSource getImageSideWithType:[self getMaxFileType]];
    
    [self.otaBusiness writeToPeripheral:_curPeripheral curPeripheralType:XCYOTAPeripheralType_OTA valueData:currentData complectionHandler:^(CBPeripheral *peripheral, CBCharacteristic *charactic, NSError *error) {
        
        NSData *typeData = charactic.value;
        NSString *typeStr = [NSString stringFromData_cmbc:typeData];
        NSLog(@"%@", typeStr);
        
        if (typeStr.length == 0) {
            [self p_showAlertWithMsg:error.localizedDescription];
            return;
        }
            
        NSString *prefixStr = [typeStr substringWithRange:NSMakeRange(0, 2)];
        NSString *resultStr = [typeStr substringWithRange:NSMakeRange(2, 2)];
        
        if ([prefixStr isEqualToString:@"91"]) {
            if ([resultStr isEqualToString:@"01"]) {
                
                // 特殊处理，断点续传不支持二合一升级
                if (self.fileType == BesFileSelectViewType_Same) {
                    
                    //Start upgrading files
                    [self p_startUpgradeFile];
                    
                } else {
                    
                    // break point check
                    [self pointCheck_writeToPeripheral];
                }
                
            } else {
                // fail
                
            }
        }
    }];
}

- (void)pointCheck_writeToPeripheral
{
    if ([self handle_curTotalData] == NO) {
        return;
    }
    
    // 要判断是否更换了文件 是否是第一次连接
    NSData *currentData = [self.otaDataSource breakcCheckPoint:_curTotalData];
    
    [self.otaBusiness writeToPeripheral:_curPeripheral curPeripheralType:XCYOTAPeripheralType_OTA valueData:currentData complectionHandler:^(CBPeripheral *peripheral, CBCharacteristic *charactic, NSError *error) {
        
        NSData *typeData = charactic.value;
        NSString *typeStr = [NSString stringFromData_cmbc:typeData];
        NSLog(@"%@", typeStr);
        
        if (typeStr.length == 0) {
            [self p_showAlertWithMsg:error.localizedDescription];
            return;
        }
        
        NSString *packetTypeStr = [typeStr substringWithRange:NSMakeRange(0, 2)];
        NSString *breakpointStr = [typeStr substringWithRange:NSMakeRange(2, 8)];
        NSString *randomCodeStr = [typeStr substringWithRange:NSMakeRange(10, 64)];

        if ([packetTypeStr isEqualToString:@"8D"]) {
            
            // check breakpoint
            if ([breakpointStr isEqualToString:@"00000000"]) {
                
                // record the new checkpoint in response firstly,and transmitthe wholeimage
                [[NSUserDefaults standardUserDefaults] setObject:randomCodeStr forKey:Randomcodekey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                _value_segment = 0;
                
                //Start upgrading files
                [self p_startUpgradeFile];
                
            } else {
                // 006D0900 resuming transmisson 00096d00
                NSData *data = [breakpointStr dataFromHexString_xcy];
                
                NSUInteger breakPointLength = 0;
                [data getBytes:&breakPointLength length:4];
                
                _value_segment = breakPointLength;
                _curTotalData = [_curTotalData subdataWithRange:NSMakeRange(breakPointLength, _curTotalData.length - breakPointLength)];
                
                NSLog(@"breakPointLength:%f restData:%f", (double)breakPointLength, (double)_curTotalData.length);

                [self p_sendOtaDataWithType:XCYOTAUpdateType_New maxLength:[BesUser sharedUser].MTU_Exchange - 1];
            }
        }
    }];
}

- (void)p_sendOtaDataWithOldType
{
    [self p_sendOtaDataWithType:XCYOTAUpdateType_Old maxLength:128];
}

- (void)p_sendOtaDataWithType:(XCYOTAUpdateType)atype maxLength:(NSUInteger)length
{
    _updateBusiness = [XCYOTAInHouseFactory getUpdateBusinessWithType:atype];
    [_updateBusiness setViewDelegate:self];
    [_updateBusiness initResource];
    [_updateBusiness setSecondLap:self.isSecondLap];
    [_updateBusiness setUpdatePeripheral:_curPeripheral];
    [_updateBusiness setTotalSendData:_curTotalData];
    [_updateBusiness setMaxSendDataLength:length];
    [_updateBusiness setMaxCurrentVersionType:self.fileType];
    [_updateBusiness setMaxBreakPointLength:_value_segment];
    [_updateBusiness setOTASettgingData:[_curSettingData getTotalSettingData]];
    [_updateBusiness otaUpdateStart];
}

- (void)p_showAlertWithMsg:(NSString *)aMsg
{
    id<XCYUISystemAlertInterface> alert = [XCYUISystemAlertServer initSystemAlert];
    
    [alert showSysAlertTitle:kWeXLocalizedString(@"XCYOTAViewController_alert_Title", @"") msg:aMsg cancelButtonTitle:kWeXLocalizedString(@"XCYOTAViewController_alert_submitButton_title", @"") cancelBlock:nil otherButtonTitle:nil otherBlock:nil];
}

- (void)p_timeOutForOTASearchPeripheral
{
    _curUpgradeProgressLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curUpgradeProgressLabel_Fail_Title", @"");
    
    [self.otaBusiness stopScanPeriperal];
}

- (void)p_timeOutForOTAGetCurrentVersion {
    // 区分新旧协议
    self.curVersionLabel.text = kWeXLocalizedString(@"XCYOTAViewController_curVersionLabel_Text5", @"");
    self.currentVersionType = BESCurrentVersionType_None;
    [self hidenWaitingView];
}

- (XCYOTAFileListViewController *)curFileListVc
{
    if (_curFileListVc) {
        return _curFileListVc;
    }
    
    _curFileListVc = [[XCYOTAFileListViewController alloc] init];
    _curFileListVc.eventDelegate = self;
    
    return _curFileListVc;
}

- (NJKWebViewProgressView *)progressView
{
    if (_progressView) {
        return _progressView;
    }
    CGRect progressViewFrame = _curUpgradeProgressView.frame;
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:progressViewFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_progressView setProgress:0.0 animated:NO];
    
    return _progressView;
}

- (XCYOTADataSource *)otaDataSource
{
    if (_otaDataSource) {
        
        return _otaDataSource;
    }
    
    _otaDataSource = [[XCYOTADataSource alloc] init];
    
    return _otaDataSource;
}

- (XCYOTABusiness *)otaBusiness
{
    if (_otaBusiness) {
        return _otaBusiness;
    }
    
    _otaBusiness = [[XCYOTABusiness alloc] init];
    
    return _otaBusiness;
}

- (BesUpdataTypeSelectorView *)updataTypeSelectorView {
    if (!_updataTypeSelectorView) {
        _updataTypeSelectorView = [BesUpdataTypeSelectorView viewWithParent:self.view];
        _updataTypeSelectorView.delegate = self;
    }
    return _updataTypeSelectorView;
}

- (BesFileSelectView *)fileSelectView {
    if (!_fileSelectView) {
        _fileSelectView = [BesFileSelectView viewWithParent:self.view fileType:self.fileType];
        _fileSelectView.delegate = self;
    }
    return _fileSelectView;
}

@end
