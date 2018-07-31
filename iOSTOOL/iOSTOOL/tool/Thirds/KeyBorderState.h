//
//  KeyBorderState.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import <UIKit/UIKit.h>

@interface KeyBorderState : NSObject

/**
 当键盘已经弹出时的回调并获取键盘的高度
 */
+ (void)getKeyboardHeighWith: (void (^) (CGFloat keyboardHeight))getKeyboardHeight;

/**
 当键盘将要消失时的回调
 */
+ (void)keyboardWillHide: (void (^) ())keyboardWillHide;

@end
