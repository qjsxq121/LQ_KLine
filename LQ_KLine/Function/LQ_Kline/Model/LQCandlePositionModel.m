//
//  LQCandlePositionModel.m
//  LQ_KLine
//
//  Created by lq on 2018/6/15.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import "LQCandlePositionModel.h"

@implementation LQCandlePositionModel

+ (instancetype) modelWithOpen:(CGPoint)openPoint close:(CGPoint)closePoint high:(CGPoint)highPoint low:(CGPoint)lowPoint date:(NSString*)date
{
    LQCandlePositionModel *candleModel = [LQCandlePositionModel new];
    candleModel.openPoint = openPoint;
    candleModel.closePoint = closePoint;
    candleModel.highPoint = highPoint;
    candleModel.lowPoint = lowPoint;
    candleModel.date = date;
    return candleModel;
}

@end
