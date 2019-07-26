//
//  ZYWTradePositionModel.h
//  ZYWChart
//
//  Created by lq on 2018/6/8.
//  Copyright © 2018年 zyw113. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQIndexPositionModel : NSObject
@property (nonatomic,assign) CGPoint startPoint;
@property (nonatomic,assign) CGPoint endPoint;

/** color */
@property (nonatomic, strong) UIColor *lineColor;

+ (instancetype)initPostion:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
@end
