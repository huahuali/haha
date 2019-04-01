//
//  XCYBaseCell.h
//  XCY
//
//  Created by XCY on 15-3-5.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCYBaseCell : UITableViewCell

//封装cell重用接口
+(id)cellForTableView:(UITableView*)aTableView;

+(id)cellForTableView:(UITableView *)aTableView
            cellStyle:(NSInteger)cellType;

//获取cell 标记ID
+(NSString *)cellIdentifier;
//默认构造函数
-(id)initWithCellIndetifier:(NSString*)aReuseId;
//附带cell样式
-(instancetype)initWithCellIndetifier:(NSString*)aReuseId
                            cellStyle:(NSInteger)cellType;
@end
