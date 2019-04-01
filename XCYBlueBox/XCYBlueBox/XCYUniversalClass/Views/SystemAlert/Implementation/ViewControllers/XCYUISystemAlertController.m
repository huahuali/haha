//
//  XCYUISystemAlertController.m
//
//  Created by XCY on 16/11/1.
//  Copyright © 2016年 XCY. All rights reserved.
//

#import "XCYUISystemAlertController.h"
#import "XCYUISystemAlertControllerQueue.h"

typedef void(^XCYUISystemBlock)(void);

@interface XCYUISystemAlertController ()

@property (copy, nonatomic) XCYUISystemBlock cancelBlock;
@property (copy, nonatomic) XCYUISystemBlock otherBlock;

@property (strong, nonatomic) UIAlertController *alert;

@end

@implementation XCYUISystemAlertController

- (void)dealloc
{

}

#pragma mark - Public method(or public protocol)
- (void)showSysAlertTitle:(NSString *)aTitle
                      msg:(NSString *)aMsg
        cancelButtonTitle:(NSString *)aCancelTitle
              cancelBlock:(void(^)(void))aCancelBlock
         otherButtonTitle:(NSString *)aOtherTitle
               otherBlock:(void(^)(void))aOtherBlock
{
    
    self.alert = [UIAlertController alertControllerWithTitle:aTitle message:aMsg preferredStyle:UIAlertControllerStyleAlert];
    if (![NSString strNilOrEmpty_xcy:aCancelTitle]) {
        
        UIAlertAction *alertAction = [self p_getAlertActionWithTitle:aCancelTitle touchBlock:aCancelBlock];
        [_alert addAction:alertAction];
    }
    
    if (![NSString strNilOrEmpty_xcy:aOtherTitle]) {
    
        UIAlertAction *alertAction = [self p_getAlertActionWithTitle:aOtherTitle touchBlock:aOtherBlock];
        [_alert addAction:alertAction];
    }
    
    XCYUISystemAlertControllerQueue *queue = [XCYUISystemAlertControllerQueue sharedInstance];
    [queue showAlert:self];
}


- (void)show
{
    UIViewController *rootVc = [UIApplication applicationRootViewController_xcy];
    [rootVc presentViewController:_alert animated:YES completion:nil];
}

- (void)hidden
{
    XCYUISystemAlertControllerQueue *queue = [XCYUISystemAlertControllerQueue sharedInstance];
    [queue hiddenAlert:self];
}

#pragma mark - private method(or private protocol)
- (UIAlertAction *)p_getAlertActionWithTitle:(NSString *)aTitle
                                  touchBlock:(void(^)(void))aBlock
{
    
    __weak __typeof(self)weakSelf = self;
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:aTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (aBlock)
        {
            aBlock();
        }
        
        [weakSelf hidden];
    }];
    
    return alertAction;
}

#pragma mark - setter or getter

@end
