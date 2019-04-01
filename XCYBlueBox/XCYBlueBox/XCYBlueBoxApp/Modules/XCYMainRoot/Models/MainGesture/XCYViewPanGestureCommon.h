//
//  XCYViewPanGestureCommon.h
//  XCYSharKey
//
//  Created by XCY on 15/4/22.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

typedef  NS_ENUM(NSInteger, XCYViewPanDirectionType)
{
    XCYViewPanDirectionType_None = 0,
    XCYViewPanDirectionType_slideLeft = 1 << 0,
    XCYViewPanDirectionType_slideRight= 1 << 1,
    XCYViewPanDirectionType_slideUp= 1 << 2,
    XCYViewPanDirectionType_slideDown = 1 << 3
    
};


@protocol XCYViewPanGestureManagerDelegate <NSObject>
@required
-(void)pandGestureType:(XCYViewPanDirectionType)type
            moveOffset:(CGPoint)offset
         gestureStatus:(UIGestureRecognizerState)status
            gestureRecognizer:(UIPanGestureRecognizer*)recognizer;

@end

