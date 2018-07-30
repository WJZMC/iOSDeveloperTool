//
//  XC_labelCollectionViewCell.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import <UIKit/UIKit.h>
#import "Label_btn.h"

@interface XC_labelCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *xc_label;

@property (weak, nonatomic) IBOutlet Label_btn *closeBtnOutle;

@property (weak, nonatomic) IBOutlet UIView *cellBackView;

/** 这个属性是：背景颜色****/
@property (nonatomic)UIColor * cellbackColor;


@end
