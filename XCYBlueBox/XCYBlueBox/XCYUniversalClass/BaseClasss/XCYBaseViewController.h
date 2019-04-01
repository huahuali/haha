//
//  XCYBaseViewController.h
//  XCYBusinessCard
//
//  Created by XCY on 15-2-9.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XCYTopBar.h"


@interface XCYBaseViewController : UIViewController

//导航栏
@property(nonatomic, retain)XCYTopBar *topBar;

//标题
@property(nonatomic, copy)NSString *mainTitle;

//是否需要topBar
@property(nonatomic, assign)BOOL needTopBar;

//是否需要返回按钮
@property(nonatomic, assign)BOOL needShowBack;

-(void)showWaitingView:(NSString*)title;

-(void)hidenWaitingView;

-(void)showControllerAnimated:(BOOL)animated;

-(void)showControllerByPush:(UINavigationController *)nav animated:(BOOL)animated;

-(void)showControllerByAddSubView:(UIViewController *)vc animated:(BOOL)animated;

-(void)showCotrollerByPresent:(UIViewController *)owerVc animated:(BOOL)animated;

-(void)backToTop;

@end
