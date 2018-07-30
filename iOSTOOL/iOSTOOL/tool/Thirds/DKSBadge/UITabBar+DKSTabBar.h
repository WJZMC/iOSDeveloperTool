//
//  UITabBar+DKSTabBar.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import <UIKit/UIKit.h>

@interface UITabBar (DKSTabBar)

/**
 *  显示小红点
 *
 *  @param index 传入需要现实的位置
 */
- (void)showBadgeIndex:(NSInteger)index;

/**
 *  隐藏小红点
 *
 *  @param index 传入需要隐藏的位置
 */
- (void)hideBadgeIndex:(NSInteger)index;

@end
