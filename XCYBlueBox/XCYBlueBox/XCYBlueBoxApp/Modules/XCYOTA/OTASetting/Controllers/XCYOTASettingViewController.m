//
//  XCYOTASettingViewController.m
//  XCYBlueBox
//
//  Created by zhouaitao on 2017/8/19.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYOTASettingViewController.h"
#import "XCYOTASettingMainView.h"

@interface XCYOTASettingViewController ()<XCYOTASettingMainViewEventDelegate>


@property (strong, nonatomic) XCYOTASettingMainView *mainView;
@property (weak, nonatomic) id<XCYOTASettingMainViewEventDelegate> curDelegate;

@end

@implementation XCYOTASettingViewController

- (void)setEventDelegate:(id<XCYOTASettingMainViewEventDelegate>)aDelegate
{
    _curDelegate = aDelegate;
}

#pragma mark - XCYOTASettingMainViewEventDelegate
- (void)okBtnPressedWithData:(XCYOTASettingDataDo *)aData{

    if ([_curDelegate respondsToSelector:@selector(okBtnPressedWithData:)]) {
        [_curDelegate okBtnPressedWithData:aData];
    }
}

- (void)cancelButtonPressed{

    if ([_curDelegate respondsToSelector:@selector(cancelButtonPressed)]) {
        
        [_curDelegate cancelButtonPressed];
    }
}

- (void)backToTop
{
    [self cancelButtonPressed];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainTitle = kWeXLocalizedString(@"XCYOTASettingViewController_Nav_Title", @"");
    
    [self p_addSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)p_addSubViews
{
    _mainView = [XCYOTASettingMainView getOTASettingView];
    [_mainView setEventDelegate:self];

    CGSize titleSize = XCYTitleBarSize();
    CGRect frame = CGRectMake(0, titleSize.height, self.view.frame.size.width, self.view.frame.size.height-titleSize.height);
    _mainView.frame = frame;
    
    [self.view addSubview:_mainView];

}
@end
