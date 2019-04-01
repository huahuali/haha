//
//  XCYTopBarButtonItem.m
//  XCYBusinessCard
//
//  Created by XCY on 15-2-10.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "XCYTopBarButtonItem.h"
#import "XCYTopBarConfig.h"

@interface XCYTopBarButtonItem ()

@property(nonatomic, retain)UIView *customView;

//按钮显示名
@property(nonatomic, copy)NSString *btnTitle;

//按钮图片名称
@property(nonatomic, retain)UIImage *btnImage;

//按钮高亮图片名称
@property(nonatomic, retain)UIImage *btnHilightImage;

//点击事件的响应方法
@property (nonatomic) SEL action;

//响应方法所在的类
@property (nonatomic, assign) id target;

@property(nonatomic, assign)BarButtonItemStyle itemStyle;

@end

@implementation XCYTopBarButtonItem

-(instancetype)init
{
    if (self = [super init])
    {
        self.itemStyle = BarButtonItemStyleBordered;
    }
    
    return self;
}

- (id)initWithTitle:(NSString *)title
             target:(id)target
             action:(SEL)action
{

    if (self = [super init])
    {
        self.itemStyle = BarButtonItemStyleBordered;
        self.btnTitle = title;
        self.target = target;
        self.action = action;
    }
    
    return self;
}

- (id)initWithImage:(UIImage *)image
     highlightImage:(UIImage*)highligImage
             target:(id)target
             action:(SEL)action
{
    if (self = [super init])
    {
        self.itemStyle = BarButtonItemStyleBordered;
        self.btnImage = image;
        self.btnHilightImage = highligImage;
        self.target = target;
        self.action = action;
    }
    
    return self;
}

- (id)initWithCustomView:(UIView *)view
{
    if (self = [super init])
    {
        self.itemStyle = BarButtonItemStyleCustom;
        self.customView = view;
    }
    
    return self;
}









@end
