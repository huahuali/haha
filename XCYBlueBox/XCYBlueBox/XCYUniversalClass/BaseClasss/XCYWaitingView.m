//
//  XCYWaitingView.m
//  XCYSharKey
//
//  Created by XCY on 15-7-15.
//  Copyright (c) 2014年 XCY. All rights reserved.
//

#import "XCYWaitingView.h"

@interface XCYWaitingView()
//显示等待标题
@property(nonatomic,retain)UIView   *loadTitleView;
@property(nonatomic,retain)UILabel  *loadingTitleLabel;
@property(nonatomic,copy)NSString   *waitingTitle;
@property(nonatomic,assign)UIView   *superContainer;
-(void)initLoadingTitleView;
-(void)layoutViews;
-(void)clearAnotherWaitView:(UIView*)superView;
@end

@implementation XCYWaitingView

-(NSString*)waitingTitle
{
    NSString *title = @"加载中...";
    if(![NSString strNilOrEmpty_xcy:_waitingTitle])
    {
        title = _waitingTitle;
    }
    return title;
}

-(void)clearAnotherWaitView:(UIView*)superView
{
    for(UIView *view in superView.subviews)
    {
        if([view isKindOfClass:[XCYWaitingView class]])
        {
            [view removeFromSuperview];
            break;
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame
                    superView:(UIView*)superView
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor grayColor]];
        [self setAlpha:0.5];
        [self clearAnotherWaitView:superView];
        [self initLoadingTitleView];
        self.superContainer = superView;
        
        [self.superContainer addSubview:self];
        [self layoutViews];
        
        //addby:zhouhaoran,初始化并不意味着要显示，添加下面的这句话是使初始化后并不现实等待层。
        [self setHidden:YES];
    }
    
    return self;
}

-(instancetype)initWithSuperView:(UIView*)superView
                      maskedView:(UIView*)maskView;
{
    if(self = [super init])
    {
        [self setBackgroundColor:[UIColor grayColor]];
        [self setAlpha:0.5];
        [self clearAnotherWaitView:superView];
        [self initLoadingTitleView];
        self.superContainer = superView;
        self.frame = maskView.frame;

        [self.superContainer addSubview:self];
        [self layoutViews];
        
        //addby:zhouhaoran,初始化并不意味着要显示，添加下面的这句话是使初始化后并不现实等待层。
        [self setHidden:YES];
    }
    return self;
}

-(void)initLoadingTitleView
{
    self.loadTitleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 120,40)];
	[self.loadTitleView setAlpha:1.0];
	self.loadTitleView.layer.masksToBounds = YES;
	self.loadTitleView.layer.cornerRadius = 6;
	[self.loadTitleView setBackgroundColor:[UIColor blackColor]];
	
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
	[indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
	[indicator startAnimating];
	
	self.loadingTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 90, 30)];
	[self.loadingTitleLabel setBackgroundColor:[UIColor clearColor]];
	[self.loadingTitleLabel setFont:[UIFont systemFontOfSize:15]];
	[self.loadingTitleLabel setTextColor:[UIColor whiteColor]];
	[self.loadingTitleLabel setTextAlignment:NSTextAlignmentLeft];
	self.loadingTitleLabel.text = self.waitingTitle;
    [self.loadTitleView addSubview:indicator];
    [self.loadTitleView addSubview:self.loadingTitleLabel];
    [self addSubview:self.loadTitleView];
}

-(void)layoutViews
{
    CGRect frame = self.frame;
    CGPoint center = CGPointMake((frame.size.width)/2, (frame.size.height)/2);
    self.loadTitleView.center = center;
}



-(void)showWaitingView:(NSString*)title
{
    [self setHidden:NO];
    self.waitingTitle = title;
    self.loadingTitleLabel.text = self.waitingTitle;
}

-(void)hidenWaitingView
{
    [self setHidden:YES];
    [self.superContainer setUserInteractionEnabled:YES];

}

-(UIView*)waitingView
{
    return self;
}

@end
