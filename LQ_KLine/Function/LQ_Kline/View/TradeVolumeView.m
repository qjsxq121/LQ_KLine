//
//  TradeVolumeView.m
//  ZYWChart
//
//  Created by lq on 2018/6/7.
//  Copyright © 2018年 zyw113. All rights reserved.
//

#import "TradeVolumeView.h"
#import "LQCandleModel.h"

#import "LQIndexPositionModel.h"

@interface TradeVolumeView ()



/** 展示的数据 */
@property (nonatomic, strong) NSArray *showArray;

/** position数据源 */
@property (nonatomic, strong) NSMutableArray *positionArray;


/** layer */
@property (nonatomic, strong) CAShapeLayer *tradeLayer;
@end
@implementation TradeVolumeView


- (NSMutableArray *)positionArray {
    if (!_positionArray) {
        _positionArray = [NSMutableArray new];
    }
    return _positionArray;
}


- (CAShapeLayer *)tradeLayer {
    if (!_tradeLayer) {
        _tradeLayer = [CAShapeLayer layer];
        
        
        //_tradeLayer.lineWidth = _lineWidth;
       // _tradeLayer.strokeColor = [UIColor clearColor].CGColor;
       // _tradeLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
       // _tradeLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _tradeLayer;
}
// 计算极值
- (void)initMaxAndMinValue {
    [self layoutIfNeeded];
    
    self.kl_maxY = CGFLOAT_MIN;
    self.kl_minY = CGFLOAT_MAX;
    if (_displayCount >= self.dataArray.count) {
        _displayCount = self.dataArray.count;
    }
    self.showArray = [self.dataArray subarrayWithRange:NSMakeRange(_startIndex, _displayCount)];
    
    for (NSInteger i = 0; i < self.showArray.count; i++) {
        
        LQCandleModel *model = self.showArray[i];
        self.kl_maxY = self.kl_maxY > model.tradeNum ? self.kl_maxY : model.tradeNum;
    }
    
    self.kl_scaleY = (self.height - self.kl_topMargin - self.kl_bottomMargin) / self.kl_maxY;
    
    
    
}


// 计算坐标
- (void)initTradePosition {
    
    
    [self.positionArray removeAllObjects];
    for (NSInteger i = 0; i < self.showArray.count; i++) {
        LQCandleModel *model = self.showArray[i];
        CGFloat xPosition = self.leftPostion + ((self.candleSpace+self.candleWidth) * i);
//NSLog(@"%f",self.)
        CGFloat yPosition = (self.kl_maxY - model.tradeNum) *self.kl_scaleY + self.kl_topMargin;
       // NSLog(@"%f",yPosition);
        
        LQIndexPositionModel *positionModel = [[LQIndexPositionModel alloc] init];
        positionModel.endPoint = CGPointMake(xPosition, yPosition);
        positionModel.startPoint = CGPointMake(xPosition, self.height);
        
        // 开盘大于收盘  跌
        if (model.Open >= model.Close) {
            positionModel.lineColor = SERedColor;
        } else {
            positionModel.lineColor = SEGreenColor;
        }
        
        [self.positionArray addObject:positionModel];
    }
    
    
}


- (void)initLayer {
    if (!self.tradeLayer.sublayers.count) {
        [self.layer addSublayer:self.tradeLayer];
    }
}


- (void)removeAllSubLayer {
    for (NSInteger i = 0; i < self.tradeLayer.sublayers.count; i++) {
        CAShapeLayer *layer = (CAShapeLayer*)self.tradeLayer.sublayers[i];
        [layer removeFromSuperlayer];
        layer = nil;
    }
    
    [self.tradeLayer removeFromSuperlayer];
    self.tradeLayer = nil;
}

// 画
- (void)drawLine {
    
    for (LQIndexPositionModel  *model in self.positionArray) {
      
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(model.startPoint.x, model.startPoint.y, self.candleWidth, model.endPoint.y - model.startPoint.y)];

        CAShapeLayer *subLayer = [[CAShapeLayer alloc] init];

        subLayer.strokeColor = model.lineColor.CGColor;
        subLayer.fillColor = model.lineColor.CGColor;
        
        subLayer.path = path.CGPath;
        [self.tradeLayer addSublayer:subLayer];
        
    }
    
}


#pragma mark -- 绘制
- (void)stockFill {
    
    [self layoutIfNeeded];

    [self initMaxAndMinValue];
    
    // 初始化坐标
    [self initTradePosition];
    
    [self removeAllSubLayer];
    [self initLayer];
    
    [self drawLine];
}



@end
