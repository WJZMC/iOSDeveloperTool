

#import <UIKit/UIKit.h>

@interface PDPickerView : UIView

/** array */
@property (nonatomic,strong) NSArray *array;
/** title */
@property (nonatomic,strong) NSString *title;
//快速创建
+(instancetype)pickerView;
//弹出
-(void)show;

@property (copy, nonatomic) void(^dinnerTypeBlock)(NSString *title);
@property (copy, nonatomic) void(^addressResultBlock)(NSString *title);
@property (copy, nonatomic) void(^timeResultBlock)(NSString *title);

@end
