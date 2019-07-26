//
//  LQCandleProtocol.h
//  LQ_KLine
//
//  Created by lq on 2018/6/15.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LQCandleModel;
@protocol LQCandleProtocol <NSObject>
@optional

/**
 获取当前屏幕内模型数组的开始下标以及个数

 @param leftPosition 当前屏幕最左边的位置
 @param index 下标
 @param count 个数
 */
- (void)displayScreenLeftPosition:(CGFloat)leftPosition startIndex:(NSInteger)index count:(NSInteger)count;



/**
 长按手势获取当前k线下标以及模型

 @param klineModelIndex 下标
 @param kLineModel 模型
 */
- (void)longPressCandleViewWithIndex:(NSInteger)klineModelIndex kLineModel:(LQCandleModel *)kLineModel;



/**
 返回当前屏幕最后一根k线模型

 @param candleModel k线模型
 */
- (void)displayLastModel:(LQCandleModel *)candleModel;





@end
