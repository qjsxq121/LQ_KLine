//
//  UIButton+MyExtention.h
//  BFGP
//
//  Created by lq on 2017/10/16.
//  Copyright © 2017年 bfgp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MyExtention)

/**
 创建button 传选中 和 正常 图片 和 字体颜色

 @param title title
 @param font 字体
 @param normalColor 正常颜色
 @param selectedColor 选中颜色
 @param normalName 正常图片
 @param selectImageName 选中图片
 @param target 事件
 @param selector 方法
 @return 按钮
 */
+ (UIButton *)creatButtonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor normalImageName:(NSString *)normalName selectImageName:(NSString *)selectImageName target:(id)target selector:(SEL)selector;


/**
 根据title和颜色创建button
 
 @param title title
 @param titleColor titleColor
 @param font 字体
 @return button
 */
+ (UIButton *)creatButtonWithTitle:(NSString *)title normalTitleColor:(UIColor *)titleColor font:(UIFont *)font;
@end
