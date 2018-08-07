//
//  MVVMViewModel.m
//  iOSTool
//
//  Created by jack wei on 2018/8/7.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "MVVMViewModel.h"
#import "TestModel.h"
#import "config.h"
@interface MVVMViewModel()
@property(nonatomic,copy) MVVMViewModelSucessBlock cblock;
@property(nonatomic,strong) NSMutableArray *dataArray;

@end
@implementation MVVMViewModel
-(instancetype)initWithSucessBlcok:(MVVMViewModelSucessBlock)block
{
    if (self=[super init]) {
        self.cblock=block;
        [self getData];
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
    self.cblock(self.dataArray);
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
