//
//  XCYWaitingView.h
//
//
//  Created by XCY on 15-7-15.
//  Copyright (c) 2014年 XCY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCYWaitingView : UIView

-(instancetype)initWithSuperView:(UIView*)superView
                      maskedView:(UIView*)maskView;

- (instancetype)initWithFrame:(CGRect)frame
                    superView:(UIView*)superView;

-(void)showWaitingView:(NSString*)title;

-(void)hidenWaitingView;

@end
