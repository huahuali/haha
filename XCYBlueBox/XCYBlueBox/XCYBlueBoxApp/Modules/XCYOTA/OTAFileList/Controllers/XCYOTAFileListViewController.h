//
//  XCYOTAFileListViewController.h
//  XCYBlueBox
//
//  Created by XCY on 2017/4/23.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYBaseViewController.h"
#import "XCYOTAFileEventDelegate.h"

@interface XCYOTAFileListViewController : XCYBaseViewController


@property (weak, nonatomic) id<XCYOTAFileEventDelegate> eventDelegate;
@end
