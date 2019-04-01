//
//  XCYTopBarButtonItem.h
//  XCYBusinessCard
//
//  Created by XCY on 15-2-10.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    BarButtonItemStyleBordered, //button为默认显示标题
    BarButtonItemStyleCustom,   //button为自定义
} BarButtonItemStyle;


@interface XCYTopBarButtonItem : NSObject

@property(nonatomic, readonly)UIView *customView;


//按钮显示名
@property(nonatomic, readonly)NSString *btnTitle;

//按钮图片名称
@property(nonatomic, readonly)UIImage *btnImage;

//按钮高亮图片名称
@property(nonatomic, readonly)UIImage *btnHilightImage;

//点击事件的响应方法
@property (nonatomic, readonly) SEL action;

//响应方法所在的类
@property (nonatomic, readonly) id target;

@property(nonatomic, readonly)BarButtonItemStyle itemStyle;


/**
 * 初始化topBar按钮
 *
 * @param title 按钮显示的名称
 * @param target 实现触发事件处理方法的类
 * @param action  触发事件处理的方法
 *
 * @return self topBar按钮对象
 */
- (id)initWithTitle:(NSString *)title
             target:(id)target
             action:(SEL)action;

/**
 * 初始化topBar按钮
 *
 * @param image 按钮不高亮的图片
 * @param highligImage 按钮高亮的图片
 * @param target 实现触发事件处理方法的类
 * @param action  触发事件处理的方法
 *
 * @return self topBar按钮对象
 */
- (id)initWithImage:(UIImage*)image
     highlightImage:(UIImage*)highligImage
             target:(id)target
             action:(SEL)action;

/**
 * 自定义topBar按钮，topBarButton即为view
 *
 * @param view 自定义的topBar按钮
 *
 * @return self topBar按钮对象
 */

- (id)initWithCustomView:(UIView *)view;

@end
