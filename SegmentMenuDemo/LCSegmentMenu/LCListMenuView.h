//
//  LCListMenuView.h
//  Maracana_C
//
//  Created by minjie on 15-4-2.
//  Copyright (c) 2015年 linqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCSegmentMenuView;

/**
 *  弹出菜单
 */
@interface LCListMenuView : UIView

/**
 *  对应的segmentMenuView
 */
@property (nonatomic,weak) LCSegmentMenuView* segmentMenuView;

/**
 *  选中项
 */
@property (nonatomic,assign) NSInteger selectedIndex;

/**
 *  菜单数据
 */
@property (nonatomic,strong) NSArray* titles;

@end
