

#import "WDProgressHUD.h"
#import "config.h"
#define kScreen_height  [[UIScreen mainScreen] bounds].size.height
#define kScreen_width   [[UIScreen mainScreen] bounds].size.width
#define kDefaultRect     CGRectMake(0, 0, kScreen_width, kScreen_height)

#define kDefaultView [[UIApplication sharedApplication] keyWindow]

#define kGloomyBlackColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]
#define kGloomyClearCloler  [UIColor colorWithRed:1 green:1 blue:1 alpha:0]

/* 默认网络提示，可在这统一修改 */
static NSString *const kLoadingMessage = @"加载中";

/* 默认简短提示语显示的时间，在这统一修改 */
static CGFloat const   kShowTime  = 1.0f;

/* 默认超时时间，30s后自动去除提示框 */
static NSTimeInterval const interval = 30.0f;

/* 手势是否可用，默认yes，轻触屏幕提示框隐藏 */
static BOOL isAvalibleTouch = YES;

@implementation WDProgressHUD
UIView *gloomyView;//深色背景
UIView *prestrainView;//预加载view
BOOL isShowGloomy;//是否显示深色背景
#pragma mark -   类初始化
+ (void)initialize {
    if (self == [WDProgressHUD self]) {
        //该方法只会走一次
        [self customView];
    }
}
#pragma mark - 初始化gloomyView
+(void)customView {
    gloomyView = [[GloomyView alloc] initWithFrame:kDefaultRect];
    gloomyView.backgroundColor = kGloomyBlackColor;
    gloomyView.hidden = YES;
    isShowGloomy = YES;
}
+ (void)showGloomy:(BOOL)isShow {
    isShowGloomy = isShow;
}
#pragma mark - 简短提示语
+ (void) showBriefAlert:(NSString *) message inView:(UIView *) view{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.textColor = kMainBlueColor;
        hud.label.font = kFontNomal(15);
//        hud.bezelView.frame = CGRectMake(hud.bezelView.frame.origin.x, hud.bezelView.frame.origin.y, kGetP(144.5), kGetP(65.6));
//        hud.bezelView.layer.cornerRadius = kGetP(15);
//        hud.bezelView.layer.masksToBounds = YES;
        hud.removeFromSuperViewOnHide = YES;
        hud.label.text = message;
        hud.minShowTime = 2;
        [hud hideAnimated:YES];
    });
}
#pragma mark - 长时间的提示语
+ (void) showPermanentMessage:(NSString *)message inView:(UIView *) view{
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
        //        hud.backgroundColor = RGBA(0, 0, 0, 0.4);
        hud.mode = MBProgressHUDModeText;
        //        hud.bezelView.backgroundColor = [UIColor whiteColor];
        hud.label.textColor = kMainBlueColor;
        hud.label.font = kFontNomal(15);
        //        hud.bezelView.frame = CGRectMake(hud.bezelView.frame.origin.x, hud.bezelView.frame.origin.y, kGetP(144.5), kGetP(65.6));
        //        hud.bezelView.layer.cornerRadius = kGetP(15);
        //        hud.bezelView.layer.masksToBounds = YES;
        hud.removeFromSuperViewOnHide = YES;
        hud.label.text = message;
        hud.minShowTime = 2;
        [hud hideAnimated:YES];
    });
}
#pragma mark - 网络加载提示用
+ (void) showLoadingInView:(UIView *) view{
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
        hud.backgroundColor = kGloomyBlackColor;//
//        hud.backgroundColor = [UIColor clearColor];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.bezelView.backgroundColor = [UIColor whiteColor];
        hud.label.textColor = kMainBlueColor;
        hud.label.font = kFontNomal(15);
//        hud.bezelView.frame = CGRectMake(hud.bezelView.frame.origin.x, hud.bezelView.frame.origin.y, kGetP(144.5), kGetP(65.6));
//        hud.bezelView.layer.cornerRadius = kGetP(15);
//        hud.bezelView.layer.masksToBounds = YES;
        hud.removeFromSuperViewOnHide = YES;
        hud.label.text = kLoadingMessage;
        
        [hud showAnimated:YES];
        [self hideAlertDelay];
        
//        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:gloomyView];
//        hud.label.text = kLoadingMessage;
//        hud.removeFromSuperViewOnHide = YES;
//        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
//        kDefaultRect;
//        if (isShowGloomy) {
//            [self showBlackGloomyView];
//        }else {
//            [self showClearGloomyView];
//        }
//        [gloomyView addSubview:hud];
//        [hud showAnimated:YES];
//        [self hideAlertDelay];
    });
}
+ (void)showWaitingWithTitle:(NSString *)title inView:(UIView *)view {
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:gloomyView];
        hud.label.text = title;
        hud.removeFromSuperViewOnHide = YES;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        if (isShowGloomy) {
            [self showBlackGloomyView];
        }else {
            [self showClearGloomyView];
        }
        [gloomyView addSubview:hud];
        [hud showAnimated:YES];
        [self hideAlertDelay];
    });
}
+(void)showAlertWithCustomImage:(NSString *)imageName title:(NSString *)title inView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?:kDefaultView animated:YES];
        UIImageView *littleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
        littleView.image = [UIImage imageNamed:imageName];
        hud.customView = littleView;
        hud.removeFromSuperViewOnHide = YES;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.label.text = title;
        hud.mode = MBProgressHUDModeCustomView;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:kShowTime];
    });
}

+(void)showAlertWithCustomImage:(NSString *)imageName title:(NSString *)title detailTitle:(NSString *)detailTitle inView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        
//        prestrainView.backgroundColor = RGBA(255, 255, 255, 0.5);
        
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?:kDefaultView animated:YES];
        hud.backgroundColor = RGBA(0, 0, 0, 0.5);
        hud.label.textColor = [UIColor whiteColor];
//        hud. = [UIColor whiteColor];
        
        UIImageView *littleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
        littleView.image = [UIImage imageNamed:imageName];
        hud.customView = littleView;
        hud.removeFromSuperViewOnHide = YES;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.label.text = title;
        hud.detailsLabel.text = detailTitle;
        hud.mode = MBProgressHUDModeCustomView;
        [hud showAnimated:YES];
//        [hud hide:YES afterDelay:kShowTime];
    });
}


#pragma mark - 加载在window上的提示框
+(void)showLoading{
    [self showLoadingInView:nil];
}
+ (void)showWaitingWithTitle:(NSString *)title{
    [self showWaitingWithTitle:title inView:nil];
}
+(void)showBriefAlert:(NSString *)alert{
    [self showBriefAlert:alert inView:nil];
}
+(void)showPermanentAlert:(NSString *)alert{
    [self showPermanentMessage:alert inView:nil];
}
+(void)showAlertWithCustomImage:(NSString *)imageName title:(NSString *)title detailTitle:(NSString *)detailTitle{
    [self showAlertWithCustomImage:imageName title:title detailTitle:detailTitle inView:nil];
}

#pragma mark -   GloomyView背景色
+ (void)showBlackGloomyView {
    gloomyView.backgroundColor = kGloomyBlackColor;
    [self gloomyConfig];
}
+ (void)showClearGloomyView {
    gloomyView.backgroundColor = kGloomyClearCloler;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self gloomyConfig];
    });
}
#pragma mark -   决定GloomyView add到已给view或者window上
+ (void)gloomyConfig {
    gloomyView.hidden = NO;
    gloomyView.alpha = 1;
    if (prestrainView) {
        [prestrainView addSubview:gloomyView];
    }else {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (![window.subviews containsObject:gloomyView]) {
            [window addSubview:gloomyView];
        }
    }
}
#pragma mark - 隐藏提示框
+(void)hideAlert{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [WDProgressHUD HUDForView:[[[UIApplication sharedApplication] delegate] window]];//gloomyView];
        [UIView animateWithDuration:0.5 animations:^{
            gloomyView.frame = CGRectZero;
            gloomyView.center = prestrainView ? prestrainView.center: [UIApplication sharedApplication].keyWindow.center;
            gloomyView.alpha = 0;
            hud.alpha = 0;
        } completion:^(BOOL finished) {
            [hud hideAnimated:YES];
            [hud removeFromSuperview];
        }];
    });
    
}
#pragma mark -   超时后（默认30s）自动隐藏加载提示
+ (void)hideAlertDelay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideAlert];
    });
}
#pragma mark -   获取view上的hud
+ (MBProgressHUD *)HUDForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            return (MBProgressHUD *)subview;
        }
    }
    return nil;
}
@end


@implementation GloomyView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (isAvalibleTouch) {
        [WDProgressHUD hideAlert];
    }
}

@end
