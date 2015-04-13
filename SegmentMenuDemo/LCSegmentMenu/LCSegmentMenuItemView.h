//
//  LCSegmentMenuItemView.h
//  Maracana_C
//
//  Created by minjie on 15-3-30.
//  Copyright (c) 2015年 linqi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LCSegmentMenuStyle) {
    LCSegmentMenuStyle_Text = 0,
    LCSegmentMenuStyle_ImageText
};

@interface LCSegmentMenuItemView : UIView

/**
 *  类型
 */
@property (nonatomic,assign,readonly) LCSegmentMenuStyle style;

/**
 *  正常状态的图片
 */
@property (nonatomic,strong) UIImage* normalImage;

/**
 *  选中状态的图片
 */
@property (nonatomic,strong) UIImage* highlightImage;

/**
 *  标题
 */
@property (nonatomic,copy) NSString* title;

/**
 *  是否选中
 */
@property (nonatomic,assign) BOOL selected;

/**
 *  分隔线
 */
@property (nonatomic,strong) UIView* sepLineView;

/**
 *  点击按钮
 */
@property (nonatomic,strong) UIButton* button;

/**
 *  初始化方法
 *
 *  @param frame frame
 *  @param style 类型
 *
 *  @return 对象实例
 */
- (instancetype)initWithFrame:(CGRect)frame style:(LCSegmentMenuStyle)style;

/**
 *  更新UI
 */
- (void)bindDataToUI;

@end
