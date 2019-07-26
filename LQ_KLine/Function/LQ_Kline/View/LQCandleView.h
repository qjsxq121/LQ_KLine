//
//  LQCandleView.h
//  LQ_KLine
//
//  Created by lq on 2018/6/15.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import "LQBaseKLineView.h"
#import "LQCandleProtocol.h"

@class LQCandleModel;



@interface LQCandleView : LQBaseKLineView <LQCandleProtocol>

/** 数据源 */
@property (nonatomic, strong) NSMutableArray <__kindof LQCandleModel *> *dataArray;

/** 当前屏幕范围内显示的k线模型数组 */
@property (nonatomic, strong) NSMutableArray *currentDisplayArray;

/** 当前屏幕显示k线位置数组 */
@property (nonatomic, strong) NSMutableArray *currentPositionArray;

/** 可视区域显示多少根k线 */
@property (nonatomic, assign) NSInteger displayCount;

/** k线之间的距离 */
@property (nonatomic, assign) CGFloat candleSpace;

/**
 k线的宽度 根据每页k线的根数和k线之间的距离动态计算得出
 */
@property (nonatomic,assign) CGFloat candleWidth;

/**
 k线最小高度
 */
@property (nonatomic,assign) CGFloat minHeight;

/**
 当前屏幕范围内绘制起点位置
 */
@property (nonatomic,assign) NSInteger leftPostion;

/**
 当前绘制的起始下标
 */
@property (nonatomic,assign) NSInteger currentStartIndex;

/**
 滑到最右侧的偏移量
 */
@property (nonatomic,assign) CGFloat previousOffsetX;

/**
 当前偏移量
 */
@property (nonatomic,assign) CGFloat contentOffset;

/** 显示时间的高度 */
@property (nonatomic, assign) CGFloat timeLayerHeight;


/** 时间格式 */
@property (nonatomic, copy) NSString *timeFormat;



@property (nonatomic, weak) id<LQCandleProtocol> delegate;


/** 指标类型 */
@property (nonatomic, assign) IndexViewType indexType;

/**
 长按手势返回对应model的相对位置
 
 @param xPostion 手指在屏幕的位置
 @return 距离手指位置最近的model位置
 */
- (CGPoint)getLongPressModelPostionWithXPostion:(CGFloat)xPostion;
- (instancetype)initWithHeight:(CGFloat)height;
// 计算宽度
- (void)calcuteCandleWidth;

// 更新宽度
- (void)updateWidthWithNoOffset;


/**
 画线
 */
- (void)drawLine;
- (void)stockFill;

- (void)reload;
@end
