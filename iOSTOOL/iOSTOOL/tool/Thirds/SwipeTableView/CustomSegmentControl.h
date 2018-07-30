//
//  CustomSegmentControl.h
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import <UIKit/UIKit.h>

@interface CustomSegmentControl : UIControl

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *selectionIndicatorColor;
@property (nonatomic, assign) NSInteger selectedSegmentIndex;
@property (nonatomic, strong) UILabel *lineLab;
@property (nonatomic, copy) void (^IndexChangeBlock)(NSInteger index);

- (instancetype)initWithItems:(NSArray<NSString *> *)items;

@end
