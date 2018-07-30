//
//  TDAlertView.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "TDAlertView.h"
#import "config.h"
#define kleft_rightOffset kGetP(51)
@interface TDAlertView()
{
    NSString *downLoadUrl;

}
@property(nonatomic,copy) TDAlertViewBlock curentBlock;
@end
@implementation TDAlertView
-(instancetype)initWithBlockWithType:(TDTool_alert_type)type Withstr:(NSString *)strfist WithSecStr:(NSString*)strsec WithBtnTitleArray:(NSArray*)btnarray WithBlock:(TDAlertViewBlock)block
{
    if (self=[super init]) {
        
       
        self.curentBlock=block;
        if (strfist==nil) {
            strfist=@"";
        }
        if (strsec==nil) {
            strsec=@"";
        }
        self.backgroundColor=[UIColor colorWithHex:0x000000 alpha:0.5];

        if(type==TDTool_alert_type_update){
            [self initUpdateAlertWithstr:strfist WithSecStr:strsec WithBtnTitleArray:btnarray];
        }
        else
        {
            if (type==TDTool_alert_type_onebutton) {
                [self initOneButtonSubViewWithType:TDTool_alert_type_onebutton  Withstr:strfist WithSecStr:strsec WithBtnTitleArray:btnarray];
            }else
            {
                //2个按钮
                if (btnarray.count==2) {
                    [self initSubViewWithType:type Withstr:strfist WithSecStr:strsec WithBtnTitleArray:btnarray];
                }else
                {
                    [UNApplicationTool showAlertWithMsg:@"该类型需要有两个按钮" WithParentView:[[[UIApplication sharedApplication] delegate] window]];
                }
            }
           
        }
        
    }
    return self;
}
-(instancetype)initWithPriseAlertWithUUU:(NSString*)uuu WithBlock:(TDAlertViewBlock)block
{
    if (self=[super init]) {
        self.curentBlock=block;
        self.backgroundColor=[UIColor colorWithHex:0x000000 alpha:0.5];
        [self initPriseAlertWithUUU:uuu];
    }
    return self;
}
-(void)btnAction:(UIButton*)sender
{
    if (sender.tag-10==0) {
        [self leftbtnAction];
    }else if(sender.tag-10==1)
    {
        [self rightBtnAction];
    }
}
-(void)leftbtnAction
{
    self.curentBlock(0);
    [self removeFromSuperview];
}
-(void)rightBtnAction
{
     self.curentBlock(1);
    [self removeFromSuperview];
}
-(void)closeAction
{
    self.curentBlock(2);
    [self removeFromSuperview];
}
-(UIView*)getBG
{
    UIView *contentBG=[[UIView alloc]init];
    contentBG.layer.cornerRadius=kTransformP(10);
    contentBG.clipsToBounds=YES;
    contentBG.layer.masksToBounds=YES;
    contentBG.backgroundColor=[UIColor whiteColor];
    [UNApplicationTool addSquareShadowWithView:contentBG];
    return contentBG;
}
-(UILabel*)getTitle
{
    //titleLabel
    UILabel *fistlabel=[[UILabel alloc]init];
    fistlabel.font=kFontNomal(16);
    fistlabel.textColor=kColor(@"#3B3B3B");
    fistlabel.backgroundColor=[UIColor clearColor];
    fistlabel.textAlignment=NSTextAlignmentCenter;
    return fistlabel;
}
-(UILabel*)getSubTitle
{
    UILabel *seclabel=[[UILabel alloc]init];
    seclabel.font=kFontNomal(12);
    seclabel.textColor=kColor(@"#CBCBCB");
    seclabel.numberOfLines=0;
    seclabel.textAlignment=NSTextAlignmentCenter;
    return seclabel;
}
-(UIButton*)getCloseBtn
{
    UIButton *closeBtn=[[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"golbal_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    return closeBtn;
}
-(void)initSubViewWithType:(TDTool_alert_type)type Withstr:(NSString *)strfist WithSecStr:(NSString*)strsec WithBtnTitleArray:(NSArray*)btnarray
{
    UIView *contentBG=[self getBG];
    [self addSubview:contentBG];
    
    UIView *last=contentBG;
    if (strfist.length>0) {
        UILabel *fistlabel=[self getTitle];
        [contentBG addSubview:fistlabel];
        fistlabel.text=strfist;
        [fistlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentBG.mas_top).with.offset(kTransformP(17));
            make.height.mas_equalTo(kTransformP(22));
            make.left.equalTo(contentBG.mas_left).with.offset(kTransformP(29));
            make.right.equalTo(contentBG.mas_right).with.offset(kTransformP(-29));
        }];
        last=fistlabel;
    }
    if (strsec.length>0) {
        UILabel *seclabel=[self getSubTitle];
        [contentBG addSubview:seclabel];
        [seclabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (last==contentBG) {
                make.top.equalTo(contentBG.mas_top).with.offset(kTransformP(17));
            }else
            {
                make.top.equalTo(last.mas_bottom).with.offset(kTransformP(24));
            }
            make.left.equalTo(contentBG.mas_left).with.offset(kTransformP(29));
            make.right.equalTo(contentBG.mas_right).with.offset(kTransformP(-29));
        }];
        
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        paragraphStyle.lineSpacing=4;
        
        NSDictionary * attribute = @{NSFontAttributeName:seclabel.font,NSParagraphStyleAttributeName:paragraphStyle};
        NSMutableAttributedString *contentAttStr =[[NSMutableAttributedString alloc]initWithString:strsec];
        [contentAttStr addAttributes:attribute range:NSMakeRange(0,[strsec length])];
        NSMutableAttributedString *contentAttStr_color=[[NSMutableAttributedString alloc]initWithAttributedString:contentAttStr];
        [contentAttStr_color addAttribute:NSForegroundColorAttributeName value:seclabel.textColor range:NSMakeRange(0,[contentAttStr_color length])];
        
        //-------------特殊情况
        [contentAttStr_color addAttribute:NSForegroundColorAttributeName value:kColor(@"#5584E8") range:[strsec rangeOfString:@"完善备考信息"]];
        //---------------------
        
        seclabel.attributedText=contentAttStr_color;
        
        [UNApplicationTool layoutlabelWithMutilRow:seclabel];
        last=seclabel;
    }else
    {
        [UNApplicationTool showAlertWithMsg:@"副标题不能缺失" WithParentView:[[[UIApplication sharedApplication] delegate] window]];

    }
   
    UIView *line=[[UIView alloc]init];
    line.backgroundColor=kColor(@"#F6F6F6");
    [contentBG addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(last.mas_bottom).with.offset(kTransformP(22));
        make.left.right.equalTo(contentBG);
        make.height.mas_equalTo(kTransformP(2));
    }];
    UIView *line2=[[UIView alloc]init];
    line2.backgroundColor=kColor(@"#F6F6F6");
    [contentBG addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.centerX.equalTo(contentBG.mas_centerX);
        make.height.mas_equalTo(kTransformP(38));
        make.width.mas_equalTo(kTransformP(2));
    }];
    
    for (int i=0; i<btnarray.count; i++) {
        UIButton *btn=[[UIButton alloc]init];
        btn.tag=10+i;
        [btn setTitle:btnarray[i] forState:UIControlStateNormal];
        if (i==0) {
            [btn setTitleColor:kColor(@"#C6C6C6") forState:UIControlStateNormal];
        }else
        {
            [btn setTitleColor:kColor(@"#5584E8") forState:UIControlStateNormal];
        }
        btn.titleLabel.font=kFontNomal(18);
        [contentBG addSubview:btn];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(last.mas_bottom).with.offset(kTransformP(25));
            if (i==0) {
                make.left.equalTo(line.mas_left);
            }else
            {
                make.right.equalTo(line.mas_right);
            }
            make.width.equalTo(contentBG.mas_width).multipliedBy(1.0/btnarray.count);
            make.height.mas_equalTo(kTransformP(38));
        }];
        if (i==btnarray.count-1) {
            last=btn;
        }
    }
    
    [contentBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(15);
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.bottom.equalTo(last.mas_bottom).with.offset(0);
    }];
    
    BOOL iscanCancel=NO;
    
    if (type==TDTool_alert_type_default_canCancel) {
        iscanCancel=YES;
    }
    if (iscanCancel) {
        UIButton *closeBtn=[self getCloseBtn];
        [self addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentBG.mas_right);
            make.top.equalTo(contentBG.mas_top);
            make.size.mas_equalTo(CGSizeMake(kTransformP(44), kTransformP(44)));
        }];
    }
}
-(void)initPriseAlertWithUUU:(NSString*)uuu
{
    UIView *contentBG=[self getBG];
    contentBG.layer.cornerRadius=kTransformP(10);
    contentBG.clipsToBounds=YES;
    contentBG.layer.masksToBounds=YES;
    [self addSubview:contentBG];
    
    UIView *last=contentBG;
    
    UILabel *fistlabel=[self getTitle];
    [contentBG addSubview:fistlabel];
    fistlabel.text=@"操作将消耗";
    [fistlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentBG.mas_top).with.offset(kTransformP(17));
        make.height.mas_equalTo(kTransformP(22));
        make.left.equalTo(contentBG.mas_left).with.offset(kTransformP(29));
        make.right.equalTo(contentBG.mas_right).with.offset(kTransformP(-29));
    }];
    last=fistlabel;
    
    
    UILabel *uuuLabel=[[UILabel alloc]init];
    uuuLabel.font=kFontNomal(40);
    uuuLabel.textColor=kColor(@"#5584E8");
    uuuLabel.backgroundColor=[UIColor clearColor];
    uuuLabel.textAlignment=NSTextAlignmentCenter;;
    [contentBG addSubview:uuuLabel];
    uuuLabel.text=[NSString stringWithFormat:@"%@UUU",uuu];
    [uuuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(last.mas_bottom).with.offset(kTransformP(22));
        make.height.mas_equalTo(kTransformP(56));
        make.left.equalTo(contentBG.mas_left).with.offset(kTransformP(29));
        make.right.equalTo(contentBG.mas_right).with.offset(kTransformP(-29));
    }];
    
    //
//    [self reqeustUUUcountWithLabel:uuuLabel];
    
    NSDictionary * attribute = @{NSFontAttributeName:uuuLabel.font};
    NSMutableAttributedString *contentAttStr =[[NSMutableAttributedString alloc]initWithString:uuuLabel.text];
    [contentAttStr addAttributes:attribute range:NSMakeRange(0,[uuuLabel.text length])];
    NSMutableAttributedString *contentAttStr_color=[[NSMutableAttributedString alloc]initWithAttributedString:contentAttStr];
    
    //-------------特殊情况
    [contentAttStr_color addAttribute:NSFontAttributeName value:kFontNomal(22) range:[uuuLabel.text rangeOfString:@"UUU"]];
    //---------------------
    
    uuuLabel.attributedText=contentAttStr_color;
    [UNApplicationTool layoutlabelWithMutilRow:uuuLabel];
    
    last=uuuLabel;
    
    
    UILabel *seclabel=[self getSubTitle];
    [contentBG addSubview:seclabel];
    [seclabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(last.mas_bottom).with.offset(kTransformP(14));
        make.left.equalTo(contentBG.mas_left).with.offset(kTransformP(29));
        make.right.equalTo(contentBG.mas_right).with.offset(kTransformP(-29));
    }];
    seclabel.text=@"如果在您投票之后，有其他用户表达同样想法，您将从他们身上获得一定比例的UUU";
    [UNApplicationTool layoutlabelWithMutilRow:seclabel];
    last=seclabel;
    
    UIButton *btn=[[UIButton alloc]init];
    btn.tag=11;
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setBackgroundColor:kColor(@"#5584E8")];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=kFontNomal(20);
    [contentBG addSubview:btn];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [contentBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(15);
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.bottom.equalTo(seclabel.mas_bottom).with.offset(kTransformP(22)+kTransformP(47));
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(contentBG.mas_bottom).with.offset(0);
        make.width.equalTo(contentBG.mas_width);
        make.centerX.equalTo(contentBG.mas_centerX);
        make.height.mas_equalTo(kTransformP(47));
    }];
    
    UIButton *closeBtn=[self getCloseBtn];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentBG.mas_right);
        make.top.equalTo(contentBG.mas_top);
        make.size.mas_equalTo(CGSizeMake(kTransformP(44), kTransformP(44)));
    }];
    
}
-(void)initUpdateAlertWithstr:(NSString*)strfist WithSecStr:(NSString*)strsec WithBtnTitleArray:(NSArray*)btnarray
{
    downLoadUrl=btnarray[0];
    UIView *contentBG=[[UIView alloc]init];
    contentBG.backgroundColor=[UIColor clearColor];
    [self addSubview:contentBG];
    [contentBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kTransformP(397)+kTransformP(28));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).with.offset(15);
        make.right.equalTo(self.mas_right).with.offset(-15);
    }];
    
    UIView *witeBG=[[UIView alloc]init];
    witeBG.clipsToBounds=YES;
    witeBG.layer.cornerRadius=kTransformP(5);
    witeBG.backgroundColor=[UIColor whiteColor];
    [contentBG addSubview:witeBG];
    [UNApplicationTool addSquareShadowWithView:witeBG];
    [witeBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kTransformP(396));
        make.bottom.equalTo(contentBG.mas_bottom);
        make.left.right.equalTo(contentBG);
    }];
    
    UIImageView *topImage=[[UIImageView alloc]init];
    topImage.image=[UIImage imageNamed:@"global_update"];
    [contentBG addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentBG.mas_top).with.offset(0);
        make.left.right.equalTo(contentBG);
        make.height.mas_equalTo(kTransformP(132));
    }];
    
    UIView *last=contentBG;
    if (strfist.length>0) {
        UILabel *fistlabel=[self getTitle];
        fistlabel.textAlignment=NSTextAlignmentLeft;
        [contentBG addSubview:fistlabel];
        fistlabel.text=[NSString stringWithFormat:@"%@(%@)",strfist,btnarray[1]];
        [fistlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topImage.mas_bottom).with.offset(kTransformP(23));
            make.height.mas_equalTo(kTransformP(22));
            make.left.equalTo(contentBG.mas_left).with.offset(kTransformP(22));
            make.right.equalTo(contentBG.mas_right).with.offset(kTransformP(-22));
        }];
        last=fistlabel;
    }
    if (strsec.length>0) {
        UITextView *seclabel=[[UITextView alloc]init];
        seclabel.textContainerInset=UIEdgeInsetsZero;
        seclabel.editable=NO;
        seclabel.selectable=NO;
        seclabel.font=kFontNomal(12);
        seclabel.textColor=kColor(@"#ACACAC");
//        seclabel.numberOfLines=0;
        [contentBG addSubview:seclabel];
        [seclabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (last==contentBG) {
                make.top.equalTo(contentBG.mas_top).with.offset(kTransformP(17));
            }else
            {
                make.top.equalTo(last.mas_bottom).with.offset(kTransformP(12));
            }
            make.left.equalTo(contentBG.mas_left).with.offset(kTransformP(20));
            make.right.equalTo(contentBG.mas_right).with.offset(kTransformP(-20));
            make.height.mas_equalTo(kTransformP(168));
        }];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        paragraphStyle.lineSpacing=4;
        
        NSDictionary * attribute = @{NSFontAttributeName:seclabel.font,NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:seclabel.textColor};
        NSMutableAttributedString *contentAttStr =[[NSMutableAttributedString alloc]initWithString:strsec];
        [contentAttStr addAttributes:attribute range:NSMakeRange(0,[strsec length])];
        seclabel.attributedText=contentAttStr;
        last=seclabel;
    }else
    {
        [UNApplicationTool showAlertWithMsg:@"副标题不能缺失" WithParentView:[[[UIApplication sharedApplication] delegate] window]];
    }
    
    UIButton *btn=[[UIButton alloc]init];
    btn.layer.cornerRadius=kTransformP(3);
    btn.clipsToBounds=YES;
    [btn setTitle:@"立即更新" forState:UIControlStateNormal];
    [btn setBackgroundColor:kColor(@"#5584E8")];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=kFontNomal(16);
    [contentBG addSubview:btn];
    [btn addTarget:self action:@selector(updateAction) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(last.mas_bottom).with.offset(kTransformP(12));
        make.left.equalTo(contentBG.mas_left).with.offset(kTransformP(29));
        make.right.equalTo(contentBG.mas_right).with.offset(kTransformP(-29));
        make.height.mas_equalTo(kTransformP(34));
    }];
    
    
}
-(void)initOneButtonSubViewWithType:(TDTool_alert_type)type Withstr:(NSString*)strfist WithSecStr:(NSString*)strsec WithBtnTitleArray:(NSArray*)btnarray
{
    UIView *contentBG=[self getBG];
    [self addSubview:contentBG];
    
    UIView *last=contentBG;
    if (strfist.length>0) {
        UILabel *fistlabel=[self getTitle];
        [contentBG addSubview:fistlabel];
        fistlabel.text=strfist;
        [fistlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentBG.mas_top).with.offset(kTransformP(17));
            make.height.mas_equalTo(kTransformP(22));
            make.left.equalTo(contentBG.mas_left).with.offset(kTransformP(29));
            make.right.equalTo(contentBG.mas_right).with.offset(kTransformP(-29));
        }];
        last=fistlabel;
    }
    if (strsec.length>0) {
        UILabel *seclabel=[self getSubTitle];
        [contentBG addSubview:seclabel];
        [seclabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (last==contentBG) {
                make.top.equalTo(contentBG.mas_top).with.offset(kTransformP(17));
            }else
            {
                make.top.equalTo(last.mas_bottom).with.offset(kTransformP(24));
            }
            make.left.equalTo(contentBG.mas_left).with.offset(kTransformP(29));
            make.right.equalTo(contentBG.mas_right).with.offset(kTransformP(-29));
        }];
        
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        paragraphStyle.lineSpacing=4;
        
        NSDictionary * attribute = @{NSFontAttributeName:seclabel.font,NSParagraphStyleAttributeName:paragraphStyle};
        NSMutableAttributedString *contentAttStr =[[NSMutableAttributedString alloc]initWithString:strsec];
        [contentAttStr addAttributes:attribute range:NSMakeRange(0,[strsec length])];
        NSMutableAttributedString *contentAttStr_color=[[NSMutableAttributedString alloc]initWithAttributedString:contentAttStr];
        [contentAttStr_color addAttribute:NSForegroundColorAttributeName value:seclabel.textColor range:NSMakeRange(0,[contentAttStr_color length])];
        
        //-------------特殊情况
        [contentAttStr_color addAttribute:NSForegroundColorAttributeName value:kColor(@"#5584E8") range:[strsec rangeOfString:@"完善备考信息"]];
        //---------------------
        
        seclabel.attributedText=contentAttStr_color;
        
        [UNApplicationTool layoutlabelWithMutilRow:seclabel];
        last=seclabel;
    }else
    {
        [UNApplicationTool showAlertWithMsg:@"副标题不能缺失" WithParentView:[[[UIApplication sharedApplication] delegate] window]];
    }
    
    UIButton *btn=[[UIButton alloc]init];
    btn.layer.cornerRadius=kTransformP(3);
    btn.clipsToBounds=YES;
    [btn setTitle:btnarray[0] forState:UIControlStateNormal];
    [btn setBackgroundColor:kColor(@"#5584E8")];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=kFontNomal(16);
    [contentBG addSubview:btn];
    [btn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(last.mas_bottom).with.offset(kTransformP(17));
        make.left.equalTo(contentBG.mas_left).with.offset(kTransformP(29));
        make.right.equalTo(contentBG.mas_right).with.offset(kTransformP(-29));
        make.height.mas_equalTo(kTransformP(34));
    }];
    
    [contentBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(15);
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.bottom.equalTo(btn.mas_bottom).with.offset(kTransformP(17));
    }];
}
-(void)updateAction
{
    NSURL *down = [NSURL URLWithString:[NSString stringWithFormat:@"%@", downLoadUrl]];
    [[UIApplication sharedApplication] openURL:down];
    [self removeFromSuperview];
}
@end
