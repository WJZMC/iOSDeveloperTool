//
//  FirstPageViewController.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "FirstPageViewController.h"
#import "MVPViewController.h"
#import "MVVMViewController.h"
@interface FirstPageViewController ()
@property(nonatomic,strong) UIButton *MVP;
@property(nonatomic,strong) UIButton *MVVM;
@end

@implementation FirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.MVP];
    [self.view addSubview:self.MVVM];
    
    [self.MVP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kTransformP(100), kTransformP(100)));
        make.top.equalTo(self.view.mas_top).with.offset(100);
        make.centerX.equalTo(self.view);
    }];
    
    [self.MVVM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kTransformP(100), kTransformP(100)));
        make.top.equalTo(self.view.mas_top).with.offset(300);
        make.centerX.equalTo(self.view);
    }];
}
-(UIButton*)MVP
{
    if (!_MVP) {
        _MVP=[[UIButton alloc]init];
        [_MVP setTitle:@"MVP" forState:UIControlStateNormal];
        [_MVP setTitleColor:kColor(@"000000") forState:UIControlStateNormal];
        [_MVP addTarget:self action:@selector(mvpAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MVP;
}
-(UIButton*)MVVM
{
    if (!_MVVM) {
        _MVVM=[[UIButton alloc]init];
        [_MVVM setTitle:@"MVVM" forState:UIControlStateNormal];
        [_MVVM setTitleColor:kColor(@"000000") forState:UIControlStateNormal];
        [_MVVM addTarget:self action:@selector(mvpAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MVVM;
}
-(void)mvpAction:(UIButton*)sender
{
    MVPViewController *mvp=[[MVPViewController alloc]init];
    [self.navigationController pushViewController:mvp animated:YES];
}
-(void)mvvmAction:(UIButton*)sender
{
    MVVMViewController *mvvm=[[MVVMViewController alloc]init];
    [self.navigationController pushViewController:mvvm animated:YES];
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
