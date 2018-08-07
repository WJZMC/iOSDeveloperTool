//
//  MVPPersenterDelegate.h
//  iOSTool
//
//  Created by jack wei on 2018/8/7.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MVPPersenterDelegate <NSObject>
@optional
-(void)reloadData:(NSArray*)dataArray;

-(void)addActionWith:(NSInteger)indexPathRow;
@end
