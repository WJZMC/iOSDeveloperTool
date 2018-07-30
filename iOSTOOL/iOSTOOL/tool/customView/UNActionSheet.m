//
//  UNActionSheet.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "UNActionSheet.h"
#import "config.h"
@interface UNActionSheet()
@property(nonatomic,copy) UNActionSheetBlock cBlock;

@property(nonatomic,strong) UIView *contentView;

@end
@implementation UNActionSheet

-(instancetype)initWithConfig:(NSArray*)config WithBlock:(UNActionSheetBlock)block
{
    if (self=[super init]) {
        _cBlock=block;
        [self initSubViewWithConfig:config];
    }
    return self;
}
-(void)initSubViewWithConfig:(NSArray*)config
{
    self.backgroundColor=[UIColor colorWithHex:0x000000 alpha:0.5];
    [self addSubview:self.contentView];
    
    self.contentView.height=config.count*kTransformP(55)+kViewSafeAreInsets(kWindows).bottom;
    CGFloat y=self.contentView.height-kTransformP(55)-kViewSafeAreInsets(kWindows).bottom;

    for (NSInteger i=config.count-1; i>=0; i--) {
        NSDictionary *subConfig=config[i];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, kTransformP(55))];
        btn.tag=10+i;
        [btn setTitle:subConfig[@"name"] forState:UIControlStateNormal];
        btn.titleLabel.font=subConfig[@"font"];
        [btn setTitleColor:subConfig[@"color"] forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        y-=kTransformP(55);
        
        if (i!=0) {
            UIView *line=[[UIView alloc]initWithFrame:CGRectMake(15, btn.x, kScreenWidth-15*2, 1)];
            line.backgroundColor=kColor(@"#b4b4b4");
            [self.contentView addSubview:line];
        }
        
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.x=kScreenHeight-self.contentView.height;
    }];
}
-(void)btnAction:(UIButton*)sender
{
    if (_cBlock) {
        _cBlock(sender.tag-10);
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.x=kScreenHeight-self.contentView.height;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(UIView*)contentView
{
    if (!_contentView) {
        _contentView=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth,0)];
        _contentView.backgroundColor=[UIColor whiteColor];
    }
    return _contentView;
}
@end
