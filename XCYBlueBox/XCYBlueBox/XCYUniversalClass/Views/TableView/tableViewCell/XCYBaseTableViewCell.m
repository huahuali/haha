//
//  XCYBaseTableViewCell.m
//  XCYBusinessCard
//
//  Created by XCY on 15-3-5.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#import "XCYBaseTableViewCell.h"

@implementation XCYBaseTableViewCell


#pragma mark 通用方法
+(NSString*)cellIdendifier{
    return NSStringFromClass([self class]);
}

+(id)cellForTableView:(UITableView *)aTabel fromNib:(UINib *)aNib{
    
    NSString* cellId = [self cellIdendifier];
    UITableViewCell *cell = [aTabel dequeueReusableCellWithIdentifier:cellId];
    if(nil == cell){
        
        NSArray *nibObjects = [aNib instantiateWithOwner:nil options:nil];
        
        NSAssert2(([nibObjects count] > 0) &&
                  [[nibObjects objectAtIndex:0] isKindOfClass:[self class]],
                  @"Nib '%@' does not appear to contain a valid %@",
                  [self nibName], NSStringFromClass([self class]));
        
        cell = [nibObjects objectAtIndex:0];
        
    }
    return cell;
}

#pragma mark -
#pragma mark Nib 支持

+ (UINib *)nib {
    NSBundle *classBundle = [NSBundle bundleForClass:[self class]];
    return [UINib nibWithNibName:[self nibName] bundle:classBundle];
}

+ (NSString *)nibName {
    return [self cellIdendifier];
}


@end
