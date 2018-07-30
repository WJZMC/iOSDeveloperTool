//
//  WJImageTitleBtn.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJImageTitleBtn : UIButton //MychangeFontBtn
-(id)initWithConfigDic:(NSDictionary*)dic;
@property(nonatomic,assign) BOOL isMystatus;
@property(nonatomic,strong)UIImageView *bImage;
@property(nonatomic,strong)UILabel *bTitle;
@end
