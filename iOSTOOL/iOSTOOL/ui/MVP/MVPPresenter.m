//
//  MVPPresenter.m
//  iOSTool
//
//  Created by jack wei on 2018/8/7.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "MVPPresenter.h"
#import "TestModel.h"
#import "config.h"
@interface MVPPresenter()

@end
@implementation MVPPresenter
-(instancetype)init
{
    if (self=[super init]) {
        self.delegate=self;
    }
    return self;
}
-(void)getData
{
    NSArray *data=@[@{@"defaultNum":@(1)},@{@"defaultNum":@(1)},@{@"defaultNum":@(1)},@{@"defaultNum":@(1)},@{@"defaultNum":@(1)},@{@"defaultNum":@(1)},@{@"defaultNum":@(1)}];
    for (int i=0; i<data.count; i++) {
        TestModel *mt=[TestModel yy_modelWithDictionary:data[i]];
        [self.dataArray addObject:mt];
    }
    [self reloadData];
}
-(void)reloadData
{
    if ([self.delegate respondsToSelector:@selector(reloadData:)]) {
        [self.delegate reloadData:self.dataArray];
    }
}
-(void)addActionWith:(NSInteger)indexPathRow
{
    TestModel *mt=self.dataArray[indexPathRow];
    mt.defaultNum++;
}
-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
@end
