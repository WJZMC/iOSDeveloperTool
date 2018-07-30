//
//  BaseViewController.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBGColor;
    
    if (@available(iOS 7.0, *)) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    if (@available(iOS 11.0, *)) {
        
    }
    else if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)] == YES) {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#ifdef DEBUG //Debug模式下进入后台时，打印出存活的视图.查看是否有泄漏视图.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(debugAliveViewController) name:UIApplicationDidEnterBackgroundNotification object:nil];
#endif
    [self monitorNetwork];
    
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    //    [UNApplicationTool showNavigationBarLineWithCtrl:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarChange)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}
- (void)statusBarChange {
    debugLog(@"状态栏高度发生变化 %f",[UIApplication sharedApplication].statusBarFrame.size.height);//状态栏高度
}
- (void)monitorNetwork{
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                debugLog(@"当前网络连接失败，请查看设置");
                [UNApplicationTool showAlertWithMsg:@"网络连接失败" WithParentView:self.view];
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                debugLog(@"正在通过手机网络进行连接");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                debugLog(@"正在用wifi进行连接");
                break;
            case AFNetworkReachabilityStatusUnknown:
                break;
            default:
                break;
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
}
#pragma mark debug

- (void)debugAliveViewController
{
    debugLog(@"进入后台后: %s 界面存活.如果非根视图，请检查泄露!",[[[self class] description] UTF8String]);
}

- (void)dealloc
{
    debugLog(@"%@ dealloced\n", NSStringFromClass(self.class));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
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
