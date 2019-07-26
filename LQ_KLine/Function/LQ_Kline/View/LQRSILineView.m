//
//  LQRSILineView.m
//  Exchange
//
//  Created by lq on 2018/7/3.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import "LQRSILineView.h"
#import "LQCandleModel.h"
#import "LQLineModel.h"
@interface LQRSILineView ()

@property (nonatomic,strong) CAShapeLayer *RSI6LineLayer;
@property (nonatomic,strong) CAShapeLayer *RSI12LineLayer;
@property (nonatomic,strong) CAShapeLayer *RSI24LineLayer;

/** 展示的数据 */
@property (nonatomic, strong) NSMutableArray *displayArray;
@property (nonatomic,strong) NSMutableArray *RSI6PostionArray;
@property (nonatomic,strong) NSMutableArray *RSI12PostionArray;
@property (nonatomic,strong) NSMutableArray *RSI24PostionArray;


@end
@implementation LQRSILineView

#pragma mark -- lazyMethod
- (CAShapeLayer *)RSI6LineLayer {
    if (!_RSI6LineLayer) {
        _RSI6LineLayer = [CAShapeLayer layer];
        _RSI6LineLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        _RSI6LineLayer.lineWidth = self.kl_lineWidth;
        _RSI6LineLayer.lineCap = kCALineCapRound;
        _RSI6LineLayer.lineJoin = kCALineJoinRound;
        _RSI6LineLayer.strokeColor = [UIColor redColor].CGColor;
        _RSI6LineLayer.fillColor = [[UIColor clearColor] CGColor];
        _RSI6LineLayer.contentsScale = [UIScreen mainScreen].scale;
        
    }
    return _RSI6LineLayer;
}

- (CAShapeLayer *)RSI12LineLayer {
    if (!_RSI12LineLayer) {
        _RSI12LineLayer = [CAShapeLayer layer];
        _RSI12LineLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        _RSI12LineLayer.lineWidth = self.kl_lineWidth;
        _RSI12LineLayer.lineCap = kCALineCapRound;
        _RSI12LineLayer.lineJoin = kCALineJoinRound;
        _RSI12LineLayer.strokeColor = [UIColor greenColor].CGColor;
        _RSI12LineLayer.fillColor = [[UIColor clearColor] CGColor];
        _RSI12LineLayer.contentsScale = [UIScreen mainScreen].scale;
        
    }
    return _RSI12LineLayer;
}
- (CAShapeLayer *)RSI24LineLayer {
    if (!_RSI24LineLayer) {
        _RSI24LineLayer = [CAShapeLayer layer];
        _RSI24LineLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        _RSI24LineLayer.lineWidth = self.kl_lineWidth;
        _RSI24LineLayer.lineCap = kCALineCapRound;
        _RSI24LineLayer.lineJoin = kCALineJoinRound;
        _RSI24LineLayer.strokeColor = [UIColor blueColor].CGColor;
        _RSI24LineLayer.fillColor = [[UIColor clearColor] CGColor];
        _RSI24LineLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _RSI24LineLayer;
}

- (NSMutableArray *)RSI6PostionArray {
    if (!_RSI6PostionArray) {
        _RSI6PostionArray = [NSMutableArray array];
    }
    return _RSI6PostionArray;
}

- (NSMutableArray *)RSI12PostionArray {
    if (!_RSI12PostionArray) {
        _RSI12PostionArray = [NSMutableArray array];
    }
    return _RSI12PostionArray;
}

- (NSMutableArray *)RSI24PostionArray {
    if (!_RSI24PostionArray) {
        _RSI24PostionArray = [NSMutableArray array];
    }
    return _RSI24PostionArray;
}

- (NSMutableArray *)displayArray {
    if (!_displayArray) {
        _displayArray = [NSMutableArray array];
    }
    return _displayArray;
}

// 初始化layer
- (void)initLayer {
    
    if (self.RSI6LineLayer) {
        [self.RSI6LineLayer removeFromSuperlayer];
        self.RSI6LineLayer = nil;
    }
    [self.layer addSublayer:self.RSI6LineLayer];
    
    if (self.RSI12LineLayer) {
        [self.RSI12LineLayer removeFromSuperlayer];
        self.RSI12LineLayer = nil;
    }
    [self.layer addSublayer:self.RSI12LineLayer];
    
    if (self.RSI24LineLayer) {
        [self.RSI24LineLayer removeFromSuperlayer];
        self.RSI24LineLayer = nil;
    }
    [self.layer addSublayer:self.RSI24LineLayer];
}


// 求极值
- (void)initMaxAndMinValue {
    self.kl_maxY = CGFLOAT_MIN;
    self.kl_minY  = CGFLOAT_MAX;
    
    LQCandleModel *firstModel = self.displayArray[0];
    CGFloat max = MAX(firstModel.RSI6.floatValue, MAX(firstModel.RSI12.floatValue, firstModel.RSI24.floatValue));
    
    CGFloat min = MIN(firstModel.RSI6.floatValue, MIN(firstModel.RSI12.floatValue, firstModel.RSI24.floatValue));
    
    
    for (NSInteger i = 1; i < self.displayArray.count; i++) {
        LQCandleModel *model = self.displayArray[i];
        
        if (!model.RSI24) {
            model.RSI24 = @(max);
        }
        if (!model.RSI12) {
            model.RSI12 = @(max);
        }
        if (!model.RSI6) {
            model.RSI6 = @(max);
        }
        NSArray *array = @[model.RSI6,model.RSI6,model.RSI24,@(max),@(min)];
        NSNumber *maxNm = [array valueForKeyPath:@"@max.floatValue"];
        NSNumber *minNm = [array valueForKeyPath:@"@min.floatValue"];
        
        max = maxNm.floatValue;
        min = minNm.floatValue;
    }
    
    self.kl_maxY = max;
    self.kl_minY = min;
    //self.kl_leftMargin = 2;
    self.kl_topMargin = 5;
    self.kl_bottomMargin = 5;
    self.kl_scaleY = (self.frame.size.height - self.kl_topMargin - self.kl_bottomMargin)/(self.kl_maxY-self.kl_minY);
}


// 根据数据求位置
- (void)initLinesModelPosition
{
    [self.RSI6PostionArray removeAllObjects];
    [self.RSI12PostionArray removeAllObjects];
    [self.RSI24PostionArray removeAllObjects];
    
    
    for (NSInteger i = 0; i < self.displayArray.count; i++) {
        LQCandleModel *model = self.displayArray[i];
        
        CGFloat xPosition = self.leftPostion + ((self.candleWidth  + self.candleSpace) * i) + self.candleWidth/2 + self.kl_leftMargin;
        
        
        CGFloat RSI6YPosition = ((self.kl_maxY - model.RSI6.floatValue) *self.kl_scaleY) + self.kl_topMargin;
        // KDJ_K 的位置模型
        LQLineModel *RSI6LineModel = [LQLineModel initPositionX:xPosition yPosition:RSI6YPosition];
        [self.RSI6PostionArray addObject:RSI6LineModel];
        
        // KDJ_D
        CGFloat RSI12YPosition = ((self.kl_maxY - model.RSI12.floatValue) * self.kl_scaleY) + self.kl_topMargin;
        LQLineModel *RSI12LineModel = [LQLineModel initPositionX:xPosition yPosition:RSI12YPosition];
        [self.RSI12PostionArray addObject:RSI12LineModel];
        
        // KDJ_J
        CGFloat RSI24YPosition = ((self.kl_maxY - model.RSI24.floatValue) * self.kl_scaleY) + self.kl_topMargin;
        LQLineModel *RSI24LineModel = [LQLineModel initPositionX:xPosition yPosition:RSI24YPosition];
        [self.RSI24PostionArray addObject:RSI24LineModel];
    }
}



- (void)drawLineLayer
{
    UIBezierPath *R6Path = [UIBezierPath drawLine:self.RSI6PostionArray];
    self.RSI6LineLayer.path = R6Path.CGPath;
  
    UIBezierPath *R12Path = [UIBezierPath drawLine:self.RSI12PostionArray];
    self.RSI12LineLayer.path = R12Path.CGPath;
    
    UIBezierPath *R24Path = [UIBezierPath drawLine:self.RSI24PostionArray];
    self.RSI24LineLayer.path = R24Path.CGPath;
    
}


#pragma mark 绘制

- (void)stockFill
{
    
    [self.displayArray removeAllObjects];
    [self.displayArray addObjectsFromArray:[self.dataArray subarrayWithRange:NSMakeRange(_startIndex,_displayCount)]];
    
    [self initMaxAndMinValue];
    [self initLayer];
    [self initLinesModelPosition];
    [self drawLineLayer];
}


@end
