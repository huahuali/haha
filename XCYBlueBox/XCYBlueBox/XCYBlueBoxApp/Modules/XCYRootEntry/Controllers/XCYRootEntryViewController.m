//
//  XCYRootEntryViewController.m
//  XCYBlueBox
//
//  Created by XCY on 2017/4/21.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYRootEntryViewController.h"
#import "XCYOTAOutgoingFactory.h"
//#import "XCYEQOutoginFactory.h"
#import "XCYTopBarButtonItem.h"
#import "XCYUISystemAlertServer.h"

@interface XCYRootEntryViewController ()

@property (strong, nonatomic) IBOutlet UIButton *otaButton;

@property (strong, nonatomic) XCYOTAViewController *otaVc;
//@property (strong, nonatomic) XCYEQRootManager *eqRootManager;

@end

@implementation XCYRootEntryViewController

- (void)viewDidLoad {
    
    self.needShowBack = NO;
    [super viewDidLoad];
    
    self.mainTitle = @"BES App";
    
    [_otaButton setX_xcy:((self.view.width_xcy - _otaButton.width_xcy)/2)];
    
    [self p_addRightNavButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)otaButtonPressed:(id)sender {
    
    if ([self.navigationController.viewControllers containsObject:self.otaVc]) {
        
        return;
    }
    
    [self.navigationController pushViewController:self.otaVc animated:YES];
}

- (void)p_addRightNavButton
{
    XCYTopBarButtonItem *item = [[XCYTopBarButtonItem alloc] initWithTitle:@"Info" target:self action:@selector(p_deviceInfo)];
    [self.topBar setRightButtonItem:item];
}

- (void)p_deviceInfo
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy.MM"];
    NSString *dateStr = [dateFormater stringFromDate:[NSDate date]];
    NSString *totalStr = [NSString stringWithFormat:@"Version:%@\nDate:%@\nBestechnic(Shanghai)Co.,Ltd",XCYBESVrsion,dateStr];
    
    id<XCYUISystemAlertInterface> alert = [XCYUISystemAlertServer initSystemAlert];
    [alert showSysAlertTitle:@"Info" msg:totalStr cancelButtonTitle:@"确定" cancelBlock:nil otherButtonTitle:nil otherBlock:nil];
}

#pragma mark - getter or setter

- (XCYOTAViewController *)otaVc
{
//    if (_otaVc) {
//        return _otaVc;
//    }
    
    _otaVc = [XCYOTAOutgoingFactory getOTAViewController];
    
    return _otaVc;
}

@end
