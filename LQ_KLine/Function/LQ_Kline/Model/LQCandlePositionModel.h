//
//  LQCandlePositionModel.h
//  LQ_KLine
//
//  Created by lq on 2018/6/15.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LQCandlePositionModel : NSObject


/**
 *  开盘点
 */
@property (nonatomic, assign) CGPoint openPoint;

/**
 *  收盘点
 */
@property (nonatomic, assign) CGPoint closePoint;

/**
 *  最高点
 */
@property (nonatomic, assign) CGPoint highPoint;

/**
 *  最低点
 */
@property (nonatomic, assign) CGPoint lowPoint;

/**
 *  日期
 */
@property (nonatomic, copy) NSString *date;

// 是否画日期
@property (nonatomic,assign) BOOL isDrawDate;

@property (assign, nonatomic) NSInteger localIndex;

+ (instancetype) modelWithOpen:(CGPoint)openPoint close:(CGPoint)closePoint high:(CGPoint)highPoint low:(CGPoint)lowPoint date:(NSString*)date;

@end
