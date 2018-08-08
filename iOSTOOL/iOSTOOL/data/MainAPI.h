//
//  MainAPI.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "WJRequest.h"
typedef void (^UNMainApiResultSucessBlock)(NSArray *result);
typedef void (^UNMainApiStringResultSucessBlock)(NSString *result);
@interface MainAPI : WJRequest
/**
 *  首页列表
 */
+ (void)getHomeChannelColumnListDataWithParameters:(id)parameters WithAnimation:(BOOL)isShowAnimation Success:(UNMainApiResultSucessBlock)success Failed:(WJAPIResultFailedBlock)failure;
@end
