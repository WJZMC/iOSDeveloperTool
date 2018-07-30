//
//  UITabBarItem+DKSBadge.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import <UIKit/UIKit.h>

@interface UITabBarItem (DKSBadge)

/**
 * 显示小红点
 * 需要在哪个item上面显示红点时，就用那个item调用
 */
- (void)showBadge;

/**
 * 隐藏小红点
 * 需要隐藏哪个item上面红点时，就用那个item调用
 */
- (void)hidenBadge;

@end
