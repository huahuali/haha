//
//  BesFileSelectComponentView.m
//  XCYBlueBox
//
//  Created by max on 2019/3/18.
//  Copyright © 2019年 XCY. All rights reserved.
//

#import "BesFileSelectComponentView.h"

@interface BesFileSelectComponentView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation BesFileSelectComponentView

+ (BesFileSelectComponentView *)view {
    BesFileSelectComponentView *cell = [[BesFileSelectComponentView alloc] init];
    
    [cell p_setupSubviews];
    [cell p_layoutSubviews];
    return cell;
}

- (void)setTitleText:(NSString *)text {
    self.titleLabel.text = text;
}
- (void)setContentText:(NSString *)text {
    self.contentLabel.text = text;
}

- (void)p_setupSubviews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.checkButton];
}

- (void)p_layoutSubviews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.right.mas_equalTo(self).offset(-10);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.titleLabel.mas_left);
    }];
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_top);
        make.left.mas_equalTo(self.contentLabel.mas_right).offset(5);
        make.right.mas_equalTo(self).offset(-7);
        make.size.mas_equalTo(CGSizeMake(90, 35));
        make.bottom.mas_equalTo(self).offset(-7);
    }];
}

#pragma mark - lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:15];
    }
    return _contentLabel;
}

- (UIButton *)checkButton {
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_checkButton setTitle:kWeXLocalizedString(@"BesFileSelectComponentView_checkButton_Title", @"") forState:UIControlStateNormal];
        [_checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _checkButton.backgroundColor = [UIColor  greenColor];
        _checkButton.layer.cornerRadius = 5;
        _checkButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _checkButton;
}

#pragma mark - buttonClick
- (void)buttonClick:(UIButton *)sender {
    if (sender == self.checkButton) {
        if (_delegate &&
            [_delegate respondsToSelector:@selector(BesFileSelectComponent_buttonClickIndex:)]) {
            [_delegate BesFileSelectComponent_buttonClickIndex:sender.tag];
        }
    }
}

@end
