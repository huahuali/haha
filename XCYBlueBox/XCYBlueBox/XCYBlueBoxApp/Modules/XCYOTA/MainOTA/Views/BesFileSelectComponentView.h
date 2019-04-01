//
//  BesFileSelectComponentView.h
//  XCYBlueBox
//
//  Created by max on 2019/3/18.
//  Copyright © 2019年 XCY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BesFileSelectComponentViewDelegate <NSObject>

@optional
- (void)BesFileSelectComponent_buttonClickIndex:(NSInteger)index;

@end

@interface BesFileSelectComponentView : UIView

@property (nonatomic, weak) id <BesFileSelectComponentViewDelegate> delegate;
@property (nonatomic, strong) UIButton *checkButton;

+ (BesFileSelectComponentView *)view;
- (void)setTitleText:(NSString *)text;
- (void)setContentText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
