//
//  WPhotoViewController.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import <UIKit/UIKit.h>
#import "myPhotoCell.h"
#import "UIImage+fixOrientation.h"
#import "WPMacros.h"
#import "WPFunctionView.h"
#import "NavView.h"
#import "BaseViewController.h"
@interface WPhotoViewController : BaseViewController

@property (assign, nonatomic) NSInteger selectPhotoOfMax;/**< 选择照片的最多张数 */

/** 回调方法 */
@property (nonatomic, copy) void(^selectPhotosBack)(NSMutableArray *photosArr);

@end
