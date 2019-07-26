//
//  LQRSILineView.h
//  Exchange
//
//  Created by lq on 2018/7/3.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import "LQBaseKLineView.h"
@class LQCandleModel;

@interface LQRSILineView : LQBaseKLineView

@property (nonatomic,strong) NSMutableArray <__kindof LQCandleModel*>*dataArray;
@property (nonatomic, assign) CGFloat leftPostion;
@property (nonatomic, assign) CGFloat candleWidth;
@property (nonatomic, assign) CGFloat candleSpace;
@property (nonatomic, assign) NSInteger startIndex;
@property (nonatomic, assign) NSInteger displayCount;

- (void)stockFill;
@end

