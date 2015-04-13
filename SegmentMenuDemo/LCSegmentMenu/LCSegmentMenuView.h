//
//  LCSegmentMenuView.h
//  Maracana_C
//
//  Created by minjie on 15-3-30.
//  Copyright (c) 2015年 linqi. All rights reserved.
//

#import "LCSegmentMenuItemView.h"


@class LCSegmentMenuView;
@class LCListMenuView;

@protocol LCSegmentMenuViewDelegate <NSObject>

@optional

/**
 *  返回segment按钮上的文字
 *
 *  @param segmentMenuView segmentMenuView
 *  @param section         第几个按钮项
 *
 *  @return 按钮上的文字
 */
- (NSString*)segmentMenuView:(LCSegmentMenuView*)segmentMenuView titleAtSection:(NSUInteger)section;

/**
 *  返回按钮上的图标（正常状态）
 *
 *  @param segmentMenuView segmentMenuView
 *  @param section         第几个按钮项
 *
 *  @return 图片对象
 */
- (UIImage*)segmentMenuView:(LCSegmentMenuView*)segmentMenuView imageAtSection:(NSUInteger)section;

/**
 *  返回按钮上的图标（选中状态）
 *
 *  @param segmentMenuView segmentMenuView
 *  @param section         第几个按钮项
 *
 *  @return 图片对象
 */
- (UIImage*)segmentMenuView:(LCSegmentMenuView*)segmentMenuView selectedImageAtSection:(NSUInteger)section;

/**
 *  返回展开后的标题文字数组
 *
 *  @param segmentMenuView segmentMenuView
 *  @param section         第几个按钮项
 *
 *  @return title数组
 */
- (NSArray*)titlesInSegmentMenuView:(LCSegmentMenuView*)segmentMenuView atSection:(NSUInteger)section;

/**
 *  当前选中项的index
 *
 *  @param segmentMenuView segmentMenuView
 *  @param section         第几个按钮项
 *
 *  @return 第section个菜单第几项被选中
 */
- (NSUInteger)currentIndexInSegmentMenuView:(LCSegmentMenuView*)segmentMenuView atSection:(NSUInteger)section;

/**
 *  用户点击了某个菜单
 *
 *  @param segmentMenuView segmentMenuView
 *  @param indexPath       点击的位置
 */
- (void)segmentMenuView:(LCSegmentMenuView*)segmentMenuView didSelectAtIndexPath:(NSIndexPath*)indexPath;

@end

@interface LCSegmentMenuView : UIView

@property (nonatomic,assign,readonly) NSUInteger itemCount;

@property (nonatomic,assign,readonly) LCSegmentMenuStyle style;

@property (nonatomic,assign) id<LCSegmentMenuViewDelegate> delegate;

@property (nonatomic,assign) NSInteger selectIndex;

/**
 *  初始化方法
 *
 *  @param frame         frame
 *  @param containerView 父view，因为弹出菜单要add在上面
 *  @param itemCount     item数量
 *  @param style         目前只支持纯文字和文字图片两种
 *
 *  @return 对象实例
 */
- (instancetype)initWithFrame:(CGRect)frame
                containerView:(UIView*)containerView
                    itemCount:(NSUInteger)itemCount
                        style:(LCSegmentMenuStyle)style;

/**
 *  更新菜单显示
 */
- (void)reload;

/**
 *  用户选中之后的回调，目前只有LCListMenu调用，不应该作为public方法
 *
 *  @param indexPath 点击的位置
 */
- (void)didSelectedAtIndexPath:(NSIndexPath*)indexPath;

/**
 *  隐藏弹出菜单
 */
- (void)hide;

@end
