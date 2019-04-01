//
//  BesFileSelectView.m
//  XCYBlueBox
//
//  Created by max on 2019/3/18.
//  Copyright © 2019年 XCY. All rights reserved.
//

#import "BesFileSelectView.h"
#import "BesFileSelectComponentView.h"

@interface BesFileSelectView ()<BesFileSelectComponentViewDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) BesFileSelectComponentView *firstView;
@property (nonatomic, strong) BesFileSelectComponentView *secondView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *submitButton;
//@property (nonatomic, assign) NSInteger uploadCount;
@property (nonatomic, strong) NSMutableDictionary *containDic;

@end

@implementation BesFileSelectView

+ (BesFileSelectView *)viewWithParent:(UIView*)parentView
                             fileType:(BesFileSelectViewType)fileType
{
    BesFileSelectView *cell = [[BesFileSelectView alloc] init];
    
    cell.fileType = fileType;
    cell.containDic = [[NSMutableDictionary alloc] init];
    [cell p_setupSubviewsWithParent:parentView];
    [cell p_layoutSubviewsWithParent:parentView];
    return cell;
}

- (void)setFirstViewContent:(NSString *)text
{
    [self.firstView setContentText:text];
}
- (void)setSecondViewContent:(NSString *)text
{
    [self.secondView setContentText:text];
}
- (void)setSUbmitButtonEnabel:(BOOL)enabel {
    if (enabel) {
        [_submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _submitButton.backgroundColor = [UIColor greenColor];
        _submitButton.enabled = YES;
    } else {
        
        [_submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _submitButton.backgroundColor = [UIColor grayColor];
        _submitButton.enabled = NO;
    }
}

- (void)p_setupSubviewsWithParent:(UIView*)parentView {
    [parentView addSubview:self];
    
    [parentView addSubview:self.backView];
    [parentView addSubview:self.backButton];
    
    self.backgroundColor = [UIColor whiteColor];
    
    if (self.fileType == BesFileSelectViewType_No_Same) {
        [self addSubview:self.firstView];
        [self addSubview:self.secondView];
        [self addSubview:self.cancelButton];
        [self addSubview:self.submitButton];
        self.firstView.checkButton.tag = 100;
        self.secondView.checkButton.tag = 101;
        
    } else {
        [self addSubview:self.firstView];
        [self addSubview:self.cancelButton];
        [self addSubview:self.submitButton];
        self.firstView.checkButton.tag = 100;
    }
    
    if (self.fileType == BesFileSelectViewType_No_Same) {
        [self.firstView setTitleText:kWeXLocalizedString(@"BesFileSelectView_firstView_left_Title", @"")];
        [self.secondView setTitleText:kWeXLocalizedString(@"BesFileSelectView_firstView_right_Title", @"")];
        [self.firstView setContentText:@"--"];
        [self.secondView setContentText:@"--"];
        
    } else if (self.fileType == BesFileSelectViewType_Same) {
        [self.firstView setTitleText:kWeXLocalizedString(@"BesFileSelectView_firstView_Title", @"")];
        [self.firstView setContentText:@"--"];
    } else if (self.fileType == BesFileSelectViewType_Left) {
        [self.firstView setTitleText:kWeXLocalizedString(@"BesFileSelectView_firstView_left_Title", @"")];
        [self.firstView setContentText:@"--"];
    } else if (self.fileType == BesFileSelectViewType_Right) {
        [self.firstView setTitleText:kWeXLocalizedString(@"BesFileSelectView_firstView_right_Title", @"")];
        [self.firstView setContentText:@"--"];
    }
}

- (void)p_layoutSubviewsWithParent:(UIView*)parentView {
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(parentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(parentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(parentView);
        make.centerY.mas_equalTo(parentView).offset(-30);
        make.left.mas_equalTo(parentView).offset(25);
        make.right.mas_equalTo(parentView).offset(-25);
    }];
    
    if (self.fileType == BesFileSelectViewType_No_Same) {
        [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
        }];
        [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self.firstView.mas_bottom);
        }];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.secondView.mas_bottom).offset(7);
            make.bottom.mas_equalTo(self).offset(-14);
            make.centerX.mas_equalTo(self).offset(-60);
            make.size.mas_equalTo(CGSizeMake(65, 35));
        }];
        [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.secondView.mas_bottom).offset(7);
            make.bottom.mas_equalTo(self).offset(-14);
            make.centerX.mas_equalTo(self).offset(60);
            make.size.mas_equalTo(CGSizeMake(65, 35));
        }];
    } else {
        [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
        }];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.firstView.mas_bottom).offset(7);
            make.bottom.mas_equalTo(self).offset(-14);
            make.centerX.mas_equalTo(self).offset(-60);
            make.size.mas_equalTo(CGSizeMake(65, 35));
        }];
        [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.firstView.mas_bottom).offset(7);
            make.bottom.mas_equalTo(self).offset(-14);
            make.centerX.mas_equalTo(self).offset(60);
            make.size.mas_equalTo(CGSizeMake(65, 35));
        }];
    }
}

#pragma mark - buttonClick
- (void)cacel_buttonClick:(UIButton *)sender {
    if (_delegate &&
        [_delegate respondsToSelector:@selector(BesFileSelecBackButtonClick)]) {
        [self.backView removeFromSuperview];
        [self.backButton removeFromSuperview];
        
        self.backView = nil;
        self.backButton = nil;
        
        [_delegate BesFileSelecBackButtonClick];
    }
}

- (void)submit_buttonClick:(UIButton *)sender {
    if (_delegate &&
        [_delegate respondsToSelector:@selector(BesFileSelecButtonClickIndex:)]) {
        [self.backView removeFromSuperview];
        [self.backButton removeFromSuperview];
        
        self.backView = nil;
        self.backButton = nil;
        
        [_delegate BesFileSelecButtonClickIndex:1];
    }
}

- (void)backButtonClick {
    if (_delegate &&
        [_delegate respondsToSelector:@selector(BesFileSelecBackButtonClick)]) {
        [self.backView removeFromSuperview];
        [self.backButton removeFromSuperview];
        
        self.backView = nil;
        self.backButton = nil;
        
        [_delegate BesFileSelecBackButtonClick];
    }
}

#pragma make - BesFileSelectComponentViewDelegate
// 选择升级文件
- (void)BesFileSelectComponent_buttonClickIndex:(NSInteger)index {
    [self.containDic setObject:[NSNumber numberWithInteger:index] forKey:[NSNumber numberWithInteger:index]];
    
    if (self.fileType == BesFileSelectViewType_No_Same) {
        if (self.containDic.allKeys.count == 2) {
            [self setSUbmitButtonEnabel:YES];
        } else {
            [self setSUbmitButtonEnabel:NO];
        }
    } else {
        if (self.containDic.allKeys.count == 1) {
            [self setSUbmitButtonEnabel:YES];
        } else {
            [self setSUbmitButtonEnabel:NO];
        }
    }
    
    if (_delegate &&
        [_delegate respondsToSelector:@selector(BesUpdataFileSelectedIndex:)]) {
        
        [_delegate BesUpdataFileSelectedIndex:index];
    }
}

#pragma make - lazy
- (BesFileSelectComponentView *)firstView {
    if (!_firstView) {
        _firstView = [BesFileSelectComponentView view];
        _firstView.delegate = self;
        _firstView.checkButton.tag = 100;
    }
    return _firstView;
}
- (BesFileSelectComponentView *)secondView {
    if (!_secondView) {
        _secondView = [BesFileSelectComponentView view];
        _secondView.delegate = self;
        _secondView.checkButton.tag = 101;
    }
    return _secondView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton addTarget:self action:@selector(cacel_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitle:kWeXLocalizedString(@"BesFileSelectView_cancelButton_Title", @"") forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelButton.backgroundColor = [UIColor  greenColor];
        _cancelButton.layer.cornerRadius = 5;
    }
    return _cancelButton;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton addTarget:self action:@selector(submit_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_submitButton setTitle:kWeXLocalizedString(@"BesFileSelectView_submitButton_Title", @"") forState:UIControlStateNormal];
        [self setSUbmitButtonEnabel:NO];
        _submitButton.layer.cornerRadius = 5;
    }
    return _submitButton;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = .4;
    }
    return _backView;
}

@end
