//
//  LCSegmentMenuView.m
//  Maracana_C
//
//  Created by minjie on 15-3-30.
//  Copyright (c) 2015年 linqi. All rights reserved.
//

#import "LCSegmentMenuView.h"
#import "LCListMenuView.h"

#define kMaxLineNumber   5

@interface LCSegmentMenuView()

@property (nonatomic,strong) NSMutableArray *menuViews;

@property (nonatomic,weak) UIView* container;

@property (nonatomic,strong) LCListMenuView* listMenuView;

@property (nonatomic,strong) UIView* maskView;

@end


@implementation LCSegmentMenuView

- (instancetype)initWithFrame:(CGRect)frame
                containerView:(UIView*)containerView
                    itemCount:(NSUInteger)itemCount
                        style:(LCSegmentMenuStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        _itemCount = itemCount;
        _style = style;
        _container = containerView;
        _selectIndex = -1;
        self.menuViews = [NSMutableArray array];
        
        self.backgroundColor = [UIColor whiteColor];
        [self buildMenuViews];
    }
    
    return self;
}

- (void)buildMenuViews
{
    LCSegmentMenuItemView* itemView;
    CGRect rect;
    CGFloat itemWidth = self.frame.size.width/self.itemCount;
    for (int i = 0; i < _itemCount; i++) {
        
        rect = CGRectMake(i*itemWidth, 0, itemWidth, self.frame.size.height);
        itemView = [[LCSegmentMenuItemView alloc] initWithFrame:rect style:self.style];
        itemView.sepLineView.hidden = (i == _itemCount-1);
        itemView.button.tag = i;
        [itemView.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:itemView];
        [self.menuViews addObject:itemView];
        
    }
}

- (void)setDelegate:(id<LCSegmentMenuViewDelegate>)delegate
{
    if (!_delegate)
    {
        _delegate = delegate;
        [self reload];
    }
    else
    {
        _delegate = delegate;
    }
}


- (void)reload
{
    for (int i = 0; i < _itemCount; i++) {
        if (self.style == LCSegmentMenuStyle_ImageText) {
            
            LCSegmentMenuItemView* itemView = self.menuViews[i];
            
            if ([self.delegate respondsToSelector:@selector(segmentMenuView:imageAtSection:)]) {
                UIImage* image = [self.delegate segmentMenuView:self imageAtSection:i];
                itemView.normalImage = image;
            }
            if ([self.delegate respondsToSelector:@selector(segmentMenuView:selectedImageAtSection:)]) {
                UIImage* image = [self.delegate segmentMenuView:self selectedImageAtSection:i];
                itemView.highlightImage = image;
            }
            
            if ([self.delegate respondsToSelector:@selector(segmentMenuView:titleAtSection:)]) {
                NSString* title = [self.delegate segmentMenuView:self titleAtSection:i];
                itemView.title = title;
            }
            
            [itemView bindDataToUI];
        }
        else if (self.style == LCSegmentMenuStyle_Text) {
            
            LCSegmentMenuItemView* itemView = self.menuViews[i];
            
            if ([self.delegate respondsToSelector:@selector(segmentMenuView:titleAtSection:)]) {
                NSString* title = [self.delegate segmentMenuView:self titleAtSection:i];
                itemView.title = title;
            }
            
            [itemView bindDataToUI];
        }
    }
    
}

- (void)didSelectedAtIndexPath:(NSIndexPath*)indexPath
{
    if (_selectIndex != -1) {
        LCSegmentMenuItemView* oldItemView = self.menuViews[_selectIndex];
        oldItemView.selected = NO;
        [self show:NO subMenusAtIndex:_selectIndex];
        _selectIndex = -1;
    }
    
    [self.delegate segmentMenuView:self didSelectAtIndexPath:indexPath];
    [self reload];
}
- (void)buttonClicked:(id)sender
{
    UIButton* button = (UIButton*)sender;
    NSInteger selectIndex = button.tag;
    LCSegmentMenuItemView* itemView = self.menuViews[selectIndex];
    if (_selectIndex == selectIndex) {
        itemView.selected = NO;
            
        [self show:NO subMenusAtIndex:_selectIndex];
        
        _selectIndex = -1;
        return;
    }
    
    if (_selectIndex != -1) {
        LCSegmentMenuItemView* oldItemView = self.menuViews[_selectIndex];
        oldItemView.selected = NO;
        [self show:NO subMenusAtIndex:_selectIndex];
    }
    
    
    itemView.selected = YES;
    [self show:YES subMenusAtIndex:selectIndex];
    
    _selectIndex = selectIndex;
}

- (void)show:(BOOL)show subMenusAtIndex:(NSUInteger)index
{
    if (show)
    {
        CGRect rect = [UIScreen mainScreen].bounds;
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame), rect.size.width, rect.size.height)];
        self.maskView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [self.maskView addGestureRecognizer:tapGesture];
        [self.container addSubview:self.maskView];
        
        NSArray* titles = [self.delegate titlesInSegmentMenuView:self atSection:index];
        NSInteger cellCount = titles.count > kMaxLineNumber ? kMaxLineNumber : titles.count;
        CGRect rectBegin = CGRectMake(0, CGRectGetMaxY(self.frame), self.frame.size.width, 0);
        CGRect rectEnd = CGRectMake(0, CGRectGetMaxY(self.frame), self.frame.size.width, cellCount*40);
        self.listMenuView = [[LCListMenuView alloc] initWithFrame:rectBegin];
        self.listMenuView.segmentMenuView = self;
        self.listMenuView.titles = titles;
        self.listMenuView.selectedIndex = [self.delegate currentIndexInSegmentMenuView:self atSection:index];
        [self.container addSubview:self.listMenuView];
        
        [UIView transitionWithView:self.listMenuView
         
                          duration:0.5
                           options:UIViewAnimationOptionLayoutSubviews //any animation
                        animations:^ {
                            self.listMenuView.frame = rectEnd;
                        }
                        completion:nil]; 
    }
    else
    {
        if (self.listMenuView)
        {
            [self.listMenuView removeFromSuperview];
        }
        
        if (self.maskView) {
            [self.maskView removeFromSuperview];
        }
    }
    
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    LCSegmentMenuItemView* itemView = self.menuViews[_selectIndex];
    itemView.selected = NO;
        
    [self show:NO subMenusAtIndex:_selectIndex];
        
    _selectIndex = -1;
    
}

- (void)hide
{
    if (_selectIndex != -1) {
        LCSegmentMenuItemView* itemView = self.menuViews[_selectIndex];
        itemView.selected = NO;
        [self show:NO subMenusAtIndex:_selectIndex];
        
        _selectIndex = -1;
    }
    
}

@end
