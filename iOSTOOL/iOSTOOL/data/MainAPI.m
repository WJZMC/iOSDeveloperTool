//
//  MainAPI.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "MainAPI.h"
#import "config.h"
@implementation MainAPI
/**
 *  首页列表

 */
+ (void)getHomeChannelColumnListDataWithParameters:(id)parameters WithAnimation:(BOOL)isShowAnimation Success:(UNMainApiResultSucessBlock)success Failed:(UNAPIResultFailedBlock)failure
{
    [MainAPI postWithURL:@"/test/list" parameters:parameters WithAnimation:isShowAnimation WithShowLogin:NO success:^(id result, NSString *msg)  {
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array=result;
            NSMutableArray *resultArray=[NSMutableArray array];
            for (int i=0; i<array.count; i++) {
//                UNDynamicListBaseModel *mt=[UNDynamicListBaseModel mj_objectWithKeyValues:array[i]];
//                [resultArray addObject:mt];
            }
            success(resultArray);
        }else
        {
            failure(@"非法的返回结果");
            [UNApplicationTool showAlertWithMsg:@"非法的返回结果" WithParentView:[[[UIApplication sharedApplication] delegate] window]];
            
        }
    } failure:failure];
}
@end
