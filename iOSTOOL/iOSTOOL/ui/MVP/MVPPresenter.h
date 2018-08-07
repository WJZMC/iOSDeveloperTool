//
//  MVPPresenter.h
//  iOSTool
//
//  Created by jack wei on 2018/8/7.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVPPersenterDelegate.h"
@interface MVPPresenter : NSObject<MVPPersenterDelegate>
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,weak) id<MVPPersenterDelegate> delegate;
-(void)getData;
@end
