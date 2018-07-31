//
//  MJChiBaoZiFooter.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import "MJChiBaoZiFooter.h"

@implementation MJChiBaoZiFooter
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
//    self.stateLabel.hidden = YES;
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
