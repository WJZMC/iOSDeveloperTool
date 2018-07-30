//
//  UNApplicationTool.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import "UNApplicationTool.h"
#import "WJErrorWebVIew.h"
#import "config.h"
#import "UNActionSheet.h"
#define kNoDataViewTag 1000
#define kGlobalTag_alert 1001
#define kGlobalTag_actionSheet 1002
@implementation UNApplicationTool
+(NSString*)getApplicationDisplayName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}
+(NSString*)getApplicationVersion
{
    return  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
/** 获取当前导航栏高度 */
+(CGFloat)getNavH
{
    return kWindows.rootViewController.navigationItem.titleView.height;
}
/** 获取当前状态栏高度 */
+(CGFloat)getStatusH
{
    return kViewSafeAreInsets(kWindows).top;
}
/** 获取当前导航栏+状态栏高度 */
+(CGFloat)getNav_StatusH
{
    return [UNApplicationTool getStatusH]+[UNApplicationTool getNavH];
}
/** 获取当前时间 */
+ (NSString *)getCurrentDate{
    //    NSDate *date = [NSDate date];
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //    return [dateFormatter stringFromDate:date];
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%.0f", interval];
}
//判断app是否是第一次启动
+ (BOOL)isFirstLaunch{
    //获取本地保存的版本号
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *str = [userDefaults objectForKey:@"versions"];
    
    //获取当前APP的版本号
    NSString *appVersion = [self getApplicationVersion];
    
    if (str == nil || (![str isEqualToString:appVersion])) {
        [[NSUserDefaults standardUserDefaults] setObject:appVersion forKey:@"versions"];
        
        return YES;
    }else{
        
        return NO;
    }
}
//颜色转换为图片
+ (UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ref, [color CGColor]);
    CGContextFillRect(ref, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
//二进制转十进制
+(NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary{
    
    int ll = 0 ;
    int temp = 0 ;
    for (int i = 0; i < binary.length; i ++)
    {
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    NSString * result = [NSString stringWithFormat:@"%d",ll];
    
    return result;
}

// 十进制转二进制
+ (NSArray *)toBinarySystemWithDecimalSystem:(NSInteger)decimal{
    NSInteger num = decimal;
    NSInteger remainder = 0;      //余数
    NSInteger divisor = 0;        //除数
    NSString * prepare = @"";
    
    while (true){
        
        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%d",(int)remainder];
        
        if (divisor == 0)
        {
            break;
        }
    }
    
    NSString * result = @"";
    for (int i = (int)prepare.length - 1; i >= 0; i --)
    {
        result = [result stringByAppendingFormat:@"%@",[prepare substringWithRange:NSMakeRange(i , 1)]];
    }
    
    NSMutableString *str = [[NSMutableString alloc]init];
    if (result.length < 18) {
        for (int i=0; i<18-result.length; i++) {
            [str appendString:@"0"];
        }
        result = [NSMutableString stringWithFormat:@"%@%@",str,result];
    }
    
    //WDLog(@"result = %@",result);
    
    NSMutableArray *result_arr = [[NSMutableArray alloc]init];
    for (int i=0; i<result.length; i++) {
        [result_arr addObject:[result substringWithRange:NSMakeRange(i, 1)]];
    }
    
    return result_arr;
}
/*
 *  动画效果
 */
+ (void)yn_moveToPoint: (CGPoint)newPoint
              duration: (NSTimeInterval)duration
           autoreverse: (BOOL)autoreverse
           repeatCount: (CGFloat)repeatCount
        timingFunction: (CAMediaTimingFunction *)timingFunction
                  view: (UIView *)view
{
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath: @"position"];
    move.toValue = [NSValue valueWithCGPoint: newPoint];
    move.duration = duration;
    move.removedOnCompletion = NO;
    move.repeatCount = repeatCount;
    move.autoreverses = autoreverse;
    move.fillMode = kCAFillModeBoth;
    move.timingFunction = timingFunction != nil ? timingFunction : [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation: move forKey: @"positionAnimation"];
}

+ (BOOL)validateMobile:(NSString *)mobile {
    
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[67]|18[0-9])[0-9]{8}$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:mobile];
}

/* 邮箱验证 MODIFIED BY HELENSONG */
+ (BOOL)isValidEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/** 身份证验证  */
+ (BOOL)isValidIdCardNum:(NSString *)cardNum
{
    cardNum = [cardNum stringByReplacingOccurrencesOfString:@"X" withString:@"x"];
    cardNum = [cardNum stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int length = 0;
    if (!cardNum) {
        return NO;
    }else {
        length = (int)cardNum.length;
        if (length != 15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    NSString *valueStart2 = [cardNum substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag = YES;
            break;
        }
    }
    if (!areaFlag) {
        return NO;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    int year = 0;
    switch (length) {
        case 15:
            year = [cardNum substringWithRange:NSMakeRange(6,2)].intValue +1900;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"                   options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"           options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:cardNum options:NSMatchingReportProgress range:NSMakeRange(0, cardNum.length)];
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [cardNum substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19|20[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
                
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19|20[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:cardNum options:NSMatchingReportProgress range:NSMakeRange(0, cardNum.length)];
            if(numberofMatch > 0) {
                int S = ([cardNum substringWithRange:NSMakeRange(0,1)].intValue + [cardNum substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([cardNum substringWithRange:NSMakeRange(1,1)].intValue + [cardNum substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([cardNum substringWithRange:NSMakeRange(2,1)].intValue + [cardNum substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([cardNum substringWithRange:NSMakeRange(3,1)].intValue + [cardNum substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([cardNum substringWithRange:NSMakeRange(4,1)].intValue + [cardNum substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([cardNum substringWithRange:NSMakeRange(5,1)].intValue + [cardNum substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([cardNum substringWithRange:NSMakeRange(6,1)].intValue + [cardNum substringWithRange:NSMakeRange(16,1)].intValue) *2 + [cardNum substringWithRange:NSMakeRange(7,1)].intValue *1 + [cardNum substringWithRange:NSMakeRange(8,1)].intValue *6 + [cardNum substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                if ([M isEqualToString:[[cardNum substringWithRange:NSMakeRange(17,1)] uppercaseString]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
            }else {
                return NO;
            }
            
        default:
            return NO;
    }
    return NO;
}

//无数据
+(void)showNoDataViewWithParentView:(UIView*)parentView
{
    [UNApplicationTool showNoDataViewWithParentView:parentView WithMsg:@"没有相关数据" WithCLickBlock:^(NSString *str) {
        
    }];
}
//无数据
+(void)showNoDataViewWithParentView:(UIView*)parentView WithMsg:(NSString *)msg WithCLickBlock:(UNNoDataViewPublicBlock)block
{
    [UNApplicationTool hideNoDataViewWithParentView:parentView];
    UNNoDataView *msgView=[[UNNoDataView alloc]initWithFrame:CGRectMake(0, 0, kTransformP(300), kTransformP(78)+kTransformP(60)+kTransformP(20)) WithMsg:msg WithCLickBlock:block];//
    msgView.tag=kNoDataViewTag;
    msgView.backgroundColor=[UIColor clearColor];
    [parentView addSubview:msgView];
    //    CGPoint center=[msgView convertPoint:kWindows.center fromView:kWindows];
    [msgView setCenter:CGPointMake(parentView.width/2.0, parentView.centerY-kTransformP(32))];
    //    debugLog(@"--------------%f,%@",center.y,msgView);
    [parentView bringSubviewToFront:msgView];
}
+(void)hideNoDataViewWithParentView:(UIView *)parentView
{
    UIView *temp=[parentView viewWithTag:kNoDataViewTag];
    if (temp) {
        [temp removeFromSuperview];
        temp=nil;
    }
}
+(void)showErrorWithhtmlData:(NSData*)data
{
    UIWindow *key=[UIApplication sharedApplication].keyWindow;
    WJErrorWebVIew *error=[[WJErrorWebVIew alloc]initWithFrame:key.bounds WithhtmlData:data];
    [key addSubview:error];
    [key bringSubviewToFront:error];
}
+(void)showAlertWithType:(TDTool_alert_type)type Withstr:(NSString*)str WithSecstr:(NSString*)secstr WithBtnTitleArray:(NSArray*)btnArray Withblock:(TDAlertViewBlock)block
{
    UIView *temp=[[UIApplication sharedApplication].keyWindow viewWithTag:kGlobalTag_alert];
    if (temp) {
        [temp removeFromSuperview];
        temp=nil;
    }
    
    TDAlertView *alert=[[TDAlertView alloc]initWithBlockWithType:type Withstr:str WithSecStr:secstr WithBtnTitleArray:btnArray WithBlock:block];
    alert.tag=kGlobalTag_alert;
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    [alert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([UIApplication sharedApplication].keyWindow).with.insets(UIEdgeInsetsZero);
    }];
    
}
+(void)showPrsieAlertWithUUU:(NSString*)UUU Withblock:(TDAlertViewBlock)block
{
    UIView *temp=[[UIApplication sharedApplication].keyWindow viewWithTag:kGlobalTag_alert];
    if (temp) {
        [temp removeFromSuperview];
        temp=nil;
    }
    
    TDAlertView *alert=[[TDAlertView alloc]initWithPriseAlertWithUUU:UUU WithBlock:block];
    alert.tag=kGlobalTag_alert;
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    [alert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([UIApplication sharedApplication].keyWindow).with.insets(UIEdgeInsetsZero);
    }];
}
//alert 消息提示
+(void)showAlertWithMsg:(NSString*)msg WithParentView:(UIView*)parentV
{
    [CSToastManager sharedStyle].titleNumberOfLines=0;
    [parentV makeToast:msg duration:1.0f position:CSToastPositionCenter];
}
+(void)showActionSheetWithConfig:(NSArray*)config WithBlock:(UNActionSheetBlock)block
{
    UIView *temp=[[UIApplication sharedApplication].keyWindow viewWithTag:kGlobalTag_actionSheet];
    if (temp) {
        [temp removeFromSuperview];
        temp=nil;
    }
    
    UNActionSheet *alert=[[UNActionSheet alloc]initWithConfig:config WithBlock:block];
    alert.tag=kGlobalTag_actionSheet;
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    [alert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([UIApplication sharedApplication].keyWindow).with.insets(UIEdgeInsetsZero);
    }];
}
#pragma mark ---------------------uiview 水品宽度自适应
+(void)layoutlabelWithMutilRow:(id)label
{
    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [label setContentCompressionResistancePriority:UILayoutPriorityRequired
                                           forAxis:UILayoutConstraintAxisVertical];
}
+(void)layoutlabelWithlabel:(id)label
{
    //设置label1的content hugging 为1000
    [label setContentHuggingPriority:UILayoutPriorityRequired
                             forAxis:UILayoutConstraintAxisHorizontal];
    //设置label1的content compression 为1000
    [label setContentCompressionResistancePriority:UILayoutPriorityRequired
                                           forAxis:UILayoutConstraintAxisHorizontal];
}
#pragma mark---------------------------去掉标签
+(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    html=[html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    if ([html containsString:@"<"]) {
        NSRange endRange=[html rangeOfString:@"<"];
        debugLog(@"\n---------%ld,%ld-------%@-----\n",endRange.location,html.length,html);
        html=[html substringToIndex:endRange.location];
        debugLog(@"\n---------%ld,%ld-------%@-----\n",endRange.location,html.length,html);

    }
    return html;
}
#pragma mark------文字处理
+(void)changeFontWithlabel:(UILabel*)label WithRange:(NSString*)subStr WithDefaultFont:(UIFont*)defaultFont WithchangeFont:(UIFont*)changFont
{
    NSString *textLabel=label.text;
    NSMutableAttributedString *mutalStr = [[NSMutableAttributedString alloc] initWithString:textLabel];
    NSArray *tempArray=[UNApplicationTool getBBSLetterSubStrRangeArrWithStr:textLabel WithSubStr:subStr];
    for (int i=0; i<tempArray.count; i++) {
        NSRange range=[tempArray[i] range];
        [mutalStr addAttribute:NSFontAttributeName value:changFont range:range];
    }
    label.attributedText = mutalStr;
}
/**
 *获取需要处理的子字符串和子串的range
 */
+(NSArray<NSTextCheckingResult *> *)getBBSLetterSubStrRangeArrWithStr:(NSString *)str WithSubStr:(NSString*)toppattern{
    //[...]表情
    //@"\\[[a-zA-Z\\u4e00-\\u9fa5]+\\]"
    //    NSString *emopattern=@"\\[[\u4e00-\u9fa5\\w]+\\]" ;
    //#...#话题
    //@"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#"
    //   @"#[\u4e00-\u9fa5\\w\\s]+#";
    //    NSString *toppattern =  @"#[^#]+#";
    //    NSString *toppattern =  @"#([^\\#|.]+)#";
    
    //@...@
    //@"@[0-9a-zA-Z\\U4e00-\\u9fa5]+"
    //    NSString *atpattern = @"@[\u4e00-\u9fa5\\w]+";
    //url
    //@"http://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]"
    //    NSString *urlpattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    //    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@",emopattern,toppattern,atpattern,urlpattern];
    NSString *pattern = [NSString stringWithFormat:@"%@",toppattern];
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *results = [regular matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    return results;
}
+(CGSize)getsizeWithStr:(NSString*)str WithMaxSize:(CGSize)size WithFont:(UIFont*)font
{
    NSDictionary * attribute = @{NSFontAttributeName:font};
    CGRect resultSize= [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:attribute context:nil];
    return resultSize.size;
}
+(NSAttributedString*)getAttributeStrWithStr:(NSString*)str WithFont:(UIFont *)font WithColor:(UIColor *)color
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:kTransformP(4)];
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,str.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, str.length)];
    [attrStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, str.length)];
    return attrStr;
}
+(CGSize)getsizeWithStr:(NSString*)str WithMaxSize:(CGSize)size WithFont:(UIFont*)font WithlineSpace:(CGFloat)lineSpace
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:lineSpace];
    NSDictionary * attribute = @{NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:kBlackColor,NSFontAttributeName:font};
    NSAttributedString *attr=[[NSAttributedString alloc]initWithString:str attributes:attribute];
    CGSize contentSize=[attr boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return contentSize;
}
//+(NSInteger)getZh_chTextCountWithText:(NSString*)text
//{
//    NSStringEncoding enc=CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSData *da=[text dataUsingEncoding:enc];
//    return [da length];
//}
//+(NSString*)subZH_chTextWithMaxCount:(NSInteger)maxCount WithText:(NSString*)text
//{
//    NSString *resultStr;
//    NSInteger datalength=[UNApplicationTool getZh_chTextCountWithText:text];
//    if (datalength>maxCount) {
//        NSInteger tempLength=[text length];
//        for (NSInteger i=0; i<tempLength; i++) {
//            NSString *formstring=[text substringToIndex:i];
//            NSInteger data2Length=[UNApplicationTool getZh_chTextCountWithText:formstring];
//            if (data2Length==maxCount) {
//                resultStr=formstring;
//                break;
//            }
//        }
//    }else
//    {
//        resultStr=text;
//    }
//    return resultStr;
//
//}
+(NSInteger)getCharacterCountWithText:(NSString*)text
{
    int strlength = 0;
    char* p = (char*)[text cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[text lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}
//+(NSString*)subCharacterTextWithMaxCount:(NSInteger)maxCount WithText:(NSString*)text
//{
//    NSRange rangeRange = [text rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxCount)];
//    text = [text substringWithRange:rangeRange];
//
//    return text;
//}
// @param isVertical  1  竖直    0 水瓶     3左上-右下  2左下-右上
+(CAGradientLayer*)setGradientColorWithColorArray:(NSArray*)colorArray WithIsVer:(NSInteger)isVertical WithView:(UIView*)view
{
    return [UNApplicationTool setGradientColorWithColorArray:colorArray WithIsVer:isVertical WithView:view WithH:-1];
}
+(CAGradientLayer*)setGradientColorWithColorArray:(NSArray*)colorArray WithIsVer:(NSInteger)isVertical WithView:(UIView*)view WithH:(CGFloat)h
{
    [view.superview layoutIfNeeded];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame =CGRectMake(0, 0, view.width, h>0?h:view.height);
    gradient.colors = colorArray;
    if (isVertical==1) {
        gradient.startPoint = CGPointMake(0, 0);
        gradient.endPoint = CGPointMake(0, 1);
    }else if (isVertical==0)
    {
        gradient.startPoint = CGPointMake(0, 0);
        gradient.endPoint = CGPointMake(1, 0);
    }
    else if (isVertical==2)
    {
        gradient.startPoint = CGPointMake(0, 1);
        gradient.endPoint = CGPointMake(1, 1);
    }
    else if (isVertical==3)
    {
        gradient.startPoint = CGPointMake(1, 0);
        gradient.endPoint = CGPointMake(0, 1);
    }
    //    gradient.locations = @[@0.0, @0.2, @0.5];
    [view.layer insertSublayer:gradient atIndex:0];
    return gradient;
}

+(CALayer*)addShadowWithView:(UIView *)view
{
    return [UNApplicationTool addShadowWithView:view WithColor:0xb1bed3 WithCornerRadius:8 WithShadowAlpha:0.23];
}
+(CALayer*)addShadowWithView:(UIView *)view WithColor:(NSInteger)color WithCornerRadius:(CGFloat)cornerRadius WithShadowAlpha:(CGFloat)alpha
{
    CALayer *subLayer=[CALayer layer];
    subLayer.frame =CGRectMake(view.layer.frame.origin.x, view.layer.frame.origin.y, view.width,view.height+0);
    subLayer.cornerRadius=cornerRadius;
    subLayer.backgroundColor=[UIColor colorWithHex:color].CGColor;
    subLayer.masksToBounds=NO;
    subLayer.shadowColor=[[UIColor colorWithHex:color] colorWithAlphaComponent:1.0].CGColor;//shadowColor阴影颜色
    subLayer.shadowOffset=CGSizeMake(0,3);//shadowOffset阴影偏移,x向右偏移2，y向下偏移6，默认(0, -3),这个跟shadowRadius配合使用
    subLayer.shadowOpacity=alpha;  //阴影透明度，默认0
    subLayer.shadowRadius=view.layer.cornerRadius;//阴影半径，默认3
    
    
    //    CAGradientLayer *subLayer = [CAGradientLayer layer];
    //    subLayer.frame =CGRectMake(view.layer.frame.origin.x, view.layer.frame.origin.y, view.size.width,view.size.height+10);
    //    subLayer.colors = [NSArray arrayWithObjects:(id)kLight_B4Color colorWithAlphaComponent:0.3].CGColor,(id)[[UIColor colorWithHex:0xfafafa] colorWithAlphaComponent:0.7].CGColor, nil];
    //    subLayer.startPoint = CGPointMake(0, 0);
    //    subLayer.endPoint = CGPointMake(0, 1);
    //    subLayer.cornerRadius=view.layer.cornerRadius;//阴影半径，默认3
    //    subLayer.masksToBounds=YES;
    
    [view.superview.layer insertSublayer:subLayer below:view.layer];
    return subLayer;
}
//方形投影
+(void)addSquareShadowWithView:(UIView*)view
{
    [UNApplicationTool addSquareShadowWithView:view WithColor:0x383a60 WithCornerRadius:kTransformP(7) WithShadowAlpha:0.07];//
}
+(void)addSquareShadowWithView:(UIView*)view WithColor:(NSInteger)color WithCornerRadius:(CGFloat)cornerRadius WithShadowAlpha:(CGFloat)alpha
{
    view.layer.masksToBounds=NO;
    view.layer.shadowColor=[[UIColor colorWithHex:color] colorWithAlphaComponent:1.0].CGColor;//shadowColor阴影颜色
    view.layer.shadowOffset=CGSizeMake(0,5);//shadowOffset阴影偏移,x向右偏移2，y向下偏移6，默认(0, -3),这个跟shadowRadius配合使用
    view.layer.shadowOpacity=alpha;  //阴影透明度，默认0
    view.layer.shadowRadius=cornerRadius;
}
+(void)addCornerWithParentView:(UIView*)view Withtype:(NSInteger)type
{
    UIBezierPath *maskPath;
    if (type==0) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    }else
    {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    }
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
#pragma mark-------------------------导航条隐藏和显示
+(void)showNavigationBarLineWithCtrl:(UIViewController*)control
{
    //隐藏黑线（在viewWillAppear时隐藏，在viewWillDisappear时显示）
    UIImageView* blackLineImageView = [self findHairlineImageViewUnder:control.navigationController.navigationBar];
    blackLineImageView.hidden = NO;
}
+(void)hideNavigationBarLineWithCtrl:(UIViewController*)control
{
    //隐藏黑线（在viewWillAppear时隐藏，在viewWillDisappear时显示）
    UIImageView* blackLineImageView = [self findHairlineImageViewUnder:control.navigationController.navigationBar];
    blackLineImageView.hidden = YES;
}
+(UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}  
@end
