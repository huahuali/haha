//
//  BesUpdataTypeSelectorView.h
//  XCYBlueBox
//
//  Created by max on 2019/3/15.
//  Copyright © 2019年 XCY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BesUpdataTypeSelectorViewDelegate <NSObject>

@optional
- (void)buttonClickIndex:(NSInteger)index;
- (void)backButtonClick;

@end

@interface BesUpdataTypeSelectorView : UIView

@property (nonatomic, weak) id <BesUpdataTypeSelectorViewDelegate> delegate;

+ (BesUpdataTypeSelectorView *)viewWithParent:(UIView*)parentView;

@end

NS_ASSUME_NONNULL_END
