//
//  WJImageTitleBtn.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "WJImageTitleBtn.h"
@interface WJImageTitleBtn()
@property(nonatomic,strong) NSString*selectImage;
@property(nonatomic,strong) NSString *nomalImage;
@property(nonatomic,strong) UIColor *selectColor;
@property(nonatomic,strong) UIColor *nomalColor;
@end
@implementation WJImageTitleBtn

-(id)initWithConfigDic:(NSDictionary*)dic
{
    if (self=[super init]) {
        self.selectImage=dic[@"selectImage"];
        self.nomalImage=dic[@"nomalImage"];
        self.selectColor=dic[@"selectColor"];
        self.nomalColor=dic[@"nomalColor"];

        self.bImage=[[UIImageView alloc]init];
        self.bImage.image=[UIImage imageNamed:self.nomalImage];
        [self addSubview:self.bImage];
        self.bTitle=[[UILabel alloc]init];
        self.bTitle.textAlignment=NSTextAlignmentCenter;
        self.bTitle.textColor=self.nomalColor;
//        self.bTitle.font=[[TDApplicationService getInstance]setFontWithSize:10 WithisBlod:NO];
        [self.bTitle setFont:[UIFont systemFontOfSize:10]];
        [self addSubview:self.bTitle];
    }
    return self;
}
-(void)setIsMystatus:(BOOL)isMystatus
{
    _isMystatus=isMystatus;
    if (isMystatus) {
        self.bImage.image=[UIImage imageNamed:self.selectImage];
        self.bTitle.textColor=self.selectColor;
    }else
    {
        self.bImage.image=[UIImage imageNamed:self.nomalImage];
        self.bTitle.textColor=self.nomalColor;
    }
}
@end
