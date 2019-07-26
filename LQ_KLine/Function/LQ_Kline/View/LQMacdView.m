//
//  ZYWMacdView.m
//  ZYWChart
//
//  Created by 张有为 on 2017/3/13.
//  Copyright © 2017年 zyw113. All rights reserved.
//

#import "LQMacdView.h"
#import "LQIndexPositionModel.h"
#import "LQLineModel.h"
#import "LQCandleModel.h"
static inline bool isEqualZero(float value)
 {
    return fabsf(value) <= 0.00001f;
}

@interface LQMacdView()

@property (nonatomic,strong) NSMutableArray *displayArray;
@property (nonatomic,strong) NSMutableArray *macdArray;
@property (nonatomic,strong) NSMutableArray *deaArray;
@property (nonatomic,strong) NSMutableArray *diffArray;
@property (nonatomic,strong) CAShapeLayer   *macdLayer;

@end

@implementation LQMacdView

- (void)calcuteMaxAndMinValue
{
    CGFloat maxPrice = 0;
    CGFloat minPrice = 0;
    
    LQCandleModel *first = [self.displayArray objectAtIndex:0];
    maxPrice = MAX(first.DEA.floatValue, MAX(first.DIF.floatValue, first.MACD.floatValue));
    minPrice = MIN(first.DEA.floatValue, MIN(first.DIF.floatValue, first.MACD.floatValue));
    
    for (NSInteger i = 1;i<self.displayArray.count;i++)
    {
        LQCandleModel *macdData = [self.displayArray objectAtIndex:i];
        maxPrice = MAX(maxPrice, MAX(macdData.DEA.floatValue, MAX(macdData.DIF.floatValue, macdData.MACD.floatValue)));
        minPrice = MIN(minPrice, MIN(macdData.DEA.floatValue, MIN(macdData.DIF.floatValue, macdData.MACD.floatValue)));
        
        
    }
    self.kl_maxY = maxPrice;
    self.kl_minY = minPrice;
//    if (self.kl_maxY - self.kl_minY < 0.5)
//    {
//        self.kl_maxY += 0.5;
//        self.kl_minY += 0.5;
//    }
    self.kl_topMargin = 0;
    self.kl_bottomMargin = 5;
    self.kl_scaleY = (self.kl_maxY - self.kl_minY) / (self.lq_height - self.kl_topMargin - self.kl_bottomMargin);
    
}

- (void)initMaModelPosition
{
    
  //  NSLog(@"%f",self.height);
    // height  = 166

    for (NSInteger i = 0;i < self.displayArray.count;i++)
    {
        LQCandleModel *lineData = [self.displayArray objectAtIndex:i];
        CGFloat xPosition = self.leftPostion + ((self.candleSpace+self.candleWidth) * i) ;
        CGFloat yPosition = ABS((self.kl_maxY - lineData.MACD.floatValue)/self.kl_scaleY) + self.kl_topMargin ;
        //macd
        LQIndexPositionModel *model = [[LQIndexPositionModel alloc] init];
        model.endPoint = CGPointMake(xPosition, yPosition);
        model.startPoint = CGPointMake(xPosition,self.kl_maxY/self.kl_scaleY);
        
        float x = model.startPoint.y - model.endPoint.y;
        if (isEqualZero(x))
        {
            //柱线的最小高度
            model.endPoint = CGPointMake(xPosition,self.kl_maxY/self.kl_scaleY+1);
        }
        [self.macdArray addObject:model];
        
        //DIF
        CGFloat diffPostion = ABS((self.kl_maxY - lineData.DIF.floatValue)/self.kl_scaleY) +self.kl_topMargin;
        LQLineModel *difModel = [LQLineModel initPositionX:xPosition+self.candleWidth/2 yPosition:diffPostion];
        
        [self.diffArray addObject:difModel];
        
        //DEA
        CGFloat deayPostion = ABS((self.kl_maxY - lineData.DEA.floatValue)/self.kl_scaleY) + self.kl_topMargin;
        
        
        LQLineModel *deaModel = [LQLineModel initPositionX:xPosition+self.candleWidth/2 yPosition:deayPostion];
        [self.deaArray addObject:deaModel];
    }
}

- (CAShapeLayer*)drawMacdLayer:(LQIndexPositionModel*)model candleModel:(LQCandleModel *)candleModel
{
    CGRect rect;
    if (model.startPoint.y<=0)
    {
        rect = CGRectMake(model.startPoint.x,self.kl_topMargin, self.candleWidth, model.endPoint.y - model.startPoint.y);
    }
    
    else
    {
        rect = CGRectMake(model.startPoint.x,model.startPoint.y, self.candleWidth, model.endPoint.y - model.startPoint.y);
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    CAShapeLayer *subLayer = [CAShapeLayer layer];
    subLayer.path = path.CGPath;
    if (candleModel.MACD.floatValue >= 0)
    {
        subLayer.strokeColor = SEGreenColor.CGColor;
        subLayer.fillColor = SEGreenColor.CGColor;
    }
    else
    {
        subLayer.strokeColor = SERedColor.CGColor;
        subLayer.fillColor = SERedColor.CGColor;
    }
    return subLayer;
}


- (void)drawLine
{
    __weak typeof(self) this = self;
    [_macdArray enumerateObjectsUsingBlock:^(LQIndexPositionModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LQCandleModel *model = this.displayArray[idx];
        CAShapeLayer *layer = [this drawMacdLayer:obj candleModel:model];
        [this.macdLayer addSublayer:layer];
    }];

    UIBezierPath *deaPath = [UIBezierPath drawLine:self.deaArray];
    CAShapeLayer *deaLayer = [CAShapeLayer layer];
    deaLayer.path = deaPath.CGPath;
    deaLayer.strokeColor = [UIColor redColor].CGColor;
    deaLayer.fillColor = [[UIColor clearColor] CGColor];
    deaLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.macdLayer addSublayer:deaLayer];
    
    UIBezierPath *diffPath = [UIBezierPath drawLine:self.diffArray];
    CAShapeLayer *diffLayer = [CAShapeLayer layer];
    diffLayer.path = diffPath.CGPath;
    diffLayer.strokeColor = [UIColor blackColor].CGColor;
    diffLayer.fillColor = [[UIColor clearColor] CGColor];
    diffLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.macdLayer addSublayer:diffLayer];
}

- (void)removeFromSubLayer
{
    for (NSInteger i = 0 ; i < self.macdLayer.sublayers.count; i++)
    {
        CAShapeLayer *layer = (CAShapeLayer*)self.macdLayer.sublayers[i];
        [layer removeFromSuperlayer];
        layer = nil;
    }
    [self.macdLayer removeFromSuperlayer];
    self.macdLayer = nil;
}

- (void)removeAllObjectFromArray
{
    if (self.displayArray.count>0)
    {
        [self.displayArray removeAllObjects];
        [self.macdArray removeAllObjects];
        [self.deaArray removeAllObjects];
        [self.diffArray removeAllObjects];
    }
}

- (void)initLayer
{
    if (!self.macdLayer.sublayers.count)
    {
        [self.layer addSublayer:self.macdLayer];
    }
}

#pragma mark setter,getter
- (void)stockFill
{
    
    if (self.dataArray.count == 0) {
        return;
    }
    [self removeFromSubLayer];
    [self removeAllObjectFromArray];
    if (_startIndex +_displayCount > _dataArray.count)
    {
         [self.displayArray addObjectsFromArray:[self.dataArray subarrayWithRange:NSMakeRange(_startIndex,_displayCount-1)]];
    }
    
    else
    {
        [self.displayArray addObjectsFromArray:[self.dataArray subarrayWithRange:NSMakeRange(_startIndex,_displayCount)]];
    }
    [self layoutIfNeeded];
    [self calcuteMaxAndMinValue];
    [self initMaModelPosition];
    [self initLayer];
    [self drawLine];
}

#pragma mark lazyLoad
- (NSMutableArray*)macdArray
{
    if (!_macdArray)
    {
        _macdArray = [NSMutableArray array];
    }
    return _macdArray;
}

- (NSMutableArray*)deaArray
{
    if (!_deaArray)
    {
        _deaArray = [NSMutableArray array];
    }
    return _deaArray;
}

- (NSMutableArray*)diffArray
{
    if (!_diffArray)
    {
        _diffArray = [NSMutableArray array];
    }
    return _diffArray;
}

- (NSMutableArray*)displayArray
{
    if (!_displayArray)
    {
        _displayArray = [NSMutableArray array];
    }
    return _displayArray;
}

- (CAShapeLayer*)macdLayer
{
    if (!_macdLayer)
    {
        _macdLayer = [CAShapeLayer layer];
        _macdLayer.lineWidth = self.kl_lineWidth;
        _macdLayer.strokeColor = [UIColor clearColor].CGColor;
        _macdLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _macdLayer;
}

@end
