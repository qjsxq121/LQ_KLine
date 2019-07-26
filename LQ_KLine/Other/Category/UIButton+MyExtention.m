//
//  UIButton+MyExtention.m
//  BFGP
//
//  Created by lq on 2017/10/16.
//  Copyright © 2017年 bfgp. All rights reserved.
//

#import "UIButton+MyExtention.h"

@implementation UIButton (MyExtention)

+ (UIButton *)creatButtonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor normalImageName:(NSString *)normalName selectImageName:(NSString *)selectImageName target:(id)target selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
     [button setTitleColor:selectedColor forState:UIControlStateSelected];
    [button.titleLabel setFont:font];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];

    return button;
}


+ (UIButton *)creatButtonWithTitle:(NSString *)title normalTitleColor:(UIColor *)titleColor font:(UIFont *)font {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    return button;
}
@end
