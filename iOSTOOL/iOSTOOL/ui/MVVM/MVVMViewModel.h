//
//  MVVMViewModel.h
//  iOSTool
//
//  Created by jack wei on 2018/8/7.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^MVVMViewModelSucessBlock)(id data);
@interface MVVMViewModel : NSObject
-(instancetype)initWithSucessBlcok:(MVVMViewModelSucessBlock)block;

/**
 * @param indexPathRow 单元格在表中的索引.
 * 单元格反向刷新数据源
 */
-(void)addActionWith:(NSInteger)indexPathRow;
@end
