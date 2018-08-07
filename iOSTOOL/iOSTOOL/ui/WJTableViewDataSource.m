//
//  WJTableViewDataSource.m
//  iOSTool
//
//  Created by jack wei on 2018/8/7.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "WJTableViewDataSource.h"
@interface WJTableViewDataSource()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy) WJTableViewDataSourceBlock cBlock;
@property(nonatomic,strong) NSString *identifity;
@end
@implementation WJTableViewDataSource
-(instancetype)initWithTable:(UITableView*)table WithReuseIdentifier:(NSString *)identifier WithBlock:(WJTableViewDataSourceBlock)block{
    if (self=[super init]) {
        self.cBlock=block;
        _identifity=identifier;
        table.dataSource=self;
        table.delegate=self;
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifity];
    if (_cBlock) {
        _cBlock(cell,self.dataArray[indexPath.row],indexPath.row);
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
