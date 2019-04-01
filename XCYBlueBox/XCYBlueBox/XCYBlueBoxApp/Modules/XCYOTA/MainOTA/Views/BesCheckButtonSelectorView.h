//
//  BesCheckButtonSelectorView.h
//  XCYBlueBox
//
//  Created by max on 2019/3/15.
//  Copyright © 2019年 XCY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BesCheckButtonSelectorViewDelegate <NSObject>

@optional
- (void)buttonClickWithIndex:(NSInteger)index;

@end

@interface BesCheckButtonSelectorView : UIView

@property (nonatomic, weak) id <BesCheckButtonSelectorViewDelegate> delegate;

+ (BesCheckButtonSelectorView *)view;
- (void)setContentText:(NSString *)text;
- (void)setCheckImage:(NSString *)image;
- (void)setButtonTag:(NSInteger)tag;

@end

NS_ASSUME_NONNULL_END
