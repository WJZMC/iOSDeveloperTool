//
//  MVPTableViewCell.m
//  iOSTool
//
//  Created by jack wei on 2018/8/7.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "MVPTableViewCell.h"
#import "config.h"
@implementation MVPTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubView];
    }
    return self;
}
-(void)initSubView
{
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.add];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).with.offset(100);
        make.width.mas_equalTo(100);
    }];
    
    [self.add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).with.offset(-100);
        make.width.mas_equalTo(kTransformP(100));
    }];
    
}
- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = kBlackColor;
        _label.font =kFontNomal(12);
        _label.numberOfLines = 2;
    }
    return _label;
}

-(UIButton*)add
{
    if (!_add) {
        _add=[[UIButton alloc]init];
        [_add setTitle:@"+" forState:UIControlStateNormal];
        [_add setTitleColor:kColor(@"000000") forState:UIControlStateNormal];
        [_add addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _add;
}
-(void)addAction:(UIButton*)sender
{
    NSInteger curent=[self.label.text integerValue];
    curent++;
    self.label.text=[NSString stringWithFormat:@"%ld",curent];
    if ([self.delegate respondsToSelector:@selector(addActionWith:)]) {
        [self.delegate addActionWith:self.indexPathRow];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
