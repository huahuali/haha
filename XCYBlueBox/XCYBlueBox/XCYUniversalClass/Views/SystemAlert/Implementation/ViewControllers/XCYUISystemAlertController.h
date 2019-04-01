//
//  XCYUISystemAlertController.h
//
//  Created by  on 16/11/1.
//  Copyright © 2016年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCYUISystemAlertInterface.h"

@interface XCYUISystemAlertController : NSObject<XCYUISystemAlertInterface>

- (void)show;
- (void)hidden;
@end
