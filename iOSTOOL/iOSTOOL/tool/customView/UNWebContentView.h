//
//  UNWebContentView.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import <WebKit/WebKit.h>
typedef void (^UNWebContentViewClickImageBlock)(BOOL isClick);
typedef void (^UNWebContentViewcontentSizeChangeBlock)(CGFloat h);

@interface UNWebContentView : WKWebView
-(instancetype)initWithBlock:(UNWebContentViewClickImageBlock)block WithBlock:(UNWebContentViewcontentSizeChangeBlock)changeBlock;
-(void)refushHtmlString:(NSString*)htmlstr WithAnimation:(BOOL)animation;
@end
