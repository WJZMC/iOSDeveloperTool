//
//  TDAlertView.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    TDTool_alert_type_default_canCancel,
    TDTool_alert_type_default_noCancel,
    TDTool_alert_type_update,
    TDTool_alert_type_prise,
    TDTool_alert_type_onebutton
}TDTool_alert_type;
typedef void (^TDAlertViewBlock)(NSInteger index);//index 0:left 1:right
@interface TDAlertView : UIView
-(instancetype)initWithBlockWithType:(TDTool_alert_type)type Withstr:(NSString *)strfist WithSecStr:(NSString*)strsec WithBtnTitleArray:(NSArray*)btnarray WithBlock:(TDAlertViewBlock)block;
-(instancetype)initWithPriseAlertWithUUU:(NSString*)uuu WithBlock:(TDAlertViewBlock)block;

@end
