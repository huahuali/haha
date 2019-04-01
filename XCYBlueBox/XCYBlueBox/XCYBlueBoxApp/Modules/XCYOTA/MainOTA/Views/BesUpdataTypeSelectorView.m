//
//  BesUpdataTypeSelectorView.m
//  XCYBlueBox
//
//  Created by max on 2019/3/15.
//  Copyright © 2019年 XCY. All rights reserved.
//

#import "BesUpdataTypeSelectorView.h"
#import "BesCheckButtonSelectorView.h"

@interface BesUpdataTypeSelectorView ()<BesCheckButtonSelectorViewDelegate>
{
    NSInteger _click_index;
}
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) NSMutableArray *arrContainer;

@end

@implementation BesUpdataTypeSelectorView

+ (BesUpdataTypeSelectorView *)viewWithParent:(UIView*)parentView {
    BesUpdataTypeSelectorView *cell = [[BesUpdataTypeSelectorView alloc] init];
    [cell p_setupSubviewsWithParent:parentView];
    [cell p_layoutSubviewsWithParent:parentView];
    
    return cell;
}

#pragma mark - private
- (void)p_setupSubviewsWithParent:(UIView*)parentView {
    [parentView addSubview:self];
    
    [parentView addSubview:self.backView];
    [parentView addSubview:self.backButton];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.titleLabel];
    self.arrContainer = [[NSMutableArray alloc] init];
    
    NSArray *contentArr = @[kWeXLocalizedString(@"BesUpdataTypeSelectorView_contentArr_Title1", @""),
                            kWeXLocalizedString(@"BesUpdataTypeSelectorView_contentArr_Title2", @""),
                            kWeXLocalizedString(@"BesUpdataTypeSelectorView_contentArr_Title3", @""),
                            kWeXLocalizedString(@"BesUpdataTypeSelectorView_contentArr_Title4", @""),];
    
    for (int i = 0; i < 4; i++) {
        BesCheckButtonSelectorView *checkView = [BesCheckButtonSelectorView view];
        [checkView setContentText:contentArr[i]];
        [self addSubview:checkView];
        [self.arrContainer addObject:checkView];
        checkView.delegate = self;
        [checkView setButtonTag:i];
    }
    
    [self addSubview:self.submitButton];
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
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self).offset(15);
        make.right.mas_equalTo(self).offset(-10);
    }];
    
    for (int i = 0; i < [self.arrContainer count]; i++) {
        BesCheckButtonSelectorView *checkView = self.arrContainer[i];
        [checkView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5+45*i);
            make.height.mas_equalTo(45);
            make.left.right.mas_equalTo(self);
            if (i == [self.arrContainer count] - 1) {
                make.bottom.mas_equalTo(self).offset(-55);
            }
        }];
    }
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-15);
        make.bottom.mas_equalTo(self).offset(-15);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
}

#pragma mark - lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.text = kWeXLocalizedString(@"BesUpdataTypeSelectorView_titleLabel_Text", @"");
    }
    return _titleLabel;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_submitButton setTitle:kWeXLocalizedString(@"BesUpdataTypeSelectorView_submitButton_Title", @"") forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _submitButton.enabled = NO;
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

#pragma mark - buttonClick
- (void)buttonClick:(UIButton *)sender {
    if (_delegate &&
        [_delegate respondsToSelector:@selector(buttonClickIndex:)]) {
        [self.backView removeFromSuperview];
        [self.backButton removeFromSuperview];
        
        self.backView = nil;
        self.backButton = nil;
        
        [_delegate buttonClickIndex:_click_index];
    }
}

- (void)backButtonClick {
    if (_delegate &&
        [_delegate respondsToSelector:@selector(backButtonClick)]) {
        [self.backView removeFromSuperview];
        [self.backButton removeFromSuperview];
        
        self.backView = nil;
        self.backButton = nil;
        
        [_delegate backButtonClick];
    }
}

#pragma mark - BesCheckButtonSelectorViewDelegate
- (void)buttonClickWithIndex:(NSInteger)index {
    _click_index = index;
    [_submitButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    _submitButton.enabled = YES;
    
    for (int i = 0; i < [self.arrContainer count]; i++) {
        BesCheckButtonSelectorView *checkView = self.arrContainer[i];
        if (i == index) {
            [checkView setCheckImage:@"login_jizhushoujihaoIcon"];
        } else {
            [checkView setCheckImage:@"login_bujizhushoujihaoIcon"];
        }
    }
}

@end
