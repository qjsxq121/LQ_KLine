//
//  UILabel+MyExtension.m
//  BFGP
//
//  Created by lq on 2017/10/17.
//  Copyright © 2017年 bfgp. All rights reserved.
//

#import "UILabel+MyExtension.h"

@implementation UILabel (MyExtension)

+ (UILabel *)creatLabelWithTitle:(NSString *)title textColor:(UIColor *)textColor frame:(CGRect)frame font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = textColor;
    [label setFont:font];
    label.textAlignment = textAlignment;
    
    return label;
}


+ (instancetype)creatLabelWithTextColor:(UIColor *)textColor font:(UIFont *)font {
    UILabel *label = [UILabel new];
    [label setTextColor:textColor];
    [label setFont:font];
    return label;
}
@end
