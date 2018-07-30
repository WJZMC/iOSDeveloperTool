//
//  UIView+XC_Frame.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIView (XC_Frame)

/**
 *  起点x坐标
 */
@property (nonatomic, assign) CGFloat xc_x;
/**
 *  起点y坐标
 */
@property (nonatomic, assign) CGFloat xc_y;
/**
 *  中心点x坐标
 */
@property (nonatomic, assign) CGFloat xc_centerX;
/**
 *  中心点y坐标
 */
@property (nonatomic, assign) CGFloat xc_centerY;
/**
 *  宽度
 */
@property (nonatomic, assign) CGFloat xc_width;
/**
 *  高度
 */
@property (nonatomic, assign) CGFloat xc_height;
/**
 *  顶部
 */
@property (nonatomic, assign) CGFloat xc_top;
/**
 *  底部
 */
@property (nonatomic, assign) CGFloat xc_bottom;
/**
 *  左边
 */
@property (nonatomic, assign) CGFloat xc_left;
/**
 *  右边
 */
@property (nonatomic, assign) CGFloat xc_right;


/**
 *  size
 */
@property (nonatomic, assign) CGSize xc_size;
/**
 *  起点坐标
 */
@property (nonatomic, assign) CGPoint xc_origin;


@end
