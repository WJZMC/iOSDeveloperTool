//
//  WJCircleBorderImageVIew.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "WJCircleBorderImageVIew.h"
#import "config.h"
@interface WJCircleBorderImageVIew()
{
    
}
@end
@implementation WJCircleBorderImageVIew
-(instancetype)init
{
    if (self=[super init]) {
        [self initSubView];
    }
    return self;
}
-(void)initSubView
{
    self.imageView=[[UIImageView alloc]init];
    [self addSubview:self.imageView];

//    self.imageView.clipsToBounds=YES;
}
-(void)setBorderColor:(UIColor *)borderColor
{
    _borderColor=borderColor;
    self.backgroundColor=borderColor;
}
-(void)setCornerRadiusWithPW:(CGFloat)parentWith WithBorderW:(CGFloat)borderW
{
    
    self.imageView.contentMode=UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds=YES;
    self.layer.cornerRadius=parentWith/2.0;
    self.imageView.layer.borderColor=[UIColor clearColor].CGColor;
    self.imageView.layer.borderWidth=0.5;
    self.imageView.layer.cornerRadius=(parentWith-borderW)/2.0;
    self.imageView.clipsToBounds=YES;
    self.clipsToBounds=YES;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(borderW);
        make.left.equalTo(self.mas_left).with.offset(borderW);
        make.right.equalTo(self.mas_right).with.offset(-borderW);
        make.bottom.equalTo(self.mas_bottom).with.offset(-borderW);

    }];
}
@end
