//
//  UIBezierPath+draw.h
//  LQ_KLine
//
//  Created by lq on 2018/6/15.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (draw)

/**
 绘制折线
 
 @param lineArray 折线数组
 @return path
 */
+ (UIBezierPath *)drawLine:(NSMutableArray *)lineArray;


/**
 绘制蜡烛tu
 
 @param high 高
 @param open 开
 @param low 低
 @param close 收
 @param candleWidth 蜡烛宽度
 @param rect 绘制区域
 @param xPosition 绘制x坐标
 @param lineWidth 直线宽度
 @return path
 */
+ (UIBezierPath *)drawCandleWithHigh:(CGFloat)high open:(CGFloat)open low:(CGFloat)low close:(CGFloat)close candleWidth:(CGFloat)candleWidth rect:(CGRect)rect xPosition:(CGFloat)xPosition lineWidth:(CGFloat)lineWidth;
@end
