//
//  UILabel+MyExtension.h
//  BFGP
//
//  Created by lq on 2017/10/17.
//  Copyright © 2017年 bfgp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MyExtension)

/**
 创建label

 @param title text
 @param textColor 颜色
 @param frame frame
 @param font 字体
 @param textAlignment 位置
 @return label
 */
+ (UILabel *)creatLabelWithTitle:(NSString *)title textColor:(UIColor *)textColor frame:(CGRect)frame font:(UIFont *)font textAlignment:(NSTextAlignment )textAlignment;


/**
 字体 和 颜色 创建 label
 
 @param textColor  字体颜色
 @param font 字体
 @return label
 */
+ (instancetype)creatLabelWithTextColor:(UIColor *)textColor font:(UIFont *)font;
@end
