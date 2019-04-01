//
//  XCYMainRootExtendUI.h
//  XCYSharKey
//
//  Created by XCY on 15/6/22.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCYTopBarButtonItem;

@interface XCYMainRootExtendUI : NSObject

+(XCYTopBarButtonItem*)customLeftBarItemTarget:(id)target
                                        action:(SEL)action;

@end
