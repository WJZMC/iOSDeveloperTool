//
//  WKWebViewController.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import "RootViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WebKit.h>
@interface WKWebViewController : RootViewController
@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic,assign) BOOL isLoadSucess;

/** 是否显示Nav */
@property (nonatomic,assign) BOOL isNavHidden;

@property (nonatomic, assign) BOOL isGetTitle;

/**
 加载纯外部链接网页

 @param string URL地址
 */
- (void)loadWebURLSring:(NSString *)string;

/**
 加载本地网页
 
 @param string 本地HTML文件名
 */
- (void)loadWebHTMLSring:(NSString *)string;

/**
 加载外部链接POST请求(注意检查 XFWKJSPOST.html 文件是否存在 )
 postData请求块 注意格式：@"\"username\":\"xxxx\",\"password\":\"xxxx\""
 
 @param string 需要POST的URL地址
 @param postData post请求块
 */
- (void)POSTWebURLSring:(NSString *)string postData:(NSString *)postData;

@end
