//
//  LCSegmentMenuItemView.m
//  Maracana_C
//
//  Created by minjie on 15-3-30.
//  Copyright (c) 2015年 linqi. All rights reserved.
//

#import "LCSegmentMenuItemView.h"

#define kImageSize 23.0f

@interface LCSegmentMenuItemView()

@property (nonatomic,strong) UILabel* titleLabel;

@property (nonatomic,strong) UIImageView* imageView;

@property (nonatomic,strong) UIImageView* arrowView;

@property (nonatomic,strong) UIImageView* selectedArrowImageView;

@end

@implementation LCSegmentMenuItemView

- (instancetype)initWithFrame:(CGRect)frame style:(LCSegmentMenuStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _style = style;
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:self.button];
        
        if (style == LCSegmentMenuStyle_ImageText) {
            
            CGRect rect = CGRectMake((frame.size.width-kImageSize)/2, 5, kImageSize, kImageSize);
            self.imageView = [[UIImageView alloc] initWithFrame:rect];
            [self addSubview:self.imageView];
            
            rect = CGRectMake(0, 10+kImageSize, frame.size.width, 12);
            self.titleLabel = [[UILabel alloc] initWithFrame:rect];
            self.titleLabel.backgroundColor = [UIColor clearColor];
            self.titleLabel.textColor = [UIColor blueColor];
            self.titleLabel.font = [UIFont systemFontOfSize:12];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.titleLabel];
            
            rect = CGRectMake(self.frame.size.width-30, 11, 12, 6);
            self.arrowView = [[UIImageView alloc] initWithFrame:rect];
            self.arrowView.image = [UIImage imageNamed:@"down_arrow.png"];
            [self addSubview:self.arrowView];
            
            rect = CGRectMake(self.frame.size.width-1, 8, 1, 34);
            self.sepLineView = [[UIView alloc] initWithFrame:rect];
            self.sepLineView.backgroundColor = [UIColor blackColor];
            [self addSubview:self.sepLineView];
        
        }
        else if (style == LCSegmentMenuStyle_Text) {
            
            CGRect rect = CGRectMake(0, 10, frame.size.width, 18);
            self.titleLabel = [[UILabel alloc] initWithFrame:rect];
            self.titleLabel.backgroundColor = [UIColor clearColor];
            self.titleLabel.textColor = [UIColor grayColor];
            self.titleLabel.font = [UIFont systemFontOfSize:14];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.titleLabel];
            
            rect = CGRectMake(self.frame.size.width-22, 15, 14, 7);
            self.arrowView = [[UIImageView alloc] initWithFrame:rect];
            self.arrowView.image = [UIImage imageNamed:@"down_arrow.png"];
            [self addSubview:self.arrowView];
            
            rect = CGRectMake(self.frame.size.width-1, 8, 1, 20);
            self.sepLineView = [[UIView alloc] initWithFrame:rect];
            self.sepLineView.backgroundColor = [UIColor blackColor];
            [self addSubview:self.sepLineView];
            
        }
        
        CGRect rect = CGRectMake((frame.size.width-9)/2, frame.size.height-7, 9, 7);
        self.selectedArrowImageView = [[UIImageView alloc] initWithFrame:rect];
        self.selectedArrowImageView.image = [UIImage imageNamed:@"pop_arrow.png"];
        self.selectedArrowImageView.hidden = !self.selected;
        [self addSubview:self.selectedArrowImageView];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected
{
//    if (_selected != selected) {
//        
//        [self rotateArrow];
//    }
    _selected = selected;
    
    [self bindDataToUI];
    
}

- (void)rotateArrow
{
    CABasicAnimation* rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    if (_selected) {
        rotateAnimation.fromValue = [NSNumber numberWithFloat:M_PI];
        rotateAnimation.toValue = [NSNumber numberWithFloat:0];
    }
    else {
        rotateAnimation.fromValue = [NSNumber numberWithFloat:0];
        rotateAnimation.toValue = [NSNumber numberWithFloat:M_PI];
    }
    
    rotateAnimation.duration = 0.3;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    [self.arrowView.layer addAnimation:rotateAnimation forKey:@"rotationAnimation"];
}


- (void)bindDataToUI
{
    self.selectedArrowImageView.hidden = !self.selected;
    self.titleLabel.text = self.title;
    if (_selected) {
        self.selectedArrowImageView.hidden = NO;
        self.titleLabel.textColor = [UIColor yellowColor];
        self.arrowView.image = [UIImage imageNamed:@"down_arrow_touch.png"];
        if (_style == LCSegmentMenuStyle_ImageText) {
            self.imageView.image = self.highlightImage;
        }
    }
    else {
        self.selectedArrowImageView.hidden = YES;
        self.titleLabel.textColor = [UIColor grayColor];
        self.arrowView.image = [UIImage imageNamed:@"down_arrow.png"];
        if (_style == LCSegmentMenuStyle_ImageText) {
            self.imageView.image = self.normalImage;
        }
        
    }
}

@end
