//
//  MVPViewController.m
//  iOSTool
//
//  Created by jack wei on 2018/8/7.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "MVPViewController.h"
#import "MVPPresenter.h"
#import "WJTableViewDataSource.h"
#import "MVPTableViewCell.h"
#import "TestModel.h"
@interface MVPViewController ()<MVPPersenterDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)WJTableViewDataSource *dataSource;
@property(nonatomic,strong)MVPPresenter *presenter;

@end

@implementation MVPViewController
/*
    MVPPersenterDelegate    管理所有的协议：请求数据+反向数据源更新
 
    MVPPresenter----->MVPViewController   实现刷新数据的协议
 
    MVPTableViewCell----->MVPPresenter    实现反向更新数据源的协议
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"MVP";
    
    [self.view addSubview:self.tableView];
    [self.presenter getData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)reloadData:(NSArray *)dataArray
{
    self.dataSource.dataArray=dataArray;
    [self.tableView reloadData];
}


-(UITableView*)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerClass:[MVPTableViewCell class] forCellReuseIdentifier:@"MVPCell"];
        _dataSource=[[WJTableViewDataSource alloc]initWithTable:_tableView WithReuseIdentifier:@"MVPCell" WithBlock:^(MVPTableViewCell* cell, TestModel* model, NSInteger indexPathRow) {
            cell.label.text=[NSString stringWithFormat:@"%ld",model.defaultNum];
            cell.indexPathRow=indexPathRow;
            cell.delegate=self.presenter;
        }];
    }
    return _tableView;
}
-(MVPPresenter*)presenter
{
    if (!_presenter) {
        _presenter=[[MVPPresenter alloc]init];
        _presenter.delegate=self;
    }
    return _presenter;
}

@end
