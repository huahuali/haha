//
//  BesCheckButtonSelectorView.m
//  XCYBlueBox
//
//  Created by max on 2019/3/15.
//  Copyright © 2019年 XCY. All rights reserved.
//

#import "BesCheckButtonSelectorView.h"

@interface BesCheckButtonSelectorView ()

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *checkImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *checkButton;

@end

@implementation BesCheckButtonSelectorView

+ (BesCheckButtonSelectorView *)view {
    BesCheckButtonSelectorView *cell = [[BesCheckButtonSelectorView alloc] init];
    [cell p_setupSubviews];
    [cell p_layoutSubviews];
    return cell;
}

- (void)setContentText:(NSString *)text {
    self.contentLabel.text = text;
}
- (void)setCheckImage:(NSString *)image {
    self.checkImageView.image = [UIImage imageNamed:image];
}
- (void)setButtonTag:(NSInteger)tag {
    self.checkButton.tag = tag;
}

#pragma mark - private
- (void)p_setupSubviews {
    [self addSubview:self.container];
    [self.container addSubview:self.checkImageView];
    [self.container addSubview:self.contentLabel];
    [self.container addSubview:self.checkButton];
}

- (void)p_layoutSubviews {
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_equalTo(45);
    }];
    [self.checkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.container);
        make.left.mas_equalTo(self.container).offset(15);
        make.size.mas_equalTo(CGSizeMake(21, 21));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.container);
        make.left.mas_equalTo(self.checkImageView.mas_right).offset(15);
        make.right.mas_equalTo(self.container);
    }];
    
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.container).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - lazy
- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] init];
        _container.backgroundColor = [UIColor whiteColor];
    }
    return _container;
}

- (UIImageView *)checkImageView {
    if (!_checkImageView) {
        _checkImageView = [[UIImageView alloc] init];
        _checkImageView.image = [UIImage imageNamed:@"login_bujizhushoujihaoIcon"]; // default
    }
    return _checkImageView;
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
    }
    return _checkButton;
}

#pragma mark - buttonClick
- (void)buttonClick:(UIButton *)sender {
    if (sender == self.checkButton) {
        if (_delegate &&
            [_delegate respondsToSelector:@selector(buttonClickWithIndex:)]) {
            [_delegate buttonClickWithIndex:sender.tag];
        }
    }
}

@end
