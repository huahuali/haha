//
//  XCYTopBar.m
//  XCYBusinessCard
//
//  Created by XCY on 15-2-9.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "XCYTopBar.h"
#import "XCYTopBarButtonItem.h"

@interface XCYTopBar ()

//导航栏背景图片视图
@property(nonatomic, retain)UIImageView *bgImageView;

@property(nonatomic, retain)UIButton *leftButton;

@property(nonatomic, retain)UIButton *rightButton;

@property(nonatomic, retain)UIImageView *titleImageView;

@property(nonatomic, retain)UILabel *mainTitleLabel;

/**
 * 加载背景视图
 */
-(void)addBgImageView;

/**
 * 加载标题图片
 */
-(void)addBarTitleImageView;

/**
 * 加载标题字
 */
-(void)addBarMainTitleLabel;

/**
 * 加载左按钮
 */
-(void)addLeftButton;

/**
 * 加载右按钮
 */
-(void)addRightButton;

/**
 * 设置topBar背景图片
 */
-(void)initBarBackgroundImage;

/**
 * 设置左按钮
 */
-(void)initLeftBarButton;

/** 
 * 设置大标题
 */
-(void)initMainBarTitle;

/**
 * 设置右侧按钮
 */
-(void)initRightBarButton;

@end

@implementation XCYTopBar


-(instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame])
    {
        //self.backgroundColor = [UIColor hexColor_xcy:@"#1FBCD2"];
        self.bgImage = [UIImage imageNamed:XCYTopBar_BackgroundImage];
    }
    
    return self;
}

/**
 * 加载背景视图
 */
-(void)addBgImageView
{
    CGRect mainframe = self.bounds;
    CGRect frame = CGRectMake(mainframe.origin.x,
                              mainframe.origin.y,
                              mainframe.size.width,
                              mainframe.size.height);
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [imageView setBackgroundColor:[UIColor clearColor]];
    
    [imageView setImage:_bgImage];
    
    self.bgImageView = imageView;
    
    [self addSubview:_bgImageView];
}

/** 
 * 加载标题图片
 */
-(void)addBarTitleImageView
{
    CGRect mainframe = self.bounds;
    CGRect frame = CGRectMake((mainframe.size.width-XCY_BarTitleImage_Width)/2,
                              mainframe.origin.y+iphoneStatusBarHeight,
                              XCY_BarTitleImage_Width,
                              mainframe.size.height-iphoneStatusBarHeight);
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [imageView setBackgroundColor:[UIColor clearColor]];
    
    self.titleImageView = imageView;
    
    [self addSubview:_titleImageView];
}

/** 
 * 加载标题字
 */
-(void)addBarMainTitleLabel
{
    CGRect frame = CGRectMake((self.bounds.size.width-XCY_BarTitleImage_Width)/2,
                              20,
                              XCY_BarTitleImage_Width,
                              self.bounds.size.height-20);
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
    [label setLineBreakMode:NSLineBreakByTruncatingTail];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:XCY_BarTitle_FontSize]];
    [label setAdjustsFontSizeToFitWidth:YES];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    
    self.mainTitleLabel = label;
    
    [self addSubview:_mainTitleLabel];
}

/**
 * 加载左按钮
 */
-(void)addLeftButton
{
    CGRect mainframe = self.bounds;//起始位置为0,0
    
    CGRect frame = CGRectMake(0,
                              (mainframe.size.height-iphoneStatusBarHeight-XCY_BarButton_Height)/2+iphoneStatusBarHeight,
                              XCY_BarButton_Width,
                              XCY_BarButton_Height);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:XCY_BarButton_FontSize]];
    [btn.titleLabel setAdjustsFontSizeToFitWidth:NO];
    
    self.leftButton = btn;
    
    [self addSubview:_leftButton];
}

/** 
 * 加载右按钮
 */
-(void)addRightButton
{
    CGRect mainframe = self.bounds;
    CGRect frame = CGRectMake(mainframe.size.width-XCY_BarButton_Width,
                              (mainframe.size.height-iphoneStatusBarHeight-XCY_BarButton_Height)/2+iphoneStatusBarHeight,
                              XCY_BarButton_Width,
                              XCY_BarButton_Height);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setTextAlignment:NSTextAlignmentRight];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:XCY_BarButton_FontSize]];
    [btn.titleLabel setAdjustsFontSizeToFitWidth:NO];
    
    self.rightButton = btn;
    
    [self addSubview:_rightButton];
}

-(void)initBarBackgroundImage
{
    if (!_bgImageView)
    {
       [self addBgImageView];
    }
    else
    {
        _bgImageView.image = _bgImage;
    }
}

-(void)initLeftBarButton
{
    if ([_leftButton isDescendantOfView:self])
    {
        [_leftButton removeFromSuperview];
    }
    
    if (_leftButtonItem)
    {
        if (_leftButtonItem.customView)
        {
            [self addSubview:_leftButtonItem.customView];
        }
        else
        {
            [self addLeftButton];
            
            if (_leftButtonItem.btnImage)
            {
                [_leftButton setBackgroundImage:_leftButtonItem.btnImage forState:UIControlStateNormal];
            }
            
            if (_leftButtonItem.btnHilightImage)
            {
                [_leftButton setBackgroundImage:_leftButtonItem.btnHilightImage forState:UIControlStateHighlighted];
            }
            
            if (_leftButtonItem.btnTitle)
            {
                [_leftButton setTitle:_leftButtonItem.btnTitle forState:UIControlStateNormal];
            }
            
            [_leftButton addTarget:_leftButtonItem.target action:_leftButtonItem.action forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

-(void)initMainBarTitle
{
    if ([_mainTitleLabel isDescendantOfView:self])
    {
        [_mainTitleLabel removeFromSuperview];
    }
    
    if (![NSString strNilOrEmpty_xcy:_mainTitle])
    {
        [self addBarMainTitleLabel];
        
        _mainTitleLabel.text = _mainTitle;
    }
}

-(void)initBarTitleImage
{
    if ([_titleImageView isDescendantOfView:self])
    {
        [_titleImageView removeFromSuperview];
    }
    
    if (_titleImage)
    {
        [self addBarTitleImageView];
        
        [_titleImageView setImage:_titleImage];
    }
}

-(void)initRightBarButton
{
    if ([_rightButton isDescendantOfView:self])
    {
        [_rightButton removeFromSuperview];
    }
    
    if (_rightButtonItem)
    {
        if (_rightButtonItem.customView)
        {
            [self addSubview:_rightButtonItem.customView];
        }
        else
        {
            [self addRightButton];
            
            if (_rightButtonItem.btnImage)
            {
                [_rightButton setBackgroundImage:_rightButtonItem.btnImage forState:UIControlStateNormal];
            }
            
            if (_rightButtonItem.btnHilightImage)
            {
                [_rightButton setBackgroundImage:_rightButtonItem.btnHilightImage forState:UIControlStateHighlighted];
            }
            
            if (_rightButtonItem.btnTitle)
            {
                [_rightButton setTitle:_rightButtonItem.btnTitle forState:UIControlStateNormal];
            }
            
            [_rightButton addTarget:_rightButtonItem.target action:_rightButtonItem.action forControlEvents:UIControlEventTouchUpInside];
        }
    }

}

/**
 * 更新背景
 */
-(void)setBgImage:(UIImage *)bgImage
{
    if (_bgImage != bgImage)
    {
        _bgImage = bgImage;
        
        [self initBarBackgroundImage];
    }
}

/**
 * 更新标题
 */
-(void)setMainTitle:(NSString *)mainTitle
{
    if (_mainTitle != mainTitle)
    {
        _mainTitle = [mainTitle copy];
        
        [self initMainBarTitle];
    }
}

/**
 * 更新左按钮
 */
-(void)setLeftButtonItem:(XCYTopBarButtonItem *)leftButtonItem
{
    if (_leftButtonItem != leftButtonItem)
    {
        if (_leftButtonItem.customView)
        {
            [_leftButtonItem.customView removeFromSuperview];
        }
        
        _leftButtonItem = leftButtonItem;
        
        [self initLeftBarButton];
    }
}

/**
 * 更新右按钮
 */
-(void)setRightButtonItem:(XCYTopBarButtonItem *)rightButtonItem
{
    if (_rightButtonItem != rightButtonItem)
    {
        if (_rightButtonItem.customView)
        {
            [_rightButtonItem.customView removeFromSuperview];
        }
        
        _rightButtonItem = rightButtonItem;
        
        [self initRightBarButton];
    }
}


@end
