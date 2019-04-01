//
//  XCYViwePanGestureManager.h
//  XCYSharKey
//  视图滑动方向判断类,默认为系统window为参照
//  Created by XCY on 15/4/16.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCYViewPanGestureCommon.h"

@interface XCYViewPanGestureManager : NSObject<NSObject>
@property(nonatomic,assign)id<XCYViewPanGestureManagerDelegate> delegate;
@property(nonatomic,assign)BOOL forceAcceptPanGesture;
@property(nonatomic,assign)UIView *loactionInView;
-(instancetype)initWithObserverView:(UIView*)view;
-(void)startObserveView;
-(void)cancelObserv;
@end
