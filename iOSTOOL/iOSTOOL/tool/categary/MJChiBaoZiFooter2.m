//
//  MJChiBaoZiFooter2.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import "MJChiBaoZiFooter2.h"

@implementation MJChiBaoZiFooter2
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"jiazaizhong%d", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"jiazaizhong%d", i]];
        [refreshingImages addObject:image];
    }
    
    
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}
- (void)setState:(MJRefreshState)state
{
    [super setState:state];
    if (state==MJRefreshStateNoMoreData) {
        self.stateLabel.hidden = NO;
    }else
    {
        self.stateLabel.hidden = YES;
    }
}
@end
