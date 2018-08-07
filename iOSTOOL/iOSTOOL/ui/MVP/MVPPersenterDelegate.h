//
//  MVPPersenterDelegate.h
//  iOSTool
//
//  Created by jack wei on 2018/8/7.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MVPPersenterDelegate <NSObject>
/**
 *mvp 是面向需求的协议编程，把需求定义为协议，通过实现协议的方法来实现交互
 */
@optional
/**
 * @param dataArray 服务端返回数据.
 * 获取数据成功后刷新表格
 */
-(void)reloadData:(NSArray*)dataArray;
/**
 * @param indexPathRow 单元格在表中的索引.
 * 单元格反向刷新数据源
 */
-(void)addActionWith:(NSInteger)indexPathRow;
@end
