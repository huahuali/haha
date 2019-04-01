//
//  XCYBaseTableViewCell.h
//  XCYBusinessCard
//
//  Created by XCY on 15-3-5.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCYBaseTableViewCell : UITableViewCell

+(UINib*)nib;

+(NSString*)nibName;

+(NSString*)cellIdendifier;

+(id)cellForTableView:(UITableView*)aTabel fromNib:(UINib*)aNib;

@end
