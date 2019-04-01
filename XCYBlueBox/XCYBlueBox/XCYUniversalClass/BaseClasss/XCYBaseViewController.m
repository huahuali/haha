//
//  XCYBaseViewController.m
//  XCYBusinessCard
//
//  Created by XCY on 15-2-9.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "XCYBaseViewController.h"
#import "XCYTopBarConfig.h"
#import "XCYTopBar.h"
#import "XCYTopBarButtonItem.h"
#import "XCYWaitingView.h"


typedef enum
{
    vcShowType_no = 0,
    vcShowType_addSubView = 1,
    vcShowType_present = 2,
    vcShowType_push = 3,
    
    
} XCYVcShowType;


@interface XCYBaseViewController ()
{

    XCYVcShowType viewControllerShowType;
}

@property (nonatomic, retain)XCYWaitingView *waitingView;

/**
 * init topBar
 */
-(void)initTopBar;

/**
 * init TopBar BackButton
 */
-(void)initTopBarBackButton;

@end

@implementation XCYBaseViewController


-(instancetype)init
{

    if (self = [super init])
    {
        self.needTopBar = YES;
        self.needShowBack = YES;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize mainSize = [UIDevice getScreenSize_xcy];
    [self.view setWidth_xcy:mainSize.width];
    [self.view setHeight_xcy:mainSize.height];
    
    self.view.backgroundColor =[UIColor hexColor_xcy:@"EEEEEE"];
    
    if (self.needTopBar)
    {
        [self initTopBar];
        
        if (self.needShowBack)
        {
            [self initTopBarBackButton];
        }
    }
    
    [self initWaitingView];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)initWaitingView
{
    CGRect mainframe = self.view.bounds;
    CGSize topBarSize = XCYTitleBarSize();
    CGRect frame = CGRectMake(0, topBarSize.height, mainframe.size.width, mainframe.size.height-topBarSize.height);
    
    if (!self.needTopBar) {
        
        frame = mainframe;
    }
    
    XCYWaitingView *view = [[XCYWaitingView alloc]initWithFrame:frame superView:self.view];
    
    self.waitingView = view;
}

/**
 * 初始化topBar
 */
-(void)initTopBar
{
    CGSize topBarSize = XCYTitleBarSize();
    
    XCYTopBar *barView = [[XCYTopBar alloc]initWithFrame:CGRectMake(0, 0, topBarSize.width, topBarSize.height)];
    
    self.topBar = barView;
    
    [self.view addSubview:_topBar];
}

/**
 * 初始化左侧返回按钮
 */
-(void)initTopBarBackButton
{
    
    CGRect customframe = CGRectMake(0,
                                    iphoneStatusBarHeight,
                                    62,
                                    xcyTopBarHeight-iphoneStatusBarHeight);
    
    UIView *view = [[UIView alloc]initWithFrame:customframe];
    view.backgroundColor = [UIColor clearColor];
    
    CGRect imageViewframe = CGRectMake(5, (customframe.size.height-30.0)/2, 15, 30);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageViewframe];
    imageView.image = [UIImage imageNamed:XCYTopBar_LeftBtnImage];
    [view addSubview:imageView];
    
    CGRect labelframe = CGRectMake(imageViewframe.origin.x+imageViewframe.size.width, (customframe.size.height-30.0)/2, customframe.size.width-imageViewframe.origin.x-imageViewframe.size.width, 30);
    
    UILabel *label = [[UILabel alloc]initWithFrame:labelframe];
    label.text = @"返回";
    label.font = [UIFont systemFontOfSize:17.0f];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = view.bounds;
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(backToTop) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    XCYTopBarButtonItem *item = [[XCYTopBarButtonItem alloc]initWithCustomView:view];
    _topBar.leftButtonItem = item;
}

/**
 * 设置主标题
 */
-(void)setMainTitle:(NSString *)mainTitle
{
    if (_mainTitle != mainTitle)
    {
        _mainTitle = [mainTitle copy];
        
        [_topBar setMainTitle:_mainTitle];
    }
}

-(void)setNeedShowBack:(BOOL)needShowBack
{
    if (_needShowBack != needShowBack)
    {
        _needShowBack = needShowBack;
        
        if (!_needShowBack)
        {
            _topBar.leftButtonItem = nil;
        }
        else
        {
            
            [self initTopBarBackButton];
        }
    }
}

-(void)backToTop
{
    switch (viewControllerShowType)
    {
        case vcShowType_addSubView:
            [self.view removeFromSuperview];
            break;
            
            
        case vcShowType_present:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
            
        case vcShowType_push:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            [self.navigationController popViewControllerAnimated:YES];
            break;
    }
}

#pragma mark - 等待层

-(void)showWaitingView:(NSString*)title
{
    [self.view bringSubviewToFront:_waitingView];
    [self.waitingView showWaitingView:title];
}

-(void)hidenWaitingView
{
    [self.waitingView hidenWaitingView];
}

#pragma mark controller 展现方式
-(void)showControllerByPush:(UINavigationController *)nav animated:(BOOL)animated
{
    viewControllerShowType = vcShowType_push;
}


-(void)showControllerAnimated:(BOOL)animated
{
//    XCYAppDelegate *app = AppDelegate;
//    [app showViewControllerOnRootNav:self animated:animated];
}

-(void)showControllerByAddSubView:(UIViewController *)vc animated:(BOOL)animated
{
    viewControllerShowType = vcShowType_addSubView;
    
}

-(void)showCotrollerByPresent:(UIViewController *)owerVc animated:(BOOL)animated
{
    viewControllerShowType = vcShowType_present;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
