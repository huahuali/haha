//
//  XCYBlueToothTableViewController.m
//  XCYBlueBox
//
//  Created by XCY on 2017/4/7.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYBlueToothTableViewController.h"
#import "XCYBlueToothTableViewCell.h"
#import "XCYBlueToothCentralManager.h"
#import "XCYTopBarButtonItem.h"
#import "XCYCommonUIUtil.h"
#import "XCYBlueToothInHouseFactory.h"
#import "XCYBlueToothPeripheralBusinessInterface.h"

@interface XCYBlueToothTableViewController ()
<UITableViewDataSource,
UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray<CBPeripheral *> *tableList;
@property (strong, nonatomic) id<XCYBlueToothPeripheralBusinessInterface> peripheralBusiness;

@property (assign, nonatomic) NSInteger reloadNum;

@property (strong, nonatomic) NSTimer *startTimer;

@end

@implementation XCYBlueToothTableViewController

- (void)dealloc
{
    [self p_removeNotification];
}

- (void)setMenufacture:(NSString *)facture
{
    [self.peripheralBusiness setMenufacture:facture];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self addCustomRightBarItem];
    self.mainTitle = @"Device to connect";
    
    [self.view addSubview:self.tableView];
    
    [self p_addNotificaiton];
}

- (void)p_addNotificaiton
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_becomeActive) name:@"XCYapplicationDidBecomeActive" object:nil];
}

- (void)p_removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self hidenWaitingView];
    [_startTimer invalidate];
    _startTimer = nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CBPeripheral *peropheral = [_tableList objectAtIndex_xcy:indexPath.row];
    if (!peropheral) {
        return nil;
    }
    
    UINib *nib = [XCYBlueToothTableViewCell nib];
    XCYBlueToothTableViewCell *cell = [XCYBlueToothTableViewCell cellForTableView:tableView fromNib:nib];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBLEName:peropheral.name];
    [cell setBLEServiceNumber:peropheral.services.count];
    [cell setWifiStrength:60];
    
    if (indexPath.row == 0) {
        
        [XCYCommonUIUtil addTopLineToView:cell withColor:[UIColor hexColor_xcy:@"A6A6AD"]];
    }
    

    if (indexPath.row == (_tableList.count -1)) {
        
        [XCYCommonUIUtil addBottomLineToView:cell withColor:[UIColor hexColor_xcy:@"A6A6AD"]];
    }
    else
    {
        [XCYCommonUIUtil addBottomLineToView:cell withColor:[UIColor hexColor_xcy:@"A6A6AD"] originX:10];
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor clearColor]];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor clearColor]];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBPeripheral *curPeripheral = [_tableList objectAtIndex:indexPath.row];

    if ([_eventDelegate respondsToSelector:@selector(userChoicePeripheral:)]) {
        
        [_eventDelegate userChoicePeripheral:curPeripheral];
    }
}

- (void)addCustomRightBarItem
{
    XCYTopBarButtonItem *item = [[XCYTopBarButtonItem alloc] initWithTitle:@"refresh" target:self action:@selector(p_resetBlueToothDevice)];
    [self.topBar setRightButtonItem:item];
}

- (void)p_becomeActive
{
    UIViewController *topVc = [self.navigationController topViewController];
    if (topVc != self) {
        
        return;
    }
    
    [self prepareConnectBlueTooth];
}

- (void)p_resetBlueToothDevice
{
    //CONNECT BlueTooth
    [self prepareConnectBlueTooth];
}

- (void)prepareConnectBlueTooth
{
    if (_startTimer) {
        [_startTimer invalidate];
        _startTimer = nil;
    }
    
    
    _reloadNum = 0;
    _startTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                   target:self
                                                 selector:@selector(p_startReload)
                                                 userInfo:nil
                                                  repeats:YES];
    
    

    __weak __typeof(self)weakSelf = self;
    [self showWaitingView:@"Please wait while we search for the device..."];

    [self.peripheralBusiness scanForPeripheralsComplectionHandler:^(NSArray<CBPeripheral *> *peripheralList, BOOL isScanSuccess) {
       
        if (!isScanSuccess) {
            
            return ;
        }
        
        weakSelf.tableList = peripheralList;
    }];
}

- (void)p_startReload
{
    if (_reloadNum >=5) {
        
        [_startTimer invalidate];
        _startTimer = nil;
    }
    
    [self hidenWaitingView];
    if (_tableList.count > 0) {
        
        [_tableView reloadData];
    }
    
    _reloadNum ++;
}

#pragma mark - setter or getter
- (UITableView *)tableView
{
    if (_tableView) {
        return _tableView;
    }
    
    CGSize titleSize = XCYTitleBarSize();
    CGRect frame = CGRectMake(0, titleSize.height, self.view.width_xcy, self.view.height_xcy-titleSize.height);
    
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.autoresizesSubviews = NO;
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    
    if ([_tableView respondsToSelector:@selector(setSectionIndexColor:)])
    {
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = [UIColor grayColor];
    }
    
    return _tableView;
}

- (id<XCYBlueToothPeripheralBusinessInterface>)peripheralBusiness
{
    if (_peripheralBusiness) {
        
        return _peripheralBusiness;
    }
    
    _peripheralBusiness = [XCYBlueToothInHouseFactory getPeripheralBusiness];
    return _peripheralBusiness;
}

@end
