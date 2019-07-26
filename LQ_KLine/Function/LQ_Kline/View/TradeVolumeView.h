//
//  TradeVolumeView.h
//  ZYWChart
//
//  Created by lq on 2018/6/7.
//  Copyright © 2018年 zyw113. All rights reserved.
//

#import "LQBaseKLineView.h"
@class LQCandleModel;

@interface TradeVolumeView : LQBaseKLineView
@property (nonatomic,assign) CGFloat    leftPostion;
@property (nonatomic,assign) NSInteger startIndex;
@property (nonatomic,assign) NSInteger displayCount;
@property (nonatomic,assign) CGFloat    candleWidth;
@property (nonatomic,assign) CGFloat    candleSpace;


/** 数据源 */
@property (nonatomic, strong) NSMutableArray <__kindof LQCandleModel *> *dataArray;
- (void)stockFill;
@end
