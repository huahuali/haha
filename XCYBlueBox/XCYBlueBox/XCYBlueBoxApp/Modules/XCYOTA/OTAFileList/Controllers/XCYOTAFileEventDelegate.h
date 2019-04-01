//
//  XCYOTAFileEventDelegate.h
//  XCYBlueBox
//
//  Created by XCY on 2017/4/23.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XCYOTAFileEventDelegate <NSObject>

@required

- (void)userChoiceOTAFile:(NSString *)filePath;
@end
