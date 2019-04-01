//
//  XCYBaseCell.m
//  XCYBusinessCard
//
//  Created by XCY on 15-3-5.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "XCYBaseCell.h"

@implementation XCYBaseCell


+(id)cellForTableView:(UITableView *)aTableView{
    
    NSString *identiferId = [self cellIdentifier];
    UITableViewCell *tabelCell = [aTableView dequeueReusableCellWithIdentifier:identiferId];
    if(nil == tabelCell){
        tabelCell = [[self alloc]initWithCellIndetifier:identiferId];
    }
    return tabelCell;
}

+(id)cellForTableView:(UITableView *)aTableView
            cellStyle:(NSInteger)cellType
{
    NSString *identiferId = [self cellIdentifier];
    UITableViewCell *tabelCell = [aTableView dequeueReusableCellWithIdentifier:identiferId];
    if(nil == tabelCell){
        tabelCell = [[self alloc]initWithCellIndetifier:identiferId cellStyle:cellType];
    }
    return tabelCell;
}


+(NSString*)cellIdentifier{
    
    return NSStringFromClass([self class]);
    
}

-(id)initWithCellIndetifier:(NSString *)aReuseId{
    
    return  [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aReuseId];
    
}

-(id)initWithCellIndetifier:(NSString*)aReuseId
                  cellStyle:(NSInteger)cellType
{
    return nil;
}


@end
