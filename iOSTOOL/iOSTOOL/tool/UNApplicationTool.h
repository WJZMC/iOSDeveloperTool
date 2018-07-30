//
//  UNApplicationTool.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDAlertView.h"
#import "UNActionSheet.h"
typedef void (^UNApplicationTool_htmlBlock)(NSString *htmlStr);
#import "UNNoDataView.h"
@interface UNApplicationTool : NSObject
+(NSString*)getApplicationDisplayName;
+(NSString*)getApplicationVersion;
/** 获取当前导航栏高度 */
+(CGFloat)getNavH;
/** 获取当前状态栏高度 */
+(CGFloat)getStatusH;
/** 获取当前导航栏+状态栏高度 */
+(CGFloat)getNav_StatusH;

/** 获取当前时间 */
+ (NSString *)getCurrentDate;

//判断app是否是第一次启动
+ (BOOL)isFirstLaunch;
//颜色转换为图片
+ (UIImage *)createImageWithColor:(UIColor *)color;
//二进制转十进制
+(NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary;

// 十进制转二进制
+ (NSArray *)toBinarySystemWithDecimalSystem:(NSInteger)decimal;
/*
 *  动画效果
 */
+ (void)yn_moveToPoint: (CGPoint)newPoint
              duration: (NSTimeInterval)duration
           autoreverse: (BOOL)autoreverse
           repeatCount: (CGFloat)repeatCount
        timingFunction: (CAMediaTimingFunction *)timingFunction
                  view: (UIView *)view;
/** 判断是不是手机号、email、身份证 */
+ (BOOL)validateMobile:(NSString *)mobile;

+ (BOOL)isValidEmail:(NSString *)email;

+ (BOOL)isValidIdCardNum:(NSString *)cardNum;
#pragma makr ----------------------消息提示页
//无数据
+(void)showNoDataViewWithParentView:(UIView*)parentView;
//无数据
+(void)showNoDataViewWithParentView:(UIView*)parentView WithMsg:(NSString *)msg WithCLickBlock:(UNNoDataViewPublicBlock)block;
+(void)hideNoDataViewWithParentView:(UIView*)parentView;
//接口返回错误
+(void)showErrorWithhtmlData:(NSData*)data;
//alert 弹窗
+(void)showAlertWithType:(TDTool_alert_type)type Withstr:(NSString*)str WithSecstr:(NSString*)secstr WithBtnTitleArray:(NSArray*)btnArray Withblock:(TDAlertViewBlock)block;
//alert 点赞
+(void)showPrsieAlertWithUUU:(NSString*)UUU Withblock:(TDAlertViewBlock)block;
//alert 消息提示
+(void)showAlertWithMsg:(NSString*)msg WithParentView:(UIView*)parentV;
//actionSheet
+(void)showActionSheetWithConfig:(NSArray*)config WithBlock:(UNActionSheetBlock)block;
#pragma mark ---------------------uiview 水品宽度自适应
+(void)layoutlabelWithMutilRow:(id)label;
+(void)layoutlabelWithlabel:(id)label;
#pragma mark---------------------------去掉标签
+(NSString *)filterHTML:(NSString *)html;
#pragma mark------文字处理
+(void)changeFontWithlabel:(UILabel*)label WithRange:(NSString*)subStr WithDefaultFont:(UIFont*)defaultFont WithchangeFont:(UIFont*)changFont;
+(NSArray<NSTextCheckingResult *> *)getBBSLetterSubStrRangeArrWithStr:(NSString *)str WithSubStr:(NSString*)toppattern;
+(CGSize)getsizeWithStr:(NSString*)str WithMaxSize:(CGSize)size WithFont:(UIFont*)font;
+(NSAttributedString*)getAttributeStrWithStr:(NSString*)str WithFont:(UIFont *)font WithColor:(UIColor *)color;
+(CGSize)getsizeWithStr:(NSString*)str WithMaxSize:(CGSize)size WithFont:(UIFont*)font WithlineSpace:(CGFloat)lineSpace;

//返回汉字个数
//+(NSInteger)getZh_chTextCountWithText:(NSString*)text;
//+(NSString*)subZH_chTextWithMaxCount:(NSInteger)maxCount WithText:(NSString*)text;
+(NSInteger)getCharacterCountWithText:(NSString*)text;
//+(NSString*)subCharacterTextWithMaxCount:(NSInteger)maxCount WithText:(NSString*)text;

#pragma mark----------------------------设置渐变色

/**
 @param isVertical  1  竖直    0 水瓶     2左上-右下  3左下-右上
 */
+(CAGradientLayer*)setGradientColorWithColorArray:(NSArray*)colorArray WithIsVer:(NSInteger)isVertical WithView:(UIView*)view;
/**
 定制渐变从y轴从0 开始的高度y
 
 @param colorArray 颜色
 @param isVertical  1  竖直    0 水瓶     2左上-右下  3左下-右上
 @param view 渐变父控件
 @param h 高度
 @return 渐变对象
 */
+(CAGradientLayer*)setGradientColorWithColorArray:(NSArray*)colorArray WithIsVer:(NSInteger)isVertical WithView:(UIView*)view WithH:(CGFloat)h;
#pragma mark -------------------------------投影

//圆形投影
+(CALayer*)addShadowWithView:(UIView*)view;
//圆形投影 自定义参数
+(CALayer*)addShadowWithView:(UIView *)view WithColor:(NSInteger)color WithCornerRadius:(CGFloat)cornerRadius WithShadowAlpha:(CGFloat)alpha;
//方形投影
+(void)addSquareShadowWithView:(UIView*)view;
//方形投影 自定义参数
+(void)addSquareShadowWithView:(UIView*)view WithColor:(NSInteger)color WithCornerRadius:(CGFloat)cornerRadius WithShadowAlpha:(CGFloat)alpha;
//局部圆角type  0:上左 上右
+(void)addCornerWithParentView:(UIView*)view Withtype:(NSInteger)type;
#pragma mark-------------------------导航条隐藏和显示
+(void)showNavigationBarLineWithCtrl:(UIViewController*)control;
+(void)hideNavigationBarLineWithCtrl:(UIViewController*)control;
@end
