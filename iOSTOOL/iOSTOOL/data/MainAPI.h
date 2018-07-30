//
//  MainAPI.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "UNAPIBase.h"
typedef void (^UNMainApiResultSucessBlock)(NSArray *result);
typedef void (^UNMainApiStringResultSucessBlock)(NSString *result);
@interface MainAPI : UNAPIBase
/**
 *  首页列表
 */
+ (void)getHomeChannelColumnListDataWithParameters:(id)parameters WithAnimation:(BOOL)isShowAnimation Success:(UNMainApiResultSucessBlock)success Failed:(UNAPIResultFailedBlock)failure;
@end
