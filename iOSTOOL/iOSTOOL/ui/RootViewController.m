//
//  RootViewController.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "RootViewController.h"
#import "CustomNavigationController.h"
#import "FirstPageViewController.h"
#import "UserViewController.h"
#import "config.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FirstPageViewController *frist=[[FirstPageViewController alloc]init];
    CustomNavigationController *customHomeNav=[[CustomNavigationController alloc]initWithRootViewController:frist];
    [self setTabBarItem:frist.tabBarItem
                  title:@"首页"
          titleFontName:kFontNomal(13)
          selectedImage:@"shouye-on"
     selectedTitleColor:kMainBlueColor
            normalImage:@"shouye"
       normalTitleColor:[UIColor grayColor]];
    
    UserViewController *user=[[UserViewController alloc]init];
    CustomNavigationController *customUserNav=[[CustomNavigationController alloc]initWithRootViewController:user];
    [self setTabBarItem:user.tabBarItem
                  title:@"首页"
          titleFontName:kFontNomal(13)
          selectedImage:@"wode-on"
     selectedTitleColor:kMainBlueColor
            normalImage:@"wode"
       normalTitleColor:[UIColor grayColor]];
    
    [self setViewControllers:@[customHomeNav,customUserNav] animated:YES];
}
- (void)setTabBarItem:(UITabBarItem *)tabbarItem
                title:(NSString *)title
        titleFontName:(UIFont *)font
        selectedImage:(NSString *)selectedImage
   selectedTitleColor:(UIColor *)selectColor
          normalImage:(NSString *)unselectedImage
     normalTitleColor:(UIColor *)unselectColor
{
    
    //设置图片
    tabbarItem = [tabbarItem initWithTitle:title image:[[UIImage imageNamed:unselectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // 未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:font} forState:UIControlStateNormal];
    
    // 选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:font} forState:UIControlStateSelected];
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
