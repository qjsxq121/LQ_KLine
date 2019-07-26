//
//  LQLineModel.m
//  LQ_KLine
//
//  Created by lq on 2018/6/15.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import "LQLineModel.h"

@implementation LQLineModel

+ (instancetype)initPositionX:(CGFloat)xPosition yPosition:(CGFloat)yPosition {
    LQLineModel *lineModel = [[LQLineModel alloc] init];
    lineModel.xPosition = xPosition;
    lineModel.yPosition = yPosition;
    
    return lineModel;
}
@end
