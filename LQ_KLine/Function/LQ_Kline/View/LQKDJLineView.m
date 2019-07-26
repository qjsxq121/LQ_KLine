//
//  ZYWKdjLineView.m
//  ZYWChart
//
//  Created by 张有为 on 2017/4/20.
//  Copyright © 2017年 zyw113. All rights reserved.
//

#import "LQKDJLineView.h"
#import "LQCandleModel.h"
#import "LQLineModel.h"

@interface LQKDJLineView()

@property (nonatomic,strong) CAShapeLayer *kLineLayer;
@property (nonatomic,strong) CAShapeLayer *dLineLayer;
@property (nonatomic,strong) CAShapeLayer *jLineLayer;

/** 展示的数据 */
@property (nonatomic, strong) NSMutableArray *displayArray;
@property (nonatomic,strong) NSMutableArray *kPostionArray;
@property (nonatomic,strong) NSMutableArray *dPostionArray;
@property (nonatomic,strong) NSMutableArray *jPostionArray;

@end

@implementation LQKDJLineView

#pragma mark Layer 相关


- (void)initLayer
{
    if (self.kLineLayer)
    {
        [self.kLineLayer removeFromSuperlayer];
        self.kLineLayer = nil;
    }
    
    if (!self.kLineLayer)
    {
        self.kLineLayer = [CAShapeLayer layer];
        self.kLineLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        self.kLineLayer.lineWidth = self.kl_lineWidth;
        self.kLineLayer.lineCap = kCALineCapRound;
        self.kLineLayer.lineJoin = kCALineJoinRound;
    }
    [self.layer addSublayer:self.kLineLayer];
    
    if (self.dLineLayer)
    {
        [self.dLineLayer removeFromSuperlayer];
        self.dLineLayer = nil;
    }
    
    if (!self.dLineLayer)
    {
        self.dLineLayer = [CAShapeLayer layer];
        self.dLineLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        self.dLineLayer.lineWidth = self.kl_lineWidth;
        self.dLineLayer.lineCap = kCALineCapRound;
        self.dLineLayer.lineJoin = kCALineJoinRound;
    }
    
    [self.layer addSublayer:self.dLineLayer];
    
    if (self.jLineLayer)
    {
        [self.jLineLayer removeFromSuperlayer];
        self.jLineLayer = nil;
    }
    
    if (!self.jLineLayer)
    {
        self.jLineLayer = [CAShapeLayer layer];
        self.jLineLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        self.jLineLayer.lineWidth = self.kl_lineWidth;
        self.jLineLayer.lineCap = kCALineCapRound;
        self.jLineLayer.lineJoin = kCALineJoinRound;
    }
    [self.layer addSublayer:self.jLineLayer];
}


// 求极值
- (void)initMaxAndMinValue
{
    [self layoutIfNeeded];
    self.kl_maxY = CGFLOAT_MIN;
    self.kl_minY  = CGFLOAT_MAX;

    LQCandleModel *firstModel = self.displayArray[0];
   CGFloat max = MAX(firstModel.KDJ_K.floatValue, MAX(firstModel.KDJ_J.floatValue, firstModel.KDJ_D.floatValue));
    
    CGFloat min = MIN(firstModel.KDJ_K.floatValue, MIN(firstModel.KDJ_J.floatValue, firstModel.KDJ_D.floatValue));
    
   
    for (NSInteger i = 1; i < self.displayArray.count; i++) {
        LQCandleModel *model = self.displayArray[i];
        
        if (!model.KDJ_D) {
            model.KDJ_D = @(max);
            model.KDJ_J = @(max);
            model.KDJ_K = @(max);
        }
        NSArray *array = @[model.KDJ_K,model.KDJ_D,model.KDJ_J,@(max),@(min)];
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
    self.kl_scaleY = (self.height - self.kl_topMargin - self.kl_bottomMargin)/(self.kl_maxY-self.kl_minY);
    
}


// 根据数据求位置
- (void)initLinesModelPosition
{
    [self.kPostionArray removeAllObjects];
    [self.dPostionArray removeAllObjects];
    [self.jPostionArray removeAllObjects];
    
    
    for (NSInteger i = 0; i < self.displayArray.count; i++) {
        LQCandleModel *model = self.displayArray[i];
     //   NSLog(@"RS%f\n  sum%f yyyy%f",model.RSI6.floatValue,model.sumTotalFluctute.floatValue,model.sumUpFluctute.floatValue);
        
        CGFloat xPosition = self.leftPostion + ((self.candleWidth  + self.candleSpace) * i) + self.candleWidth/2 + self.kl_leftMargin;
        
        
        CGFloat kYPosition = ((self.kl_maxY - model.KDJ_K.floatValue) *self.kl_scaleY) + self.kl_topMargin;
        // KDJ_K 的位置模型
        LQLineModel *kLineModel = [LQLineModel initPositionX:xPosition yPosition:kYPosition];
        [self.kPostionArray addObject:kLineModel];

        // KDJ_D
        CGFloat dYPosition = ((self.kl_maxY - model.KDJ_D.floatValue) * self.kl_scaleY) + self.kl_topMargin;
        LQLineModel *dLineModel = [LQLineModel initPositionX:xPosition yPosition:dYPosition];
        [self.dPostionArray addObject:dLineModel];
        
        // KDJ_J
        CGFloat jYPosition = ((self.kl_maxY - model.KDJ_J.floatValue) * self.kl_scaleY) + self.kl_topMargin;
        LQLineModel *jLineModel = [LQLineModel initPositionX:xPosition yPosition:jYPosition];
        [self.jPostionArray addObject:jLineModel];
    }
}

- (void)drawLineLayer
{
    UIBezierPath *kPath = [UIBezierPath drawLine:self.kPostionArray];
    self.kLineLayer.path = kPath.CGPath;
    self.kLineLayer.strokeColor = [UIColor redColor].CGColor;
    self.kLineLayer.fillColor = [[UIColor clearColor] CGColor];
    self.kLineLayer.contentsScale = [UIScreen mainScreen].scale;
    
    UIBezierPath *dPath = [UIBezierPath drawLine:self.dPostionArray];
    self.dLineLayer.path = dPath.CGPath;
    self.dLineLayer.strokeColor = [UIColor greenColor].CGColor;
    self.dLineLayer.fillColor = [[UIColor clearColor] CGColor];
    self.dLineLayer.contentsScale = [UIScreen mainScreen].scale;

    UIBezierPath *jPath = [UIBezierPath drawLine:self.jPostionArray];
    self.jLineLayer.path = jPath.CGPath;
    self.jLineLayer.strokeColor = [UIColor blueColor].CGColor;
    self.jLineLayer.fillColor = [[UIColor clearColor] CGColor];
    self.jLineLayer.contentsScale = [UIScreen mainScreen].scale;
}

#pragma mark 绘制

- (void)stockFill
{
    if (self.dataArray.count == 0) {
        return;
    }
    [self.displayArray removeAllObjects];
    [self.displayArray addObjectsFromArray:[self.dataArray subarrayWithRange:NSMakeRange(_startIndex,_displayCount)]];

    [self initMaxAndMinValue];
    [self initLayer];
    [self initLinesModelPosition];
    [self drawLineLayer];
}

#pragma mark lazyMethod

- (NSMutableArray *)displayArray {
    if (!_displayArray) {
        _displayArray = [NSMutableArray array];
    }
    return _displayArray;
}
- (NSMutableArray*)kPostionArray
{
    if (!_kPostionArray)
    {
        _kPostionArray = [NSMutableArray array];
    }
    return _kPostionArray;
}

- (NSMutableArray*)dPostionArray
{
    if (!_dPostionArray)
    {
        _dPostionArray = [NSMutableArray array];
    }
    return _dPostionArray;
}

- (NSMutableArray*)jPostionArray
{
    if (!_jPostionArray)
    {
        _jPostionArray = [NSMutableArray array];
    }
    return _jPostionArray;
}

@end
