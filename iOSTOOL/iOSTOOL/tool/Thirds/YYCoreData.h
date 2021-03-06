//
//  YYCoreData.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import <Foundation/Foundation.h>

@interface YYCoreData : NSObject
/**
 *  单例
 *
 *  @return <#return value description#>
 */
+(YYCoreData *)shareCoreData;

/**
 *  生成 在用户跟目录下的文件路径信息
 *
 *  @param relativePath 相对路径 eg: test.plist or game/test.plist
 *
 *  @return 绝对路径
 */
-(NSString *)userResPath:(NSString *)relativePath;

@end
