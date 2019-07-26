//
//  ZYWTradePositionModel.m
//  ZYWChart
//
//  Created by lq on 2018/6/8.
//  Copyright © 2018年 zyw113. All rights reserved.
//

#import "LQIndexPositionModel.h"

@implementation LQIndexPositionModel
+(instancetype)initPostion:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    LQIndexPositionModel *model = [[LQIndexPositionModel alloc] init];
    model.startPoint = startPoint;
    model.endPoint = endPoint;
    return model;
}
@end
