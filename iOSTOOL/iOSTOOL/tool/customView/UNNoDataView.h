//
//  UNNoDataView.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^UNNoDataViewPublicBlock)(NSString *str);
@interface UNNoDataView : UIView
-(instancetype)initWithFrame:(CGRect)frame WithMsg:(NSString *)msg WithCLickBlock:(UNNoDataViewPublicBlock)block;
@end
