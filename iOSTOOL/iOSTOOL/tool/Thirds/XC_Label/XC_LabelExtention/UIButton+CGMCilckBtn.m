//
//  UIButton+CGMCilckBtn.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import "UIButton+CGMCilckBtn.h"

static const  void *CGMbtnKey = &CGMbtnKey;

@implementation UIButton (CGMCilckBtn)


-(void)CgmCilckBtn:(UIControlEvents)Everns AndCGMCallCback:(CGMcilckCallBack)CGMCallBack{

    objc_setAssociatedObject(self, CGMbtnKey, CGMCallBack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addTarget:self action:@selector(cilckBtn:) forControlEvents:Everns];
    
}

-(void)cilckBtn:(UIButton *)sender{

     CGMcilckCallBack callBack = objc_getAssociatedObject(sender, CGMbtnKey);
    if (callBack) {
        callBack(sender);
    }
}


@end
