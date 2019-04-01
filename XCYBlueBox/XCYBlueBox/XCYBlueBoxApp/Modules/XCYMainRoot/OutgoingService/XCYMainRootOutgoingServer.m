//
//  XCYMainRootOutgoingServer.m
//  XCYBlueBox
//
//  Created by XCY on 16/12/31.
//  Copyright © 2016年 XCY. All rights reserved.
//

#import "XCYMainRootOutgoingServer.h"
#import "XCYMainRootViewController.h"

@implementation XCYMainRootOutgoingServer

+ (void)showLeftRootView
{
    XCYMainRootViewController *mainRoot = [XCYMainRootViewController sharedInstance];
    [mainRoot showExtendVc];
}
@end
