//
//  XCYTopBar.h
//  XCYBusinessCard
//
//  Created by XCY on 15-2-9.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCYTopBarConfig.h"
#import "XCYTopBarUIConfig.h"

@class XCYTopBarButtonItem;

@interface XCYTopBar : UIView

//背景图片
@property(nonatomic, retain)UIImage  *bgImage;

//标题图片
@property(nonatomic, retain)UIImage  *titleImage;

//大标题
@property(nonatomic, copy)NSString   *mainTitle;

//左侧按钮
@property(nonatomic, retain)XCYTopBarButtonItem *leftButtonItem;

//右侧按钮
@property(nonatomic, retain)XCYTopBarButtonItem *rightButtonItem;

@end
