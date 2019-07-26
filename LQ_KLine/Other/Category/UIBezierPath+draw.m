//
//  UIBezierPath+draw.m
//  LQ_KLine
//
//  Created by lq on 2018/6/15.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import "UIBezierPath+draw.h"


@implementation UIBezierPath (draw)

+ (UIBezierPath *)drawLine:(NSMutableArray *)lineArray {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [lineArray enumerateObjectsUsingBlock:^(LQLineModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            [path moveToPoint:CGPointMake(obj.xPosition, obj.yPosition)];
        } else {
            [path addLineToPoint:CGPointMake(obj.xPosition, obj.yPosition)];
        }
    }];
    
    return path;
}

+ (UIBezierPath *)drawCandleWithHigh:(CGFloat)high open:(CGFloat)open low:(CGFloat)low close:(CGFloat)close candleWidth:(CGFloat)candleWidth rect:(CGRect)rect xPosition:(CGFloat)xPosition lineWidth:(CGFloat)lineWidth {
    UIBezierPath *candlePath = [UIBezierPath bezierPathWithRect:rect];
    candlePath.lineWidth = lineWidth;
    [candlePath moveToPoint:CGPointMake(xPosition + candleWidth / 2 - lineWidth / 2, high)];
    [candlePath addLineToPoint:CGPointMake(xPosition + candleWidth / 2 - lineWidth / 2, low)];
    
    return candlePath;
}
@end
