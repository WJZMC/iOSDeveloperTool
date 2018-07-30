//
//  XC_EqualSpaceCollectionViewFlowLayout.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import <UIKit/UIKit.h>

/**
 每个选项靠左靠右还是居中

 - XC_collectionAlignTypeLeft:   左边
 - XC_collectionAlignTypeCenter: 右边
 - XC_collectionAlignTypeRight:  居中
 */
typedef NS_ENUM(NSInteger,XC_collectionAlignType) {
    XC_collectionAlignTypeLeft,
    XC_collectionAlignTypeCenter,
    XC_collectionAlignTypeRight
};

@interface XC_EqualSpaceCollectionViewFlowLayout : UICollectionViewFlowLayout

/** 这个属性是：每个cell 的对齐方式 ****/
@property (nonatomic)XC_collectionAlignType cellAligntype ;

/** 两个Cell之间的距离    */
@property (nonatomic,assign)CGFloat cellDistance;




@end
