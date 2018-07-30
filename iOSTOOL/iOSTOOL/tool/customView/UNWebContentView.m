//
//  UNWebContentView.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "UNWebContentView.h"
#import "UNWebControl.h"
#import "XJAlbum.h"
#import "config.h"
@interface UNWebContentView()<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>
{
    WKUserContentController * UserContentController;
    BOOL isShowAimation;
}
@property(nonatomic,copy) UNWebContentViewClickImageBlock cblock;
@property(nonatomic,copy) UNWebContentViewcontentSizeChangeBlock changeBlock;

@property(nonatomic,assign) BOOL isOtherUrl;

@property(nonatomic,strong) NSMutableArray *htmlImageArray;

@end
@implementation UNWebContentView
-(instancetype)initWithBlock:(UNWebContentViewClickImageBlock)block WithBlock:(UNWebContentViewcontentSizeChangeBlock)changeBlock
{
    isShowAimation=YES;
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
    [UserContentController addScriptMessageHandler:self name:@"imgClick"];
    
    // 是否支持记忆读取
    Configuration.suppressesIncrementalRendering = YES;
    // 允许用户更改网页的设置
    Configuration.userContentController = UserContentController;
    if (self=[super initWithFrame:CGRectZero configuration:Configuration]) {
        _cblock=block;
        _changeBlock=changeBlock;
      
        
        self.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor redColor];
        // 设置代理
        self.navigationDelegate = self;
        self.UIDelegate=self;
        //开启手势触摸
        self.allowsBackForwardNavigationGestures = YES;
        // 设置 可以前进 和 后退
        //适应你设定的尺寸
        [self sizeToFit];
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"columnHtml" ofType:@"html" inDirectory:@""];
//        NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//        [self loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
        [self addWebViewObserver];
    }
    return self;
}
-(void)refushHtmlString:(NSString*)htmlstr WithAnimation:(BOOL)animation
{
    isShowAimation=animation;
    
    _htmlImageArray=[NSMutableArray array];
    NSMutableString *html = [NSMutableString string];
//    [html appendString:[UNWebContentView gethtmlHeader]];
    [html appendString:htmlstr];
//    [html appendString:[UNWebContentView getfooter]];
    [self loadHTMLString:html baseURL:nil];
    
//    if (htmlstr&&htmlstr.length>0) {
//        NSArray *rangeArray=[UNApplicationTool getBBSLetterSubStrRangeArrWithStr:htmlstr WithSubStr:@"src=\"+[a-zA-z]+://[^\\s|(\")]*"];
//        for (int i=0; i<rangeArray.count; i++) {
//            NSRange range=[rangeArray[i] range];
//            NSString *string=[htmlstr substringWithRange:range];
//            string=[string stringByReplacingOccurrencesOfString:@"src=\"" withString:@""];
//            [_htmlImageArray addObject:string];
//        }
//    }
    
//    htmlstr=[htmlstr stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
//    htmlstr=[htmlstr stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//    htmlstr=[htmlstr stringByReplacingOccurrencesOfString:@"\'" withString:@"\\\'"];
//    NSString *jsStr =[NSString stringWithFormat:@"refushUI('%@');",htmlstr];
//
//    [self evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        debugLog(@"%@----%@",result, error);
//        if (error) {
//            [UNApplicationTool showAlertWithMsg:@"内容格式错误，需要重新编辑后发布" WithParentView:kWindows];
//        }
//    }];
}
- (void)addWebViewObserver {
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    /**  < 法2 >  */
    /**  < loading：防止滚动一直刷新，出现闪屏 >  */
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGFloat height = self.scrollView.contentSize.height;
        if (_changeBlock) {
            if (isShowAimation) {
                isShowAimation=NO;
                [SVProgressHUD dismiss];
            }
            _changeBlock(height);
        }
    }
}

#pragma mark ================ WKNavigationDelegate ================

//这个是网页加载完成，导航的变化
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    /*
     主意：这个方法是当网页的内容全部显示（网页内的所有图片必须都正常显示）的时候调用（不是出现的时候就调用），，否则不显示，或则部分显示时这个方法就不调用。
     */
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self evaluateJavaScript:@"APPload();" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        debugLog(@"%@----%@",result, error);
        if (error) {
            [UNApplicationTool showAlertWithMsg:error.localizedDescription WithParentView:kWindows];
        }
    }];
    
}

//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    //    self.progressView.hidden = NO;
}

//内容返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

//服务器请求跳转的时候调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
//服务器开始请求的时候调用
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (isShowAimation) {
        [SVProgressHUD show];
    }
    switch (navigationAction.navigationType) {
        case WKNavigationTypeLinkActivated: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        case WKNavigationTypeFormSubmitted: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        case WKNavigationTypeBackForward: {
            
            break;
        }
        case WKNavigationTypeReload: {
            break;
        }
        case WKNavigationTypeFormResubmitted: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        case WKNavigationTypeOther: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        default: {
            break;
        }
    }
    //    [self updateNavigationItems];
    decisionHandler(_isOtherUrl?WKNavigationActionPolicyCancel:WKNavigationActionPolicyAllow);
    _isOtherUrl=YES;

//    decisionHandler(WKNavigationActionPolicyCancel);

    //    NSString* orderInfo = [[AlipaySDK defaultService]fetchOrderInfoFromH5PayUrl:[navigationAction.request.URL absoluteString]];
    //    if (orderInfo.length > 0) {
    //        [self payWithUrlOrder:orderInfo];
    //    }
    //    //拨打电话
    //    //兼容安卓的服务器写法:<a class = "mobile" href = "tel://电话号码"></a>
    //    NSString *mobileUrl = [[navigationAction.request URL] absoluteString];
    //    mobileUrl = [mobileUrl stringByRemovingPercentEncoding];
    //    NSArray *urlComps = [mobileUrl componentsSeparatedByString:@"://"];
    //    if ([urlComps count]){
    //
    //        if ([[urlComps objectAtIndex:0] isEqualToString:@"tel"]) {
    //
    //            UIAlertController *mobileAlert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"拨号给 %@ ？",urlComps.lastObject] preferredStyle:UIAlertControllerStyleAlert];
    //            UIAlertAction *suerAction = [UIAlertAction actionWithTitle:@"拨号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //
    //                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mobileUrl]];
    //            }];
    //            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    //                return ;
    //            }];
    //
    //            [mobileAlert addAction:suerAction];
    //            [mobileAlert addAction:cancelAction];
    //
    //            [self presentViewController:mobileAlert animated:YES completion:nil];
    //        }
    //    }
}
//请求链接处理
-(void)pushCurrentSnapshotViewWithRequest:(NSURLRequest*)request{
//    //    NSLog(@"push with request %@",request);
//    NSURLRequest* lastRequest = (NSURLRequest*)[[self.snapShotsArray lastObject] objectForKey:@"request"];
//
    if (_isOtherUrl==NO) {
        return;
    }
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
    if (_cblock) {
        _cblock(YES);
    }
    UNWebControl *webCtrol=[[UNWebControl alloc]initWithUrl:request.URL.absoluteString];
    [self.yn_viewController.navigationController pushViewController:webCtrol animated:YES];
}

// 内容加载失败时候调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    debugLog(@"页面加载超时");
    [SVProgressHUD dismiss];
    [UNApplicationTool showAlertWithMsg:@"加载超时" WithParentView:kWindows];
}

//跳转失败的时候调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    debugLog(@"%@",error);
    [SVProgressHUD dismiss];
    [UNApplicationTool showAlertWithMsg:error.localizedDescription WithParentView:kWindows];
}

//进度条
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}
-(void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.configuration.userContentController removeScriptMessageHandlerForName:@"imgClick"];
}
#pragma mark ================ WKScriptMessageHandler ================

//拦截执行网页中的JS方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    //服务器固定格式写法 window.webkit.messageHandlers.名字.postMessage(内容);
    //客户端写法 message.name isEqualToString:@"名字"]
    if ([message.name isEqualToString:@"imgClick"]) {
        debugLog(@"-----------%@",message.body);
        NSString *index=message.body[@"index"];
        _htmlImageArray=[NSMutableArray arrayWithArray:message.body[@"arr"]];

        if (_htmlImageArray.count>0) {
            if (_cblock) {
                _cblock(YES);
            }
            XJAlbum *album = [[XJAlbum alloc]initWithImgUrlArr:_htmlImageArray CurPage:[index integerValue]];
            album.photoFrame = kWindows.bounds;
            album.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
            [self.yn_viewController.navigationController presentViewController:album animated:YES completion:nil];
        }else
        {
            [UNApplicationTool showAlertWithMsg:@"参数错误" WithParentView:kWindows];
        }
    }
}



#pragma mark ================ WKUIDelegate ================

// 获取js 里面的提示
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self.yn_viewController presentViewController:alert animated:YES completion:NULL];
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
    [self.yn_viewController presentViewController:alert animated:YES completion:NULL];
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
    
    [self.yn_viewController presentViewController:alert animated:YES completion:NULL];
    
}
+(NSString*)gethtmlHeader
{
//    return @"<!DOCTYPE html><html><head><meta charset=\"utf-8\">        <meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0\"><title>文章详情</title></head><style type=\"text/css\">html{-ms-touch-action:none}body{margin:0;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none}p,a,span,pre,h1,h2,h3,h4,h5,h6{word-wrap:break-word}img{max-width:100%;height:auto}div{max-width:100%;word-wrap:break-word}p{max-width:100%;word-wrap:break-word}li{max-width:100%;word-wrap:break-word}h1{max-width:100%;word-wrap:break-word}h2{max-width:100%;word-wrap:break-word}h3{max-width:100%;word-wrap:break-word}h4{max-width:100%;word-wrap:break-word}h5{max-width:100%;word-wrap:break-word}h6{max-width:100%;word-wrap:break-word}li{word-wrap:break-word;max-width:100%}ol{word-wrap:break-word;max-width:100%;padding:10px 20px!important;list-style:decimal!important;display:block!important;-webkit-margin-before:1em;-webkit-margin-after:1em;-webkit-margin-start:0;-webkit-margin-end:0;-webkit-padding-start:20px;margin:0}ul{word-wrap:break-word;max-width:100%;padding:10px 20px!important;list-style:inside!important;display:block;-webkit-margin-before:1em;-webkit-margin-after:1em;-webkit-margin-start:0;-webkit-margin-end:0;-webkit-padding-start:20px;margin:0}blockquote{max-width:100%;display:block;border-left:8px solid #d0e5f2!important;padding:10px 10px;line-height:1.4;font-size:100%;margin:0;background-color:#f1f1f1}</style><body>    <div id=\"oHtml\">    ";
    return @"<!DOCTYPE html><html><head><meta charset=\"utf-8\">     <meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0\"><title>文章详情</title></head><style type=\"text/css\">html{-ms-touch-action:none}body{margin:0;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;line-height:28px;color:#4e4e4e;font-size:16px;letter-spacing:1px;text-align:justify}p,a,span,pre,h1,h2,h3,h4,h5,h6{word-wrap:break-word}img{max-width:100%;height:auto}div{max-width:100%;word-wrap:break-word}p{margin-top:0;margin-bottom:14px;max-width:100%;word-wrap:break-word}li{max-width:100%;word-wrap:break-word}blockquote p{margin-bottom:0;}h1{color:#000;max-width:100%;word-wrap:break-word;font-size:24px}h2{color:#000;max-width:100%;word-wrap:break-word;font-size:24px}h3{color:#000;max-width:100%;word-wrap:break-word;font-size:21px}h4{color:#000;max-width:100%;word-wrap:break-word;font-size:21px}h5{color:#000;max-width:100%;word-wrap:break-word;font-size:18px}h6{color:#000;max-width:100%;word-wrap:break-word;font-size:18px}li{word-wrap:break-word;max-width:100%}ol{word-wrap:break-word;max-width:100%;list-style:decimal!important;display:block!important;-webkit-margin-before:1em;-webkit-margin-after:1em;-webkit-margin-start:0;-webkit-margin-end:0;margin:0}ul{word-wrap:break-word;max-width:100%list-style:inside!important;display:block;-webkit-margin-before:1em;-webkit-margin-after:1em;-webkit-margin-start:0;-webkit-margin-end:0;margin:0}blockquote{max-width:100%;display:block;border-left:8px solid #d0e5f2!important;padding:10px 10px;line-height:1.4;font-size:100%;margin:0;background-color:#f1f1f1} dd{margin-left: 0; } .clearfix:after {visibility: hidden;display: block; font-size: 0; content: " ";clear: both; height: 0;}</style><body><div id=\"oHtml\">";
}
+(NSString*)getfooter
{
//    return @"</div></body></html><script type=\"text/javascript\">function APPload(){var aImg=document.getElementsByTagName(\"img\");var arr=[];for(var i=0;i<aImg.length;i++){arr.push(aImg[i].getAttribute(\"src\"));(function(index){aImg[index].onclick=function(){var json={\"index\":index,\"arr\":arr};imgClick(json)}})(i)}};function imgClick(msg){window.webkit.messageHandlers.imgClick.postMessage(msg)};</script>";
    return @"</div></body></html><script type=\"text/javascript\">var rootFontFamily=(document.documentElement.currentStyle?document.documentElement.currentStyle:window.getComputedStyle(document.documentElement)).fontFamily;document.getElementsByTagName(\"body\")[0].style.fontFamily=rootFontFamily;function APPload(){var aImg=document.getElementsByTagName(\"img\");var arr=[];for(var i=0;i<aImg.length;i++){arr.push(aImg[i].getAttribute(\"src\"));(function(index){aImg[index].onclick=function(){var json={\"index\":index,\"arr\":arr};imgClick(json)}})(i)}}function imgClick(msg){window.webkit.messageHandlers.imgClick.postMessage(msg)};</script>";

}

@end
