//
//  XCYBlueToothTableViewController.h
//  XCYBlueBox
//
//  Created by XCY on 2017/4/7.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYBaseViewController.h"
#import "XCYBlueToothEventDelegate.h"

@interface XCYBlueToothTableViewController : XCYBaseViewController

@property (weak, nonatomic) id<XCYBlueToothEventDelegate> eventDelegate;

- (void)setMenufacture:(NSString *)facture;

- (void)prepareConnectBlueTooth;

@end
