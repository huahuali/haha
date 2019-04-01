//
//  XCYViwePanGestureManager.m
//  XCYSharKey
//
//  Created by XCY on 15/4/16.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "XCYViewPanGestureManager.h"

@interface XCYViewPanGestureManager()<UIGestureRecognizerDelegate>
@property(nonatomic,assign)UIView *observedView;
@property(nonatomic,retain)UIPanGestureRecognizer *recognizer;
@property(nonatomic,assign)CGPoint startTouch;
@property(nonatomic,assign)BOOL recordFirstGesture;
@property(nonatomic,assign)XCYViewPanDirectionType firstDirection;
-(void)p_initPanGesture;
-(XCYViewPanDirectionType)p_directionTypeOffsetPoint:(CGPoint)offsetP;

@end

@implementation XCYViewPanGestureManager
-(instancetype)initWithObserverView:(UIView *)view
{
    if(self = [super init])
    {
        self.observedView = view;
        [self p_initPanGesture];
        _forceAcceptPanGesture = YES;
        _firstDirection = XCYViewPanDirectionType_None;
       
        _loactionInView = [UIApplication applicationWindow_xcy];
    
    }
    return self;

}

-(void)dealloc
{
    
}

-(void)p_initPanGesture
{
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(paningGestureReceive:)];
    self.recognizer = recognizer;
    _recognizer.delegate = self;


}
#pragma mark//手势代理回调
-(BOOL)isFavoriteViewControllerItem:(id)view
{
    return NO;

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    id touchView = touch.view;
    //仅仅为我的民生页面并且该页面为编辑状态
    BOOL isFavoriteItem = [self isFavoriteViewControllerItem:touchView];
    if(([touchView isKindOfClass:[UIScrollView class]]
       && !_forceAcceptPanGesture)
       || isFavoriteItem
       )
    {
        return NO;
    }
    
    return YES;
    
}


-(BOOL)p_panGestureIsSomeTypeSource:(XCYViewPanDirectionType)sourceType
                         targetType:(XCYViewPanDirectionType)targetType
{
    BOOL someTypeGesture = NO;
    if(sourceType & XCYViewPanDirectionType_slideLeft
       || sourceType & XCYViewPanDirectionType_slideRight)
    {
       if(targetType & XCYViewPanDirectionType_slideLeft ||
          targetType & XCYViewPanDirectionType_slideRight)
       {
           someTypeGesture = YES;
           
       }
    }
    
    if(sourceType & XCYViewPanDirectionType_slideUp ||
       sourceType & XCYViewPanDirectionType_slideDown)
    {
        if(targetType & XCYViewPanDirectionType_slideUp||
           targetType & XCYViewPanDirectionType_slideDown)
        {
            someTypeGesture = YES;
        }
    
    }
    return someTypeGesture;

}


#pragma mark//公开接口
-(void)startObserveView
{
    if(![_observedView.gestureRecognizers containsObject:_recognizer])
    {
        [_observedView addGestureRecognizer:_recognizer];
        _recognizer.enabled = YES;
    }

}


-(void)cancelObserv
{
    if([_observedView.gestureRecognizers containsObject:_recognizer])
    {
         [_observedView removeGestureRecognizer:_recognizer];
        
    }
   
}


-(XCYViewPanDirectionType)p_directionTypeOffsetPoint:(CGPoint)offsetP
{
    
    CGFloat offsetX = offsetP.x;
    CGFloat offsetY = offsetP.y;
    XCYViewPanDirectionType type = XCYViewPanDirectionType_None;
    //如果是向右平行滑动
    if(offsetX > 0 && offsetY == 0)
    {
        type = XCYViewPanDirectionType_slideRight;
        
    }
    //如果是向右下滑动
    else if(offsetX > 0 && offsetY > 0)
    {
        type = offsetX > offsetY ? XCYViewPanDirectionType_slideRight:XCYViewPanDirectionType_slideDown;
        
    }
    //如果是向右上滑动
    else if(offsetX > 0 && offsetY < 0)
    {
        offsetY = fabs(offsetY);
        type = offsetX > offsetY ? XCYViewPanDirectionType_slideRight:XCYViewPanDirectionType_slideUp;
        
    }
    
    //向左平行滑动
    if(offsetX < 0 && offsetY == 0)
    {
        type = XCYViewPanDirectionType_slideLeft;
        
    }
    //向左下平行滑动
    else if(offsetX < 0 && offsetY > 0)
    {
        offsetX = fabs(offsetX);
        type = offsetX > offsetY ? XCYViewPanDirectionType_slideLeft:XCYViewPanDirectionType_slideDown;
        
    }
    //向左上平行滑动
    else if(offsetX < 0 && offsetY < 0)
    {
        type = offsetX > offsetY ? XCYViewPanDirectionType_slideUp:XCYViewPanDirectionType_slideLeft;
        
    }
   
    return type;
}



#pragma mark//手势回调
- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    NSParameterAssert(_loactionInView != nil);
    CGPoint touchPoint = [recoginzer locationInView:_loactionInView];
    CGPoint offset = CGPointZero;
    UIGestureRecognizerState recognizerstatus =  UIGestureRecognizerStatePossible;
    XCYViewPanDirectionType type = XCYViewPanDirectionType_None;
    
    if (recoginzer.state == UIGestureRecognizerStateBegan)
    {
        _startTouch = touchPoint;
        recognizerstatus = UIGestureRecognizerStateBegan;
    }
    else if (recoginzer.state == UIGestureRecognizerStateEnded)
    {
        
        offset = CGPointMake(touchPoint.x - _startTouch.x, touchPoint.y - _startTouch.y);
        recognizerstatus = UIGestureRecognizerStateEnded;
        type = [self p_directionTypeOffsetPoint:offset];
        if(_recordFirstGesture)
        {
            type = _firstDirection;
             _recordFirstGesture = NO;
            _firstDirection = XCYViewPanDirectionType_None;
        }

    }
    else if (recoginzer.state == UIGestureRecognizerStateCancelled)
    {
        recognizerstatus = UIGestureRecognizerStateCancelled;
        
    }
    else if(recoginzer.state == UIGestureRecognizerStateChanged)
    {
        //手指不离开屏幕，手势状态一直变化，手势规则为
        //仅仅以第一次手势为准，并且只能同一种类型手势切换
        recognizerstatus = UIGestureRecognizerStateChanged;
         offset = CGPointMake(touchPoint.x - _startTouch.x, touchPoint.y - _startTouch.y);
        type = [self p_directionTypeOffsetPoint:offset];
        BOOL someType = [self p_panGestureIsSomeTypeSource:_firstDirection targetType:type];
        if(((type != XCYViewPanDirectionType_None)
           && !_recordFirstGesture)
           || someType)
        {
            _firstDirection = type;
            _recordFirstGesture = YES;
        }
        
        type = _firstDirection;
        
    }
    
    if([_delegate respondsToSelector:@selector(pandGestureType:moveOffset:gestureStatus:gestureRecognizer:)])
    {
        [_delegate
         pandGestureType:type
         moveOffset:offset
         gestureStatus:recognizerstatus
         gestureRecognizer:_recognizer];
    
    }
    
    
}

-(void)setForceAcceptPanGesture:(BOOL)forceAcceptPanGesture
{
        _forceAcceptPanGesture = forceAcceptPanGesture;
        if(_forceAcceptPanGesture)
        {
            [self startObserveView];
        }
}


@end
