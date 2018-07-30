//
//  UNActionSheet.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^UNActionSheetBlock)(NSInteger type);
@interface UNActionSheet : UIView
-(instancetype)initWithConfig:(NSArray*)config WithBlock:(UNActionSheetBlock)block;
@end
