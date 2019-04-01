//
//  XCYEQLoadListViewEventDelegate.h
//  XCYBlueBox
//
//  Created by XCY on 2017/4/14.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCYEQDataDo.h"

@protocol XCYEQLoadListViewEventDelegate <NSObject>

@required

- (void)currentLoadEQTestData:(XCYEQDataDo *)aDataDo;



@end
