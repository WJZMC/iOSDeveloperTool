//
//  UILabel+SizeToFit.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.

#import "UILabel+SizeToFit.h"

@implementation UILabel (SizeToFit)

-(CGFloat)heightOfSizeToFitWith:(CGFloat)width{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = self.text;
    label.font = self.font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

-(CGFloat)widthOfSizeToFit{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = self.text;
    label.font = self.font;
    [label sizeToFit];
    return label.frame.size.width;
}

@end
