//
//  UNNoDataView.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "UNNoDataView.h"
#import "config.h"
@interface UNNoDataView()
{
    NSString *cmsg;
}
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *detailLabel;
@property(nonatomic,copy) UNNoDataViewPublicBlock cBlock;
@end
@implementation UNNoDataView

-(instancetype)initWithFrame:(CGRect)frame WithMsg:(NSString *)msg WithCLickBlock:(UNNoDataViewPublicBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        _cBlock=block;
        cmsg=msg;
        [self addSubview:self.imgView];
        [self addSubview:self.detailLabel];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_top).with.offset(0);
//            make.size.mas_equalTo(CGSizeMake(kGetP(430/2.0), kGetP(192/2.0)));
            make.size.mas_equalTo(CGSizeMake(kTransformP(175), kTransformP(78)));
        }];
        
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView.mas_bottom).offset(kTransformP(60));
            make.left.right.equalTo(self);
            make.height.mas_equalTo(kTransformP(20));
        }];
        _detailLabel.text=cmsg;
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:cmsg];
        NSArray *tempArray=[UNApplicationTool getBBSLetterSubStrRangeArrWithStr:cmsg WithSubStr:@"登录"];
        for (int i=0; i<tempArray.count; i++) {
            if (i==tempArray.count-1) {
                NSRange range=[tempArray[i] range];
                [attrStr addAttribute:NSForegroundColorAttributeName value:kMainBlueColor range:range];
                [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
            }
        }
        _detailLabel.attributedText=attrStr;
        [UNApplicationTool layoutlabelWithlabel:_detailLabel];
    }
    return self;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"sy-chahua"];
    }
    return _imgView;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.font =kFontNomal(kTransformP(16));
        _detailLabel.textColor = kBlackColor;
        _detailLabel.text = cmsg;
        _detailLabel.textAlignment=NSTextAlignmentCenter;
        _detailLabel.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [_detailLabel addGestureRecognizer:tap];
    }
    return _detailLabel;
}
-(void)tapAction
{
    if (_cBlock) {
        _cBlock(@"");
    }
}
@end
