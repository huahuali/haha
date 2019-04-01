//
//  XCYMainRootViewController.h
//  XCYSharKey
//
//  Created by XCY on 15-2-12.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "XCYBaseViewController.h"

@interface XCYMainRootViewController : XCYBaseViewController

-(void)showCenterView:(void (^)())finishBlock;
-(void)showCenterView;
-(void)showLeftView;

- (void)showExtendVc;

XCYSINGLETONDECLEAR(XCYMainRootViewController);

@end
