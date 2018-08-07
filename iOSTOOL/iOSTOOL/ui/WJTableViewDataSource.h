//
//  WJTableViewDataSource.h
//  iOSTool
//
//  Created by jack wei on 2018/8/7.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^WJTableViewDataSourceBlock)(id cell,id model,NSInteger indexPathRow);
@interface WJTableViewDataSource : NSObject
@property(nonatomic,strong) NSArray *dataArray;
-(instancetype)initWithTable:(UITableView*)table WithReuseIdentifier:(NSString *)identifier WithBlock:(WJTableViewDataSourceBlock)block;
@end
