//
//  NavView.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import <UIKit/UIKit.h>
#import "WPMacros.h"


@interface NavView : UIView

@property (nonatomic, copy) void(^navViewBack)();
@property (nonatomic, copy) void(^quitChooseBack)();

// 创建nav
-(void)createNavViewTitle:(NSString *)title;

@end
