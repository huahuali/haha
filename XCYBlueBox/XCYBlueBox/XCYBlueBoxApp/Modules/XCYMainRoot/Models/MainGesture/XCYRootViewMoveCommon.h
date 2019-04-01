//
//  XCYRootViewMoveCommon.h
//  XCYSharKey
//
//  Created by XCY on 15/4/22.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

typedef NS_ENUM(NSInteger,XCYViewPosEnum)
{
    XCYViewPosEnum_None = 0,
    XCYViewPosEnum_Center = 1 << 0,
    XCYViewPosEnum_left = 1 << 1,
    XCYViewPosEnum_right = 1 << 2
};


@protocol XCYViewMoveManagerDelegate <NSObject>
-(void)moveViewPositionStatus:(XCYViewPosEnum)position;
@end

