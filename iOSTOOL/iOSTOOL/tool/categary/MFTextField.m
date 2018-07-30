//
//  MFTextField.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import "MFTextField.h"
#import "config.h"
@interface MFTextField ()

@property (strong, nonatomic)CALayer *underlineLayer;

@end

@implementation MFTextField
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer addSublayer:self.underlineLayer];
        self.hasUnderline = YES;
        self.textRightOffset = 0;
    }
    return self;
}
- (CALayer *)underlineLayer
{
    if (!_underlineLayer) {
        _underlineLayer = [[CALayer alloc]init];
        _underlineLayer.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1);
        _underlineLayer.backgroundColor = kBGColor.CGColor;//K_Color_10.CGColor;
        //        _underlineLayer.backgroundColor = [UIColor redColor].CGColor;
    }
    return _underlineLayer;
}
- (void)setHasUnderline:(BOOL)hasUnderline
{
    _hasUnderline = hasUnderline;
    self.underlineLayer.hidden = !_hasUnderline;
}


#pragma mark - Override

- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    return CGRectMake(self.leftView.width + self.leftTextOffset, bounds.origin.y, bounds.size.width - self.textRightOffset, bounds.size.height);
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectMake(self.leftView.width + self.leftTextOffset , bounds.origin.y, bounds.size.width - self.textRightOffset, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectMake(self.leftView.width + self.leftTextOffset, bounds.origin.y, bounds.size.width - self.textRightOffset, bounds.size.height);
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    return CGRectMake(0, 0, 39/2, 41/2);
}


- (void)setUp
{
    self.keyboardType = UIKeyboardTypeDefault;
    self.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.autocorrectionType=UITextAutocorrectionTypeNo;
    self.textColor = kBlackColor;//K_Color_03;
    self.borderStyle = UITextBorderStyleNone;
    self.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.placeholder = @"";
    self.text = @"";
    [self setValue:kBlackColor forKeyPath:@"_placeholderLabel.textColor"];
    [self setValue:kFontNomal(15) forKeyPath:@"_placeholderLabel.font"];
    
}
- (void)setPlaceholderTextColor:(NSString *)placeholderTextColor
{
    [self setValue:placeholderTextColor forKeyPath:@"_placeholderLabel.textColor"];
}
- (void)setPlaceholderFont:(CGFloat)placeholderFont
{
    [self setValue:[UIFont systemFontOfSize:placeholderFont] forKeyPath:@"_placeholderLabel.font"];
}

@end
