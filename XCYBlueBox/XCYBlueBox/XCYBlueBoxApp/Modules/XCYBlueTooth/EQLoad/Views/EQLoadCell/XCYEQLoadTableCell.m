//
//  XCYEQLoadTableCell.m
//  XCYBlueBox
//
//  Created by XCY on 2017/4/7.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYEQLoadTableCell.h"

@interface XCYEQLoadTableCell ()

@end

@implementation XCYEQLoadTableCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setAutoresizesSubviews:NO];
    [self setAutoresizingMask:UIViewAutoresizingNone];
    
    [self.contentView setAutoresizesSubviews:NO];
    [self.contentView setAutoresizingMask:UIViewAutoresizingNone];
    
    CGSize mainSize = [UIDevice getScreenSize_xcy];
    [self setWidth_xcy:mainSize.width];
    [self.contentView setWidth_xcy:mainSize.width];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  
}

@end
