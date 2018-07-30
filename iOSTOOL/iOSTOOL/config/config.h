//
//  config.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#ifndef config_h
#define config_h

/*--------------------------------------------------全局配置 */
//请求头
#define BaseUrl @"http://Api.test.com"

/*---------------------------------------------------header*/
#import "UIColor+Hex.h"
#import "UIButton+ImagePosition.h"
#import "UIImage+tool.h"
#import "UITextView+WZB.h"
#import "NSString+tool.h"
#import "UIColor+Hex.h"
#import "NSString+tool.h"
#import "UIView+YNFind.h"
#import "UIView+Toast.h"
#import "UINavigationBar+Awesome.h"
#import "UIView+tool.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "UIView+DKSBadge.h"
#import "UITabBar+DKSTabBar.h"
#import "UITabBarItem+DKSBadge.h"

#import "YYText.h"
#import "Masonry.h"
#import "TPKeyboardAvoidingCollectionView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "TPKeyboardAvoidingTableView.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"
//#import "TPKeyboardAvoidingTextView.h"
//#import "TPKeyboardAvoidingTextField.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "MJChiBaoZiFooter2.h"

#import "PPNetworkHelper.h"
#import <MJRefresh.h>
#import "UNApplicationTool.h"


/*---------------------------------------------------DEBUG*/
//调试
#ifdef DEBUG
#define debugLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define debugLog(...)

#endif

/*--------------------------------------------------system*/
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define kViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
//---------------系统版本
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)
#define iOS10Later ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#define iOS11Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
//---------------常用宏
#define kWindows  [UIApplication sharedApplication].keyWindow
// weakself
#define WS(weakself)  __weak __typeof(&*self)weakself = self




/*--------------------------------------------------布局相关*/
#define kScaleBase kScreenWidth / 375.0f
//坐标位置转换
#define kTransformP(x) x*kScaleBase




/*--------------------------------------------------自定义字体*/
//本地化字体
#define kFontNomal(value) ({UIFont *font=[UIFont fontWithName:NSLocalizedStringFromTable(@"UNLocalFontName_nomal",@"Info", nil) size:value];if(font==nil){font=[UIFont systemFontOfSize:value];} font;})
#define kFontBlod(value) ({UIFont *font=[UIFont fontWithName:NSLocalizedStringFromTable(@"UNLocalFontName_blod",@"Info", nil) size:value];if(font==nil){font=[UIFont boldSystemFontOfSize:value];}font;})




/*--------------------------------------------------自定义颜色*/
#define kColor(color) ([UIColor colorWithHexString:color])
#define kMainBlueColor ([UIColor colorWithHexString:@"#2B78F6"])
#define kBGColor ([UIColor colorWithHexString:@"#ffffff"])
#define kBlackColor ([UIColor colorWithHexString:@"#000000"])
//设置RGB和RGBA颜色
#define RGB(r,g,b)    ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1])
#define RGBA(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])



#endif /* config_h */
