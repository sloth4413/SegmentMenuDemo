//
//  LCListMenuCell.h
//  Maracana_C
//
//  Created by minjie on 15-2-2.
//  Copyright (c) 2015年 linqi. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  菜单cell
 */
@interface LCListMenuCell : UITableViewCell

/**
 *  目前比较简单，只有Label
 */
@property (nonatomic,strong) UILabel* titleLabel;

/**
 *  是否选中状态
 */
@property (nonatomic,assign) BOOL isSelected;

@end
