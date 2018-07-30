//
//  TDFileTool.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//
#import <Foundation/Foundation.h>
typedef void (^TDFileToolBlock)();
typedef enum {
    TDFileTool_qaCache_file_type_mokao,
    TDFileTool_qaCache_file_type_zhuanXiang,
    TDFileTool_qaCache_file_type_ability,
    TDFileTool_qaCache_file_type_fenji,
    TDFileTool_qaCache_file_type_Exam,
    TDFileTool_qaCache_file_type_word
}TDFileTool_qaCache_file_type;
@interface TDFileTool : NSObject
+(long long) fileSizeAtPath:(NSString*) filePath;//获取文件大小
+(long long )folderSizeAtPath:(NSString*)folderPath;// 文件夹大小

+(void)deleteAllFileAtPath:(NSString *)path;//删除文件夹
+(void)deleteFileAtPath:(NSString *)path;//删除单个文件
+(BOOL)createDirectoryAtPath:(NSString *)path;
+(BOOL)FileExits:(NSString *)filePath;
//获取目录中的文件数组
+(NSArray *)getAllFileFrompath:(NSString*)path;

+(NSString*)getCurentFolder;//document
//document/uid/
+(NSString*)getCurentUserResource;//用户目录
//document/uid/temp/
+(NSString*)getCurentUserResourceTempPath;

@end
