//
//  MVPTableViewCell.h
//  iOSTool
//
//  Created by jack wei on 2018/8/7.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVPPersenterDelegate.h"

@interface MVPTableViewCell : UITableViewCell<MVPPersenterDelegate>
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *add;

//local
@property(nonatomic,assign)NSInteger indexPathRow;
@property(nonatomic,weak) id<MVPPersenterDelegate> delegate;
@end
