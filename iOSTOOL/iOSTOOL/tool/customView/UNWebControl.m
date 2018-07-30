//
//  UNWebControl.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "UNWebControl.h"
#import <WebKit/WebKit.h>
#import "config.h"
static void *WkwebBrowserContextWeb = &WkwebBrowserContextWeb;

@interface UNWebControl ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UINavigationControllerDelegate,UINavigationBarDelegate>
{
    WKUserContentController * UserContentController;
    NSString *url;
    
    BOOL isFirstShowAnimation;

}

@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, weak) UIView *leftBtnView;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) NSMutableArray *snapShotsArray;

@end

@implementation UNWebControl

- (NSMutableArray*)snapShotsArray{
    if (!_snapShotsArray) {
        _snapShotsArray = [NSMutableArray array];
    }
    return _snapShotsArray;
}

-(instancetype)initWithUrl:(NSString*)requestUrl
{
    if (self=[super init]) {
        url=requestUrl;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addNavigationBackButtonWithIsBlack:YES];
    self.navigationItem.title = @"";
    self.view.backgroundColor=[UIColor whiteColor];
    //添加到主控制器上
    [self.view addSubview:self.wkWebView];
    
    [self loadNavBtn];
    
    //添加右边刷新按钮
//    UIBarButtonItem *roadLoad = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(roadLoadClicked)];
//    self.navigationItem.rightBarButtonItem = roadLoad;

    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self loadWebURLSring:url];
    
}

- (void)loadNavBtn {
    
    //创建自定义视图
    UIView *leftBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    leftBtnView.backgroundColor = [UIColor clearColor];
    //加载自定义视图
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtnView];
    self.leftBtnView = leftBtnView;
    
    
    if (self.wkWebView.canGoBack) {
        
        [leftBtnView addSubview:self.backBtn];
        [leftBtnView addSubview:self.closeBtn];
        
    } else {
        [leftBtnView addSubview:self.backBtn];
    }
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(0, 10, 20, 20);
        [_backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(30, 10, 20, 20);
        [_closeBtn setImage:[UIImage imageNamed:@"main_sec_close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}



- (void)backBtnClick {
    
    //判断是否有上一层H5页面
    if ([self.wkWebView canGoBack]) {
        //如果有则返回
        [self.wkWebView goBack];
    } else {
        [self closeBtnClick];
    }
}

// 关闭H5页面，直接回到原生页面
- (void)closeBtnClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)roadLoadClicked{
    [self.wkWebView reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    isFirstShowAnimation=YES;

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
}
- (void)loadWebURLSring:(NSString *)string{
    
    //加载web页面
    //创建一个NSURLRequest 的对象
    NSURLRequest * Request_zsj = [NSURLRequest requestWithURL:[NSURL URLWithString:string] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    //加载网页
    [self.wkWebView loadRequest:Request_zsj];
    
}
//请求链接处理
-(void)pushCurrentSnapshotViewWithRequest:(NSURLRequest*)request{
    //    //    NSLog(@"push with request %@",request);
    //    NSURLRequest* lastRequest = (NSURLRequest*)[[self.snapShotsArray lastObject] objectForKey:@"request"];
    //
    //如果url是很奇怪的就不push
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]) {
        //        NSLog(@"about blank!! return");
        return;
    }
    //    //如果url一样就不进行push
    //    if ([lastRequest.URL.absoluteString isEqualToString:request.URL.absoluteString]) {
    //        return;
    //    }
    //    UIView* currentSnapShotView = [self.wkWebView snapshotViewAfterScreenUpdates:YES];
    //    [self.snapShotsArray addObject:
    //     @{@"request":request,@"snapShotView":currentSnapShotView}];
    
//    UNWebControl *webCtrol=[[UNWebControl alloc]initWithUrl:request.URL.absoluteString];
//    [self.navigationController pushViewController:webCtrol animated:YES];
    
    [self loadWebURLSring:request.URL.absoluteString];

}

#pragma mark ================ WKNavigationDelegate ================

//这个是网页加载完成，导航的变化
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

//    self.title = self.wkWebView.title;
//    isNeedShowAnimation=NO;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    [SVProgressHUD dismiss];
    [self loadNavBtn];
}

//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    //    self.progressView.hidden = NO;
    [UNApplicationTool hideNoDataViewWithParentView:self.view];
}

//内容返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

//服务器请求跳转的时候调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

//服务器开始请求的时候调用
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
//    if (isNeedShowAnimation) {
//        [SVProgressHUD show];
//    }

    switch (navigationAction.navigationType) {
        case WKNavigationTypeLinkActivated: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];

            break;
        }
        case WKNavigationTypeFormSubmitted: {

            break;
        }
        case WKNavigationTypeBackForward: {
            break;
        }
        case WKNavigationTypeReload: {
            break;
        }
        case WKNavigationTypeFormResubmitted: {

            break;
        }
        case WKNavigationTypeOther: {

            break;
        }
        default: {
            break;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    [self loadNavBtn];
}

// 内容加载失败时候调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    debugLog(@"页面加载超时");
    [SVProgressHUD dismiss];
//    [UNApplicationTool showAlertWithMsg:@"加载超时" WithParentView:self.view];
    [UNApplicationTool showNoDataViewWithParentView:self.view WithMsg:@"页面异常，请稍后再试" WithCLickBlock:^(NSString *str) {
        
    }];
}

//跳转失败的时候调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    debugLog(@"%@",error);
    [SVProgressHUD dismiss];
//    [UNApplicationTool showAlertWithMsg:error.localizedDescription WithParentView:self.view];

}

//进度条
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}

#pragma mark ================ WKUIDelegate ================

// 获取js 里面的提示
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

// js 信息的交流
-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

// 交互。可输入的文本。
-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    
}

#pragma mark ================ WKScriptMessageHandler ================

//拦截执行网页中的JS方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    
}

#pragma mark ================ 懒加载 ================

- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        //设置网页的配置文件
        WKWebViewConfiguration * Configuration = [[WKWebViewConfiguration alloc]init];
        //允许视频播放
        //        Configuration.allowsAirPlayForMediaPlayback = YES;
        // 允许在线播放
        Configuration.allowsInlineMediaPlayback = YES;
        // 允许可以与网页交互，选择视图
        Configuration.selectionGranularity = YES;
        // web内容处理池
        Configuration.processPool = [[WKProcessPool alloc] init];
        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
        UserContentController = [[WKUserContentController alloc]init];
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        //        window.webkit.messageHandlers.名字.postMessage(内容)
//        [UserContentController addScriptMessageHandler:self name:@"loginaction"];
    
   
        
        // 是否支持记忆读取
        Configuration.suppressesIncrementalRendering = YES;
        // 允许用户更改网页的设置
        Configuration.userContentController = UserContentController;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -[UNApplicationTool getNav_StatusH]) configuration:Configuration];
        _wkWebView.backgroundColor = [UIColor clearColor];
        // 设置代理
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
       
        //kvo 添加进度监控
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContextWeb];
        
        //开启手势触摸
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        // 设置 可以前进 和 后退
        //适应你设定的尺寸
        [_wkWebView sizeToFit];
        
    }
    return _wkWebView;
}
//注意，观察的移除
-(void)dealloc{
  
    if (@available(iOS 9.0, *)) {
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        
        //// Date from
        
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        
        //// Execute
        
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            
            // Done
            
        }];
    }else
    {
        NSURLCache * cache = [NSURLCache sharedURLCache];
        
        [cache removeAllCachedResponses];
        
        [cache setDiskCapacity:0];
        
        [cache setMemoryCapacity:0];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    


}
//KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        if (isFirstShowAnimation) {
            isFirstShowAnimation=NO;
            [SVProgressHUD show];
        }
        if (self.wkWebView.estimatedProgress >= 1.0f) {
            [SVProgressHUD dismiss];
            isFirstShowAnimation=YES;
        }
        //        [self.progressView setAlpha:1.0f];
        //        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        //        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        //
        //        // Once complete, fade out UIProgressView
        //        if(self.wkWebView.estimatedProgress >= 1.0f) {
        //            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
        //                [self.progressView setAlpha:0.0f];
        //            } completion:^(BOOL finished) {
        //                [self.progressView setProgress:0.0f animated:NO];
        //            }];
        //        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end
