//
//  UIView+STFrame.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIView (STFrame)

@property (nonatomic, assign) CGFloat st_x;
@property (nonatomic, assign) CGFloat st_y;
@property (nonatomic, assign) CGFloat st_width;
@property (nonatomic, assign) CGFloat st_height;
@property (nonatomic, assign) CGFloat st_centerX;
@property (nonatomic, assign) CGFloat st_centerY;
@property (nonatomic, assign) CGSize st_size;
@property (nonatomic, assign) CGFloat st_top;
@property (nonatomic, assign) CGFloat st_bottom;
@property (nonatomic, assign) CGFloat st_left;
@property (nonatomic, assign) CGFloat st_right;

@end
