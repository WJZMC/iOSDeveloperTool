//
//  WJCircleBorderImageVIew.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
#import <UIKit/UIKit.h>

@interface WJCircleBorderImageVIew : UIView
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIColor *borderColor;
-(void)setCornerRadiusWithPW:(CGFloat)parentWith WithBorderW:(CGFloat)borderW;
@end
