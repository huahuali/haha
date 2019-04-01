//
//  XCYUISystemAlertControllerQueue.h
//
//  Created by XCY on 16/11/5.
//  Copyright © 2016年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCYUISystemAlertController.h"

@interface XCYUISystemAlertControllerQueue : NSObject

//单例
+ (XCYUISystemAlertControllerQueue *)sharedInstance;

//移除弹出框
- (void)hiddenAlert:(XCYUISystemAlertController *)alertController;

- (void)showAlert:(XCYUISystemAlertController *)alertController;

@end
