//
//  XCYMainRootViewController.m
//  XCYSharKey
//
//  Created by XCY on 15-2-12.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "XCYMainRootViewController.h"
#import "XCYMainRootExtendUI.h"
#import "XCYViewPanGestureManager.h"
#import "XCYRootViewMoveCommon.h"
#import "XCYTopBar.h"
#import "XCYRootEntryOutgoingFactory.h"

@interface XCYMainRootViewController ()<XCYViewPanGestureManagerDelegate>
{

    CGPoint startTouch;
}

//滑动视图的手势
@property(nonatomic,assign)UIPanGestureRecognizer *panRecongnizer;

@property(nonatomic,strong)XCYViewPanGestureManager *panGesturemanager;

@property (strong, nonatomic) XCYRootEntryViewController *rootEntryVc;

@property (strong, nonatomic) UINavigationController *bluePushNav;


@property(nonatomic,assign)XCYViewPosEnum currentPos;

@property (nonatomic, assign) CGFloat slideWidth;

//悬浮层
@property(nonatomic, strong)UIView *overlayerView;

/**
 * 创建点击漂浮层, 防主视图的点击事件被触发
 */
-(void)initOverLayerView;

/**
 * 添加侧滑手势
 */
-(void)addDefaultGestureToCenterView;

@end

@implementation XCYMainRootViewController

XCYSINGLETONIMPLEMENT(XCYMainRootViewController);

@synthesize overlayerView = _overlayerView;


-(instancetype)init
{

    if (self = [super init])
    {
        _currentPos = XCYViewPosEnum_Center;
        _slideWidth = [self p_getSlideOffSetX];
    }
    
    return self;
}

- (void)viewDidLoad
{
    self.needShowBack =NO;
    [super viewDidLoad];
    
    [self initRootViewController];
    
    //创建点击漂浮层
    [self initOverLayerView];
}

-(void)initRootViewController
{
    _rootEntryVc = [XCYRootEntryOutgoingFactory getRootEntryVc];
    
    _bluePushNav = [[UINavigationController alloc] initWithRootViewController:_rootEntryVc];
    [_bluePushNav setNavigationBarHidden:YES];
    [self.view addSubview:_bluePushNav.view];
}

-(CGRect)mainRootVcFrame
{
    CGRect mainframe = [UIScreen mainScreen].bounds;
    
    CGSize topsize = XCYTitleBarSize();
    
    CGRect frame = CGRectMake(mainframe.origin.x,
                              topsize.height,
                              mainframe.size.width,
                              mainframe.size.height-topsize.height);
    return frame;
}

-(void)showExtendVc
{
    if (_currentPos == XCYViewPosEnum_Center)
    {
        [self showLeftView];
    }
    else if (_currentPos == XCYViewPosEnum_right)
    {
        [self showCenterView];
    }
}

/**
 * 创建点击漂浮层, 防主视图的点击事件被触发
 */
-(void)initOverLayerView
{

    UIView *overView = [[UIView alloc] initWithFrame:self.view.bounds];
    overView.backgroundColor = [UIColor hexColor_xcy:@"585858"];
    overView.alpha = 0.5f;
    
    self.overlayerView = overView;

    
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(overlayerViewDidClicked:)];
    tap.numberOfTapsRequired = 1;
    [self.overlayerView addGestureRecognizer:tap];

}

-(void)addDefaultGestureToCenterView
{
    if(!_panGesturemanager)
    {
        XCYViewPanGestureManager *manager = [[XCYViewPanGestureManager alloc]initWithObserverView:_bluePushNav.view];
        manager.delegate = self;
        self.panGesturemanager = manager;
    }
    
    [_panGesturemanager startObserveView];
}


-(XCYViewPosEnum)positionWhenSlibViewDirection:(XCYViewPanDirectionType)direction
{
    XCYViewPosEnum pos = XCYViewPosEnum_None;
    XCYViewPosEnum currentPos = _currentPos;
    if(direction == XCYViewPanDirectionType_slideLeft)
    {
        if(currentPos  == XCYViewPosEnum_Center)
        {
            pos = XCYViewPosEnum_left;
        }
        else if(currentPos == XCYViewPosEnum_right)
        {
            pos = XCYViewPosEnum_Center;
        }
        
    }
    else if(direction == XCYViewPanDirectionType_slideRight)
    {
        if(currentPos == XCYViewPosEnum_Center)
        {
            pos = XCYViewPosEnum_right;
        }
        else if(currentPos == XCYViewPosEnum_left)
        {
            pos = XCYViewPosEnum_Center;
        }
    }
    return pos;
}


#pragma mark//控制显示接口
-(void)showCenterView:(void (^)())finishBlock
{
    if(finishBlock)
    {
        finishBlock();
    }
    
    [UIView animateWithDuration:0.2 animations:^{

        [self resetFirstVcFrame:0.0f];
        [_overlayerView setAlpha:0.0f];

    } completion:^(BOOL finished) {

        _currentPos = XCYViewPosEnum_Center;
        [self hideTheRightView:YES];
    }];
}
-(void)showCenterView
{
    [self showCenterView:nil];
    
}

-(void)showLeftView
{
    
    [_overlayerView setAlpha:0.0f];
    [_bluePushNav.view addSubview:_overlayerView];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self resetFirstVcFrame:_slideWidth];
        
        [_overlayerView setAlpha:0.5f];
        
    } completion:^(BOOL finished) {
        
        _currentPos = XCYViewPosEnum_right;
    }];
}



-(void)moveCenterViewByFinalX:(CGFloat)offsetX
{
    XCYViewPosEnum current = _currentPos;
    
    if(offsetX >= 80)
    {
        if(current == XCYViewPosEnum_left)
        {
            [self showCenterView];
        }
        else
        {
            [self showLeftView];
        }
    }
    else
    {

        [self showCenterView];
        
    }

}

-(void)resetFirstVcFrame:(CGFloat)offSetX
{
    CGRect firstVcframe = _bluePushNav.view.frame;
    
    CGRect frame = CGRectMake(offSetX, firstVcframe.origin.y, firstVcframe.size.width, firstVcframe.size.height);
    
    [_bluePushNav.view setFrame:frame];
}


-(BOOL)isWindowPickerView
{
    
    UIWindow *appWindow = [UIApplication applicationWindow_xcy];
    BOOL isPickerView = NO;
    
    for (UIView *subView in  appWindow.subviews)
    {
        commonFunction.showLog(@"UIPickerView :%@ ",NSStringFromClass([subView class]));
        
        if ([subView isKindOfClass:NSClassFromString(@"UIPickerView")]) {
            isPickerView = YES;
        }
        
        if ([subView isKindOfClass:[UIPickerView class]]) {
            isPickerView = YES;
        }
    }
    
    return isPickerView;
}


-(BOOL)handleSlidHorizontalGestureType:(XCYViewPanDirectionType)direction
                             moveOffsetX:(CGFloat)offsetX
                           gestureStatus:(UIGestureRecognizerState)status
{
    
    BOOL handle = NO;

    static XCYViewPosEnum willPos = XCYViewPosEnum_None;
    static BOOL endmove = YES;
    if (status == UIGestureRecognizerStateBegan)
    {
        
        willPos = XCYViewPosEnum_None;
        endmove = YES;
    }
    
    //手势开始记录位置以后才能使用方向判断
    if(!(direction&XCYViewPanDirectionType_slideLeft || direction&XCYViewPanDirectionType_slideRight))
    {
        commonFunction.showLog(@"非左右滑动返回不做处理");
        return NO;
    }
    
    CGFloat offSetX = _bluePushNav.view.frame.origin.x;
    if (status == UIGestureRecognizerStateChanged)
    {
        CGFloat transX =[_panRecongnizer translationInView:_bluePushNav.view].x;
        
        if(willPos == XCYViewPosEnum_None)
        {
            willPos = [self positionWhenSlibViewDirection:direction];
        }
        
        if (_currentPos == XCYViewPosEnum_Center && willPos == XCYViewPosEnum_left)
        {
            return NO;
        }
        
        if( willPos & XCYViewPosEnum_Center)
        {
            offSetX = transX>0?_slideWidth:_slideWidth+transX;
            offSetX = offSetX<-320?0:offSetX;

        }
        else if(willPos & XCYViewPosEnum_right)
        {
            offSetX = transX>_slideWidth?_slideWidth:transX;
            offSetX = offSetX<-80?-80:offSetX;
        }
        
        [self resetFirstVcFrame:offSetX];
        
    }
    else if(status == UIGestureRecognizerStateEnded)
    {
        CGFloat transX = [_panRecongnizer translationInView:_bluePushNav.view].x;
        
        [self moveCenterViewByFinalX:transX];
        
        handle = YES;
    }
                              
    
    return handle;
}


/**
 * 隐藏右侧视图和悬浮层
 */
-(void)hideTheRightView:(BOOL)isHidden
{
    if ([_overlayerView isDescendantOfView:self.view])
    {
        [_overlayerView removeFromSuperview];
        [_overlayerView setAlpha:0.5f];
    }
    
    if (!isHidden)
    {
        [_bluePushNav.view addSubview:_overlayerView];
    }
}

-(void)overlayerViewDidClicked:(UITapGestureRecognizer*)gesture
{
    [self showCenterView];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

//主视图往右侧滑动的距离
- (CGFloat)p_getSlideOffSetX
{
    CGFloat intervalWidth = 64.0f;
    CGSize mainSize = [UIDevice getScreenSize_xcy];
    CGFloat offSetX = mainSize.width - intervalWidth;
    
    return offSetX;
}

#pragma mark - XCYViewPanGestureManagerDelegate
-(void)pandGestureType:(XCYViewPanDirectionType)type
            moveOffset:(CGPoint)offset
         gestureStatus:(UIGestureRecognizerState)status
     gestureRecognizer:(UIPanGestureRecognizer*)recognizer
{
    self.panRecongnizer = recognizer;
    BOOL pickView = [self isWindowPickerView];
    if(pickView)
    {
        return;
    }
    
    BOOL handle = [self handleSlidHorizontalGestureType:type moveOffsetX:offset.x gestureStatus:status];

    if(!handle)
    {
        commonFunction.showLog(@"pandGestureType:手势无法处理");
    }
}

@end
