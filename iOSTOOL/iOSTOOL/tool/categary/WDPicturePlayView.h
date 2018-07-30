//
//  WDPicturePlayView.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import <UIKit/UIKit.h>

@protocol WDPicturePlayViewDelegate <NSObject>

- (void)didSelectedPicturePlayViewIndex:(NSInteger)index;

@end

@interface WDPicturePlayView : UIView

@property (nonatomic, weak) id<WDPicturePlayViewDelegate> delegate;

/**
 *  设置要显示的图片数组（数组中为图片的url）
 */
- (void)setAds:(NSArray*)imgNameArr;

@end
