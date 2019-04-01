//
//  XCYUISystemAlertServer.h
//
//  Created by XCY on 16/11/1.
//  Copyright © 2016年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCYUISystemAlertInterface.h"

@interface XCYUISystemAlertServer : NSObject

+ (id<XCYUISystemAlertInterface>)initSystemAlert;

@end
