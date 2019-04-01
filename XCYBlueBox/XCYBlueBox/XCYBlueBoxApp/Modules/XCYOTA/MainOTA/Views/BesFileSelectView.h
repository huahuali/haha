//
//  BesFileSelectView.h
//  XCYBlueBox
//
//  Created by max on 2019/3/18.
//  Copyright © 2019年 XCY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BesFileSelectViewType)
{
    BesFileSelectViewType_None = 0,
    BesFileSelectViewType_Same,
    BesFileSelectViewType_No_Same,
    BesFileSelectViewType_Left,
    BesFileSelectViewType_Right,
    BesFileSelectViewType_Stereo,
};

@protocol BesFileSelectViewDelegate <NSObject>

@optional
- (void)BesFileSelecButtonClickIndex:(NSInteger)index;
- (void)BesFileSelecBackButtonClick;

// 选择升级文件
- (void)BesUpdataFileSelectedIndex:(NSInteger)index;
@end

@interface BesFileSelectView : UIView

@property (nonatomic, assign) BesFileSelectViewType fileType;
@property (nonatomic, weak) id <BesFileSelectViewDelegate> delegate;

+ (BesFileSelectView *)viewWithParent:(UIView*)parentView
                             fileType:(BesFileSelectViewType)fileType;

- (void)setFirstViewContent:(NSString *)text;
- (void)setSecondViewContent:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
