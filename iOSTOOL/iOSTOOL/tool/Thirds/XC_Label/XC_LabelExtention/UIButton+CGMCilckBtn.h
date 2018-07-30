//
//  UIButton+CGMCilckBtn.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import <UIKit/UIKit.h>

#import <objc/runtime.h>

typedef void (^CGMcilckCallBack)(UIButton *btn);

@interface UIButton (CGMCilckBtn)


-(void)CgmCilckBtn:(UIControlEvents )Everns AndCGMCallCback:(CGMcilckCallBack )CGMCallBack;

@end
