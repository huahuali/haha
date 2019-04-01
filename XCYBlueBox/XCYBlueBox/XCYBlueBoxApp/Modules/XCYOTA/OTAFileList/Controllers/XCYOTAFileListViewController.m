//
//  XCYOTAFileListViewController.m
//  XCYBlueBox
//
//  Created by XCY on 2017/4/23.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYOTAFileListViewController.h"
#import "XCYEQLoadTableCell.h"
#import "XCYOTAFileBusiness.h"
#import "XCYCommonUIUtil.h"

@interface XCYOTAFileListViewController ()
<UITableViewDataSource,
UITableViewDelegate>


@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) XCYOTAFileBusiness *fileBusiness;

@property (strong, nonatomic) NSArray<NSString *> *tableList;

@end

@implementation XCYOTAFileListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _tableList = [self.fileBusiness getOTAbinFileList];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *fileName = [_tableList objectAtIndex_xcy:indexPath.row];
    
    UINib *nib = [XCYEQLoadTableCell nib];
    XCYEQLoadTableCell *cell = [XCYEQLoadTableCell cellForTableView:tableView fromNib:nib];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.bleNameLabel setText:fileName];
    
    if (indexPath.row == 0) {
        
        [XCYCommonUIUtil addTopLineToView:cell withColor:[UIColor hexColor_xcy:@"A6A6AD"]];
    }
    
    
    if (indexPath.row == (_tableList.count -1)) {
        
        [XCYCommonUIUtil addBottomLineToView:cell withColor:[UIColor hexColor_xcy:@"A6A6AD"]];
    }
    else
    {
        [XCYCommonUIUtil addBottomLineToView:cell withColor:[UIColor hexColor_xcy:@"A6A6AD"] originX:10];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor clearColor]];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor clearColor]];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *filePath = [_tableList objectAtIndex_xcy:indexPath.row];
    
    if ([_eventDelegate respondsToSelector:@selector(userChoiceOTAFile:)]) {
        
        [_eventDelegate userChoiceOTAFile:filePath];
    }
}



#pragma mark - setter or getter
- (UITableView *)tableView
{
    if (_tableView) {
        return _tableView;
    }
    
    CGSize titleSize = XCYTitleBarSize();
    CGRect frame = CGRectMake(0, titleSize.height, self.view.width_xcy, self.view.height_xcy-titleSize.height);
    
    //  CGRect frame = CGRectMake(0, 0, self.view.width_xcy, self.view.height_xcy);
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.autoresizesSubviews = NO;
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    
    if ([_tableView respondsToSelector:@selector(setSectionIndexColor:)])
    {
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = [UIColor grayColor];
    }
    
    return _tableView;
}

- (XCYOTAFileBusiness *)fileBusiness
{
    if (_fileBusiness) {
        
        return _fileBusiness;
    }
    
    _fileBusiness = [[XCYOTAFileBusiness alloc] init];
    return _fileBusiness;
}

@end
