//
//  ViewController.m
//  SegmentMenuDemo
//
//  Created by minjie on 15/4/13.
//  Copyright (c) 2015年 tenric. All rights reserved.
//

#import "ViewController.h"
#import "LCSegmentMenuView.h"

@interface ViewController ()<LCSegmentMenuViewDelegate>

@property (nonatomic,strong) LCSegmentMenuView* menuView;
@property (nonatomic,strong) NSMutableArray* menuTitles;
@property (nonatomic,strong) NSMutableArray* subMenuTitles;
@property (nonatomic,strong) NSMutableArray* menuIndexs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.menuTitles = [@[@"菜单1",@"菜单2",@"菜单3"] mutableCopy];
    self.subMenuTitles = [@[@"子菜单1",@"子菜单2",@"子菜单3",@"子菜单4",@"子菜单5",@"子菜单6"] mutableCopy];
    
    self.menuIndexs = [@[@0,@0,@0] mutableCopy];
    
    CGRect rect = CGRectMake(0, 50, self.view.frame.size.width, 35);
    self.menuView = [[LCSegmentMenuView alloc] initWithFrame:rect
                                               containerView:self.view
                                                   itemCount:3
                                                       style:LCSegmentMenuStyle_Text];
    self.menuView.delegate = self;
    
    [self.view addSubview:self.menuView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - LCSegmentMenuViewDelegate

- (NSString*)segmentMenuView:(LCSegmentMenuView*)segmentMenuView titleAtSection:(NSUInteger)section
{
    return self.menuTitles[section];
}

- (NSArray*)titlesInSegmentMenuView:(LCSegmentMenuView*)segmentMenuView atSection:(NSUInteger)section
{
    if (section == 0) {
        
        return self.subMenuTitles;
    }
    else if(section == 1){
        
        return self.subMenuTitles;
    }
    else if(section == 2){
        
        return self.subMenuTitles;
    }
    return nil;
}

- (NSUInteger)currentIndexInSegmentMenuView:(LCSegmentMenuView*)segmentMenuView atSection:(NSUInteger)section
{
    return [self.menuIndexs[section] integerValue];
}

- (void)segmentMenuView:(LCSegmentMenuView*)segmentMenuView didSelectAtIndexPath:(NSIndexPath*)indexPath
{
    
    self.menuTitles[indexPath.section] = self.subMenuTitles[indexPath.row];
}

@end
