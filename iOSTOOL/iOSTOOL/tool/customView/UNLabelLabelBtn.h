//
//  UNLabelLabelBtn.h
///  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UNLabelLabelBtn : UIView
-(id)initWithConfigDic:(NSDictionary*)dic;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *subTitle;
@end
