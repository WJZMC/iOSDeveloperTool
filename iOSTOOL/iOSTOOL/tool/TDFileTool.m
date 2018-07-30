//
//  TDFileTool.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "TDFileTool.h"
#import "config.h"
@implementation TDFileTool
//遍历文件夹获得文件夹大小，返回多少M
+(long long)folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [TDFileTool fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize;
}

+(long long) fileSizeAtPath:(NSString*) filePath//获取文件大小
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
+(void)deleteAllFileAtPath:(NSString *)path//删除文件夹
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:path error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while (filename = [e nextObject])
    {
        NSString * fileName = [path stringByAppendingPathComponent:filename];
        [fileManager removeItemAtPath:fileName error:NULL];
    }
    
}
//删除单个文件
+(void)deleteFileAtPath:(NSString *)path
{
    if ([self FileExits:path]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL  result=[fileManager removeItemAtPath:path error:NULL];
        debugLog(@"%d",result);
    }
    
}
+(BOOL)createDirectoryAtPath:(NSString *)path
{
    NSFileManager * manager = [NSFileManager defaultManager];
    NSError *error;
    //    NSDictionary *attri=@{NSFilePosixPermissions:@777};
    //    BOOL result=[manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:attri error:&error];
    BOOL result=[manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    
    debugLog(@"%@",error);
    return result;
}
+(BOOL)FileExits:(NSString *)filePath
{
    NSFileManager * manager = [NSFileManager defaultManager];
    return [manager fileExistsAtPath:filePath];
}
//获取目录中的文件数组
+(NSArray *)getAllFileFrompath:(NSString*)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *fileList;
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    NSString *filePath=[[NSBundle mainBundle]resourcePath];
    fileList = [fileManager contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/resource/%@",filePath,path] error:&error];
    return fileList;
}


+(NSString *)getCurentFolder
{
    NSString * desURL = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/"]];
    return desURL;
}
//document/uid/
+(NSString*)getCurentUserResource
{
//    NSString *token=[UNApplicationSingle getInstance].userModel.token;
    NSString *token;
    if (token==nil) {
        token=@"0";
    }
    NSString * desURL = [NSString stringWithFormat:@"%@%@/",[TDFileTool getCurentFolder],token];
    if ([TDFileTool FileExits:desURL]) {
        return desURL;
    }else
    {
        BOOL result=[TDFileTool createDirectoryAtPath:desURL];
        if (result) {
            return desURL;
        }else
        {
            return nil;
        }
        
    }
}
//document/uid/temp/
+(NSString*)getCurentUserResourceTempPath
{
    NSString *temPath=[TDFileTool getCurentUserResource];
    NSString * desURL = [NSString stringWithFormat:@"%@temp/",temPath];
    BOOL result=[TDFileTool createDirectoryAtPath:desURL];
    if (result) {
        return desURL;
    }else
    {
        return nil;
    }
}

@end
