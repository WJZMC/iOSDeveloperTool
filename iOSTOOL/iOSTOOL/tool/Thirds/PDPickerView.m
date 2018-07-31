

#import "PDPickerView.h"
#import "config.h"
#define YLSRect(x, y, w, h)  CGRectMake([UIScreen mainScreen].bounds.size.width * x, [UIScreen mainScreen].bounds.size.height * y, [UIScreen mainScreen].bounds.size.width * w,  [UIScreen mainScreen].bounds.size.height * h)
#define YLSFont(f) [UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.width * f]
#define YLSColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define YLSMainBackColor [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1]
#define BlueColor [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1]
#define ClearColor [UIColor clearColor]

@interface PDPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

/** view */
@property (nonatomic,strong) UIView *topView;
/** button */
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UIButton *doneBtn;
/** pickerView */
@property (nonatomic,strong) UIPickerView *pickerView;
/** 选择传回的值 */
@property (nonatomic,strong) NSString *result;

@end

@implementation PDPickerView

//快速创建
+ (instancetype)pickerView
{
    return [[self alloc]init];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:YLSRect(0, 0, 1, 917/667)];
    if (self)
    {
        self.backgroundColor = YLSColorAlpha(0, 0, 0, 0.4);
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.topView = [[UIView alloc]initWithFrame:YLSRect(0, 667/667, 1, 250/667)];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    
    //为view上面的两个角做成圆角。不喜欢的可以注掉
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.topView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.topView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.topView.layer.mask = maskLayer;
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.cancelBtn setImage:[UIImage imageNamed:@"guanbi_green"] forState:UIControlStateNormal];
    [self.cancelBtn setFrame:YLSRect(15/375, 5/667, 50/375, 40/667)];
    self.cancelBtn.titleLabel.font = kFontNomal(16);
    [self.cancelBtn setTitleColor:kBlackColor forState:(UIControlStateNormal)];
    [self.cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [self.cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.cancelBtn];

    
    self.doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.doneBtn setImage:[UIImage imageNamed:@"yes_green"] forState:UIControlStateNormal];
    [self.doneBtn setFrame:YLSRect(320/375, 5/667, 50/375, 40/667)];
    self.doneBtn.titleLabel.font = kFontNomal(16);
    [self.doneBtn setTitleColor:kMainBlueColor forState:(UIControlStateNormal)];
    [self.doneBtn setTitle:@"确认" forState:(UIControlStateNormal)];
    [self.doneBtn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.doneBtn];
    
    UILabel *titlelb = [[UILabel alloc]initWithFrame:YLSRect(100/375, 0, 175/375, 50/667)];
    titlelb.backgroundColor = ClearColor;
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.text = self.title;
    titlelb.font = kFontNomal(16);
    [self.topView addSubview:titlelb];
    
    self.pickerView = [[UIPickerView alloc]init];
    [self.pickerView setFrame:YLSRect(0, 50/667, 1, 200/667)];
    [self.pickerView setBackgroundColor:YLSMainBackColor];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    [self.pickerView selectRow:0 inComponent:0 animated:YES];
    [self.topView addSubview:self.pickerView];
    
}

// 返回选择器有几列.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// 返回每组有几行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.array count];
}

#pragma mark - 代理
// 返回第component列第row行的内容（标题）
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.array[row];
}

// 选中第component第row的时候调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.result = self.array[row];
}

//弹出
- (void)show
{
    [self showInView:[UIApplication sharedApplication].keyWindow];
}



//添加弹出移除的动画效果
- (void)showInView:(UIView *)view
{
    // 浮现
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint point = self.center;
        point.y -= (250 + kViewSafeAreInsets(kWindows).bottom);
        self.center = point;
    } completion:^(BOOL finished) {
    }];
    [view addSubview:self];
}

- (void)cancel{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        CGPoint point = self.center;
        point.y += (250 + kViewSafeAreInsets(kWindows).bottom);
        self.center = point;
    } completion:^(BOOL finished) {
    }];
}

-(void)quit
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        CGPoint point = self.center;
        point.y += (250 + kViewSafeAreInsets(kWindows).bottom);
        self.center = point;
    } completion:^(BOOL finished) {
        if (!self.result) {
            self.result = self.array[0];
        }
        
        if (self.addressResultBlock) {
            self.addressResultBlock(self.result);
        }
        
        if (self.timeResultBlock) {
            self.timeResultBlock(self.result);
        }
        
        if (self.dinnerTypeBlock) {
            self.dinnerTypeBlock(self.result);
        }
        
        NSLog(@"%@",self.result);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"value" object:self.result];
        [self removeFromSuperview];
    }];
}

@end
