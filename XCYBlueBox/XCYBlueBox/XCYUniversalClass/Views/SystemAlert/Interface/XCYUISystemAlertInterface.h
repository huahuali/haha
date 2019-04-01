//
//  XCYUISystemAlertInterface.h
//
//  Created by XCY on 16/11/1.
//  Copyright © 2016年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XCYUISystemAlertInterface <NSObject>

- (void)showSysAlertTitle:(NSString *)aTitle
                      msg:(NSString *)aMsg
        cancelButtonTitle:(NSString *)aCancelTitle
              cancelBlock:(void(^)(void))aCancelBlock
         otherButtonTitle:(NSString *)aOtherTitle
               otherBlock:(void(^)(void))aOtherBlock;
@end
