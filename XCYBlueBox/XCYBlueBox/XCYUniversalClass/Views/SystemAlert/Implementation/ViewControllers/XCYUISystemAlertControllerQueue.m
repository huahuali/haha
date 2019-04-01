//
//  XCYUISystemAlertControllerQueue.m
//
//  Created by XCY on 16/11/5.
//  Copyright © 2016年 XCY. All rights reserved.
//

#import "XCYUISystemAlertControllerQueue.h"

@interface XCYUISystemAlertControllerQueue ()

@property (strong, nonatomic) NSMutableArray *alertViewArray;


@end

@implementation XCYUISystemAlertControllerQueue


- (instancetype)init
{
    if (self = [super init]) {
        
        _alertViewArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
    
    return self;
}

//单例
+ (XCYUISystemAlertControllerQueue *)sharedInstance
{
    static XCYUISystemAlertControllerQueue *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[XCYUISystemAlertControllerQueue alloc] init];
    });
    
    return _sharedInstance;
}

//移除弹出框
- (void)hiddenAlert:(XCYUISystemAlertController *)alertController
{
    [self.alertViewArray removeObject:alertController];
    XCYUISystemAlertController *last = [self.alertViewArray firstObject];
    if (last)
    {
        [last show];
    }
}

- (void)showAlert:(XCYUISystemAlertController *)alertController
{
    if (self.alertViewArray.count == 0) {
        
        [alertController show];
    }
    
    [self.alertViewArray addObject:alertController];
}


@end
