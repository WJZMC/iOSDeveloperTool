//
//  Label_btn.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import "Label_btn.h"

@implementation Label_btn

-(void)layoutSubviews{
    [super layoutSubviews];

    [self.titleLabel sizeToFit];
    
    self.titleLabel.xc_x = self.xc_width - self.titleLabel.xc_width;
    
    self.titleLabel.xc_y = 0;
    
    
    
}

@end
