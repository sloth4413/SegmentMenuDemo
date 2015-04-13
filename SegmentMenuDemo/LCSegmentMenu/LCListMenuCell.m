//
//  LCListMenuCell.m
//  Maracana_C
//
//  Created by minjie on 15-4-2.
//  Copyright (c) 2015年 linqi. All rights reserved.
//

#import "LCListMenuCell.h"

@implementation LCListMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(15, 10, 200, 20);
    
}

@end
