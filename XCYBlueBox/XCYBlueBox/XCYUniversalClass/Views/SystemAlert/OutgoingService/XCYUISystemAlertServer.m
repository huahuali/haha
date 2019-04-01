//
//  XCYUISystemAlertServer.m
//  XCYUIKit
//
//  Created by XCY on 16/11/1.
//  Copyright © 2016年 XCY. All rights reserved.
//

#import "XCYUISystemAlertServer.h"
#import "XCYUISystemAlertController.h"

@implementation XCYUISystemAlertServer

+ (id<XCYUISystemAlertInterface>)initSystemAlert
{

    XCYUISystemAlertController *alert = [[XCYUISystemAlertController alloc] init];
    
    return alert;

}

@end
