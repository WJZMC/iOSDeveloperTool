//
//  MVVMViewController.m
//  iOSTool
//
//  Created by jack wei on 2018/8/7.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "MVVMViewController.h"
#import "MVVMTableViewCell.h"
#import "WJTableViewDataSource.h"
#import "TestModel.h"
#import "MVVMViewModel.h"
@interface MVVMViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)WJTableViewDataSource *dataSource;
@property(nonatomic,strong)MVVMViewModel *vm;
@end

@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"MVVM";

    [self.view addSubview:self.tableView];
    __weak typeof(self) weakSelf=self;
    self.vm=[[MVVMViewModel alloc]initWithSucessBlcok:^(NSArray* data) {
        weakSelf.dataSource.dataArray=data;
        [weakSelf.tableView reloadData];
    }];
}
#pragma mark ---------------lazy
-(UITableView*)tableView
{
    if (!_tableView) {
        __weak typeof(self) weakSelf=self;
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerClass:[MVVMTableViewCell class] forCellReuseIdentifier:@"MVVMTableViewCell"];
        _dataSource=[[WJTableViewDataSource alloc]initWithTable:_tableView WithReuseIdentifier:@"MVVMTableViewCell" WithBlock:^(MVVMTableViewCell* cell, TestModel* model, NSInteger indexPathRow) {
            cell.label.text=[NSString stringWithFormat:@"%ld",model.defaultNum];
            cell.vm=weakSelf.vm;
            cell.indexPathRow=indexPathRow;
        }];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
