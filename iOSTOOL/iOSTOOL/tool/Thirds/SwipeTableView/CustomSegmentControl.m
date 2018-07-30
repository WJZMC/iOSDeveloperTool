//
//  CustomSegmentControl.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
//

#import "CustomSegmentControl.h"
#import "UIView+STFrame.h"
#import "config.h"

@interface CustomSegmentControl ()
{
    CGFloat sizeHeight;
}
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) NSArray * items;

@end

@implementation CustomSegmentControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        sizeHeight = frame.size.height;
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithItems:(NSArray *)items {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        if (items.count > 0) {
            self.items = items;
        }
    }
    return self;
}

- (void)commonInit {
    
    sizeHeight = self.frame.size.height;
    
    _contentView = [UIView new];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    _font = [UIFont systemFontOfSize:15];
    _textColor = RGB(50, 50, 50);
    _selectedTextColor = RGB(0, 0, 0);
    _selectionIndicatorColor = RGB(150, 150, 150);
    _items = @[@"Segment0",@"Segment1"];
    _selectedSegmentIndex = 0;
    
//    底部的线
//    UILabel *Linelabel = [[UILabel alloc]init];
//    Linelabel.backgroundColor = kLineColor;
//    [self addSubview:Linelabel];
//    [Linelabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.left.right.equalTo(self);
//        make.height.equalTo(@0.5);
//    }];
    
//    lineLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth / self.items.count / 2 - kGetP(5)) + (kScreenWidth / self.items.count) * _selectedSegmentIndex, self.frame.size.height - kGetP(3), kGetP(10), kGetP(3))];
    _lineLab = [[UILabel alloc]init];//WithFrame:CGRectMake((kScreenWidth / self.items.count / 2 - kGetP(5)) + (kScreenWidth / self.items.count) * _selectedSegmentIndex, kGetP(44) - kGetP(3), kGetP(10), kGetP(3))];
    
    _lineLab.backgroundColor = kBlackColor;
    [self addSubview:_lineLab];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subView in _contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    _contentView.backgroundColor = _backgroundColor;
    _contentView.frame = self.bounds;
    for (int i = 0; i < _items.count; i ++) {
        UIButton * itemBt = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBt.tag = 666 + i;
        [itemBt setTitleColor:_textColor forState:UIControlStateNormal];
        [itemBt setTitleColor:_selectedTextColor forState:UIControlStateSelected];
        [itemBt setTitle:_items[i] forState:UIControlStateNormal];
        [itemBt.titleLabel setFont:_font];
        CGFloat itemWidth = self.st_width/_items.count;
        itemBt.st_size = CGSizeMake(itemWidth, self.st_height);
        itemBt.st_x    = itemWidth * i;
        if (i == _selectedSegmentIndex) {
            itemBt.backgroundColor = _selectionIndicatorColor;
            itemBt.selected = YES;
        }else {
            itemBt.backgroundColor = [UIColor clearColor];
        }
        [itemBt addTarget:self action:@selector(didSelectedSegment:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:itemBt];
        
       
    }
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    UIButton * oldItemBt      = [_contentView viewWithTag:666 + _selectedSegmentIndex];
    oldItemBt.backgroundColor = [UIColor clearColor];
    oldItemBt.selected        = NO;
    
    UIButton * itemBt      = [_contentView viewWithTag:666 + selectedSegmentIndex];
    itemBt.backgroundColor = _selectionIndicatorColor;
    itemBt.selected        = YES;
    _selectedSegmentIndex  = selectedSegmentIndex;
    
//    WDLog(@"%f", itemBt.width);
//    [UIView animateWithDuration:0.5 animations:^{
        _lineLab.frame = CGRectMake((self.bounds.size.width / self.items.count / 2 - kTransformP(10)) + (self.bounds.size.width / self.items.count) * _selectedSegmentIndex, self.frame.size.height - kTransformP(3), kTransformP(20), kTransformP(3));
//    }];
    
    
//    [self addSubview:self.lineLab];
//
//    [_lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.width.mas_equalTo(kGetP(20));
//        make.height.mas_equalTo(kGetP(3));
//    }];
}

- (void)didSelectedSegment:(UIButton *)itemBt {
    UIButton * oldItemBt      = [_contentView viewWithTag:666 + _selectedSegmentIndex];
    oldItemBt.backgroundColor = [UIColor clearColor];
    oldItemBt.selected        = NO;
    
    itemBt.backgroundColor = _selectionIndicatorColor;
    itemBt.selected        = YES;
    _selectedSegmentIndex  = itemBt.tag - 666;
    if (self.IndexChangeBlock) {
        self.IndexChangeBlock(_selectedSegmentIndex);
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    [UIView animateWithDuration:0.5 animations:^{
        _lineLab.frame = CGRectMake((self.bounds.size.width / self.items.count / 2 - kTransformP(10)) + (self.bounds.size.width / self.items.count) * _selectedSegmentIndex, self.frame.size.height - kTransformP(3), kTransformP(20), kTransformP(3));
//        lineLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth / self.items.count / 2 - kGetP(5)) + (kScreenWidth / self.items.count) * _selectedSegmentIndex, sizeHeight - kGetP(3), kGetP(10), kGetP(3))];
    }];
}

- (UILabel *)lineLab{
    if (!_lineLab) {
        _lineLab = [UILabel new];
        _lineLab.backgroundColor = kBlackColor;
        
    }
    return _lineLab;
}
@end





