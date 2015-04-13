//
//  LCListMenuView.m
//  Maracana_C
//
//  Created by minjie on 15-4-2.
//  Copyright (c) 2015年 linqi. All rights reserved.
//

#import "LCListMenuView.h"
#import "LCListMenuCell.h"
#import "LCSegmentMenuView.h"

@interface LCListMenuView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView* tableView;

@end

@implementation LCListMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self addSubview:self.tableView];
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"LCListMenuCell";
    LCListMenuCell *cell = (LCListMenuCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[LCListMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLabel.text = self.titles[indexPath.row];
    
    if (indexPath.row == self.selectedIndex) {
        cell.titleLabel.textColor = [UIColor redColor];
        cell.contentView.backgroundColor = [UIColor grayColor];
    }
    else {
        cell.titleLabel.textColor = [UIColor darkGrayColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = self.segmentMenuView.selectIndex;
    NSInteger row = indexPath.row;
    NSIndexPath* path = [NSIndexPath indexPathForRow:row inSection:section];
    
    
    [self.segmentMenuView didSelectedAtIndexPath:path];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
