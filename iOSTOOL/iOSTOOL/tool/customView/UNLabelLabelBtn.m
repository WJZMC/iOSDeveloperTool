//
//  UNLabelLabelBtn.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import "UNLabelLabelBtn.h"
@interface UNLabelLabelBtn()
{
    NSDictionary *configDic;
}
@end
@implementation UNLabelLabelBtn

-(id)initWithConfigDic:(NSDictionary*)dic
{
    if (self=[super init]) {
        configDic=dic;
        self.title=[[UILabel alloc]init];
        self.title.text=configDic[@"title"];;
        self.title.textAlignment=NSTextAlignmentCenter;
        self.title.textColor=configDic[@"titleColor"];
        [self addSubview:self.title];
        self.subTitle=[[UILabel alloc]init];
        self.subTitle.textAlignment=NSTextAlignmentCenter;
        self.subTitle.text=configDic[@"subtitle"];
        self.subTitle.textColor=configDic[@"subtitleColor"];
        [self addSubview:self.subTitle];
    }
    return self;
}
-(instancetype)init
{
    if (self=[super init]) {
        self.title=[[UILabel alloc]init];
        self.title.textAlignment=NSTextAlignmentCenter;
        [self addSubview:self.title];
        self.subTitle=[[UILabel alloc]init];
        self.subTitle.textAlignment=NSTextAlignmentCenter;
        [self addSubview:self.subTitle];
    }
    return self;
}

@end
