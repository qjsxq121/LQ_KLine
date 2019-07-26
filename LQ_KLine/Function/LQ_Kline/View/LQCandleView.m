//
//  LQCandleView.m
//  LQ_KLine
//
//  Created by lq on 2018/6/15.
//  Copyright © 2018年 YiYoff. All rights reserved.
//
// 蜡烛图
#import "LQCandleView.h"
#import "LQCandleModel.h"
#import "LQCandlePositionModel.h"

static inline bool isEqualZero(float value)
{
    return fabsf(value) <= 0.00001f;
}



@interface LQCandleView ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>




#pragma mark -- ma
/** ma7 */
@property (nonatomic, strong) CAShapeLayer *ma7Layer;

/** ma25 */
@property (nonatomic, strong) CAShapeLayer *ma25Layer;

/** MA位置数组 */
@property (nonatomic, strong) NSMutableArray *MAPositionArray;

#pragma mark -- EMA
/** EMA7 */
@property (nonatomic, strong) CAShapeLayer *EMA7Layer;

/** EMA25 */
@property (nonatomic, strong) CAShapeLayer *EMA25Layer;

/** EMA数组 */
@property (nonatomic, strong) NSMutableArray *EMAPositionArray;

#pragma mark -- BOLL
/** 上轨线 */
@property (nonatomic, strong) CAShapeLayer *bollUPLayer;

/** 中轨线 */
@property (nonatomic, strong) CAShapeLayer *bollMBLayer;

/** 下轨线 */
@property (nonatomic, strong) CAShapeLayer *bollDNLayer;

/** BOLL位置数组 */
@property (nonatomic, strong) NSMutableArray *BOLLPositionArray;

/** 时间layer */
@property (nonatomic, strong) CAShapeLayer *timeLayer;

/** 红 */
@property (nonatomic, strong) CAShapeLayer *redLayer;

/** 绿 */
@property (nonatomic, strong) CAShapeLayer *greenLayer;


/** 父view */
@property (nonatomic, weak) UIScrollView *superScrollView;





/** 最大值坐标 */
@property (nonatomic, strong) LQCandlePositionModel *maxValuePointModel;

/** 最小值坐标   */
@property (nonatomic, strong) LQCandlePositionModel *minValuePositionModel;

/** 整体的高度 */
@property (nonatomic, assign) CGFloat totalHeight;


/** 价格的最大值 */
@property (nonatomic, assign) CGFloat maxPrice;

/** 价格最小值 */
@property (nonatomic, assign) CGFloat minPrice;
@end

@implementation LQCandleView



- (instancetype)initWithHeight:(CGFloat)height {
    if (self = [super init]) {
        self.totalHeight = height;
    }
    return self;
}

#pragma mark -- lazyMethod
- (CAShapeLayer *)timeLayer {
    if (!_timeLayer) {
        _timeLayer = [CAShapeLayer layer];
        _timeLayer.contentsScale = [[UIScreen mainScreen] scale];
        _timeLayer.strokeColor = [UIColor clearColor].CGColor;
        _timeLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _timeLayer;
}

- (NSMutableArray *)currentDisplayArray {
    if (!_currentDisplayArray) {
        _currentDisplayArray = [NSMutableArray new];
    }
    return _currentDisplayArray;
}

- (NSMutableArray *)currentPositionArray {
    if (!_currentPositionArray) {
        _currentPositionArray = [NSMutableArray new];
    }
    return _currentPositionArray;
}

#pragma mark -- ma
- (CAShapeLayer *)ma7Layer {
    if (!_ma7Layer) {
        _ma7Layer = [CAShapeLayer layer];
        _ma7Layer.lineWidth = self.kl_lineWidth;
        _ma7Layer.lineCap = kCALineCapRound;
        _ma7Layer.lineJoin = kCALineJoinRound;
        _ma7Layer.strokeColor = [UIColor cyanColor].CGColor;
        _ma7Layer.fillColor = [UIColor clearColor].CGColor;
        _ma7Layer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _ma7Layer;
}

- (CAShapeLayer *)ma25Layer {
    if (!_ma25Layer) {
        _ma25Layer = [CAShapeLayer layer];
        _ma25Layer.lineWidth = self.kl_lineWidth;
        _ma25Layer.lineCap = kCALineCapRound;
        _ma25Layer.lineJoin = kCALineJoinRound;
        _ma25Layer.strokeColor = [UIColor magentaColor].CGColor;
        _ma25Layer.fillColor = [UIColor clearColor].CGColor;
        _ma25Layer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _ma25Layer;
}



- (NSMutableArray *)MAPositionArray {
    if (!_MAPositionArray) {
        _MAPositionArray = [NSMutableArray array];
    }
    return _MAPositionArray;
}


#pragma mark -- EMA
- (CAShapeLayer *)EMA7Layer {
    if (!_EMA7Layer) {
        _EMA7Layer = [CAShapeLayer layer];
        _EMA7Layer.lineWidth = self.kl_lineWidth;
        _EMA7Layer.lineCap = kCALineCapRound;
        _EMA7Layer.lineJoin = kCALineJoinRound;
        _EMA7Layer.strokeColor = [UIColor orangeColor].CGColor;
        _EMA7Layer.fillColor = [UIColor clearColor].CGColor;
        _EMA7Layer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _EMA7Layer;
}

- (CAShapeLayer *)EMA25Layer {
    if (!_EMA25Layer) {
        _EMA25Layer = [CAShapeLayer layer];
        _EMA25Layer.lineWidth = self.kl_lineWidth;
        _EMA25Layer.lineCap = kCALineCapRound;
        _EMA25Layer.lineJoin = kCALineJoinRound;
        _EMA25Layer.strokeColor = [UIColor blackColor].CGColor;
        _EMA25Layer.fillColor = [UIColor clearColor].CGColor;
        _EMA25Layer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _EMA25Layer;
}


- (NSMutableArray *)EMAPositionArray {
    if (!_EMAPositionArray) {
        _EMAPositionArray = [NSMutableArray array];
    }
    return _EMAPositionArray;
}

#pragma mark -- BOLL
- (CAShapeLayer *)bollUPLayer {
    if (!_bollUPLayer) {
        _bollUPLayer = [CAShapeLayer layer];
        _bollUPLayer.lineWidth = self.kl_lineWidth;
        _bollUPLayer.lineCap = kCALineCapRound;
        _bollUPLayer.lineJoin = kCALineJoinRound;
        _bollUPLayer.strokeColor = [UIColor purpleColor].CGColor;
        _bollUPLayer.fillColor = [UIColor clearColor].CGColor;
        _bollUPLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _bollUPLayer;
}

- (CAShapeLayer *)bollMBLayer {
    if (!_bollMBLayer) {
        _bollMBLayer = [CAShapeLayer layer];
        _bollMBLayer.lineWidth = self.kl_lineWidth;
        _bollMBLayer.lineCap = kCALineCapRound;
        _bollMBLayer.lineJoin = kCALineJoinRound;
        _bollMBLayer.strokeColor = [UIColor purpleColor].CGColor;
        _bollMBLayer.fillColor = [UIColor clearColor].CGColor;
        _bollMBLayer.contentsScale = [UIScreen mainScreen].scale;
        
    }
    return _bollMBLayer;
}


- (CAShapeLayer *)bollDNLayer {
    if (!_bollDNLayer) {
        _bollDNLayer = [CAShapeLayer layer];
        _bollDNLayer.lineWidth = self.kl_lineWidth;
        _bollDNLayer.lineCap = kCALineCapRound;
        _bollDNLayer.lineJoin = kCALineJoinRound;
        _bollDNLayer.strokeColor = [UIColor purpleColor].CGColor;
        _bollDNLayer.fillColor = [UIColor clearColor].CGColor;
        _bollDNLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _bollDNLayer;
}

- (NSMutableArray *)BOLLPositionArray {
    if (!_BOLLPositionArray) {
        _BOLLPositionArray = [NSMutableArray array];
    }
    return _BOLLPositionArray;
}
#pragma mark -- 初始化配置
- (void)initConfig {
   // self.kl_leftMargin = 2;
   // self.kl_rightMargin = 2;
    self.minHeight = 1;
}

#pragma mark -- 初始化layer

// 初始化和指标有关的layer
- (void)initDependentIndexLayer {
    
    if (self.redLayer) {
        [self.redLayer removeFromSuperlayer];
        self.redLayer = nil;
    }
    
    self.redLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.redLayer];
    
    
    if (self.greenLayer) {
        [self.greenLayer removeFromSuperlayer];
        self.greenLayer = nil;
    }
    
    self.greenLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.greenLayer];
    //ma7
    if (self.ma7Layer) {
        [self.ma7Layer removeFromSuperlayer];
        self.ma7Layer = nil;
    }
    [self.layer addSublayer:self.ma7Layer];

    // ma25
    if (self.ma25Layer) {
        [self.ma25Layer removeFromSuperlayer];
        self.ma25Layer = nil;
    }
    [self.layer addSublayer:self.ma25Layer];

    // EMA7
    if (self.EMA7Layer) {
        [self.EMA7Layer removeFromSuperlayer];
        self.EMA7Layer = nil;
    }
    [self.layer addSublayer:self.EMA7Layer];
    
    // EMA25
    if (self.EMA25Layer) {
        [self.EMA25Layer removeFromSuperlayer];
        self.EMA25Layer = nil;
    }
    [self.layer addSublayer:self.EMA25Layer];
    
    
   // BOLL
    if (self.bollUPLayer) {
        [self.bollUPLayer removeFromSuperlayer];
        self.bollUPLayer = nil;
    }
    [self.layer addSublayer:self.bollUPLayer];
    
    
    if (self.bollMBLayer) {
        [self.bollMBLayer removeFromSuperlayer];
        self.bollMBLayer = nil;
    }
    [self.layer addSublayer:self.bollMBLayer];
    
    if (self.bollDNLayer) {
        [self.bollDNLayer removeFromSuperlayer];
        self.bollDNLayer = nil;
    }
    [self.layer addSublayer:self.bollDNLayer];
}

// 初始化mainlayer
- (void)initMainLayer {
   
    // 时间
    if (self.timeLayer) {
        [self.timeLayer removeFromSuperlayer];
        self.timeLayer = nil;
    }
    [self.layer addSublayer:self.timeLayer];

}

- (void)removeAllSubTextLayer {
    
    if (self.timeLayer.sublayers.count > 0) {
        [self.timeLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    }

}

#pragma mark -- 系统方法self  添加到superView上时被调用
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    _superScrollView = (UIScrollView *)self.superview;
    _superScrollView.delegate = self;
    
}

#pragma mark -- 平移手势方法
- (void)panAction:(UIPanGestureRecognizer *)panGes {
    
}



#pragma mark -- 计算蜡烛的宽度
- (void)calcuteCandleWidth {
    self.candleWidth = (self.superScrollView.lq_width - (self.displayCount - 1) * self.candleSpace - self.kl_leftMargin - self.kl_rightMargin) / self.displayCount;
    
}


#pragma mark -- 更新宽度
- (void)updateWidth {
    CGFloat klineWidth = self.dataArray.count * (self.candleWidth) + (self.dataArray.count - 1) * self.candleSpace + self.kl_leftMargin + self.kl_rightMargin;
    
    if (klineWidth < self.superScrollView.lq_width) {
        klineWidth  = self.superScrollView.lq_width;
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(klineWidth);
    }];
    

    self.superScrollView.contentSize = CGSizeMake(klineWidth, 0);
    [self layoutIfNeeded];
    self.superScrollView.contentOffset = CGPointMake(klineWidth - self.superScrollView.lq_width, 0);
}


- (void)updateWidthWithNoOffset {
    if (self.dataArray.count == 0) {
        return;
    }
    
    CGFloat kLineWidth = self.dataArray.count * (self.candleWidth) + (self.dataArray.count - 1) * self.candleSpace + self.kl_leftMargin + self.kl_rightMargin;
    
    if (kLineWidth < self.superScrollView.lq_width) {
        kLineWidth = self.superScrollView.lq_width;
    }
    
    if (isnan(kLineWidth)) {
        return;
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kLineWidth);
    }];
    
    self.superScrollView.contentSize = CGSizeMake(kLineWidth, 0);
}

#pragma mark -- 初始化显示的数据
- (void)initCurrentDisplayModels {
    
    NSInteger needDrawKLineCount = self.displayCount;
#warning + 1 原来没有 
    NSInteger currentStartInex = self.currentStartIndex;
    NSInteger count = (currentStartInex + needDrawKLineCount) > self.dataArray.count ? self.dataArray.count : currentStartInex + needDrawKLineCount;
    [self.currentDisplayArray removeAllObjects];
    
    if (currentStartInex < count) {
        for (NSInteger i = currentStartInex; i < count; i++) {
            LQCandleModel *model = self.dataArray[i];
            model.localIndex = i;
            [self.currentDisplayArray addObject:model];
        }
    }
    
}

#pragma mark -- 绘制起点位置
- (NSInteger)leftPostion {
    CGFloat scrollViewOffsetX = _contentOffset < 0 ? 0 : _contentOffset;
    if (_contentOffset + self.superScrollView.lq_width >= self.superScrollView.contentSize.width) {
        scrollViewOffsetX = self.superScrollView.contentSize.width - self.superScrollView.lq_width;
    }
    
    return scrollViewOffsetX;
}


- (NSInteger)currentStartIndex {
    CGFloat scrollViewOffserX = self.leftPostion < 0 ? 0 : self.leftPostion;
    NSInteger leftArrcount = ABS(scrollViewOffserX) / (self.candleSpace + self.candleWidth);
    
    if (leftArrcount > self.dataArray.count) {
        _currentStartIndex = self.dataArray.count - 1;
    } else if (leftArrcount == 0) {
        _currentStartIndex = 0;
    } else {
        _currentStartIndex = leftArrcount;
    }
    
    return _currentStartIndex;
}

#pragma mark -- 计算MA极值
- (void)calcuteMAMaxAndMinValue {
    self.kl_maxY = CGFLOAT_MIN;
    self.kl_minY = CGFLOAT_MAX;
    
    self.maxPrice = CGFLOAT_MIN;
    self.minPrice = CGFLOAT_MAX;
    NSInteger index = 0;
    for (NSInteger i = index; i < self.currentDisplayArray.count; i++) {
        LQCandleModel *model = [self.currentDisplayArray objectAtIndex:i];
        self.kl_minY = self.kl_minY < model.Low ? self.kl_minY : model.Low;
        self.kl_maxY = self.kl_maxY > model.High ? self.kl_maxY : model.High;
        
        
        self.minPrice = self.minPrice < model.Low ? self.minPrice : model.Low;
        self.maxPrice = self.maxPrice > model.High ? self.maxPrice : model.High;
        // MA
        if (model.MA7) {
            self.kl_minY = self.kl_minY < model.MA7.floatValue ? self.kl_minY : model.MA7.floatValue;
            self.kl_maxY = self.kl_maxY > model.MA7.floatValue ? self.kl_maxY : model.MA7.floatValue;
        }
        
        if (model.MA25) {
            self.kl_minY = self.kl_minY < model.MA25.floatValue ? self.kl_minY : model.MA25.floatValue;
            self.kl_maxY = self.kl_maxY > model.MA25.floatValue ? self.kl_maxY : model.MA25.floatValue;
        }
        
     
    }
    
#warning view的高度获取不到
    // 缩放比
    if (self.kl_maxY == self.kl_minY) {
        self.kl_scaleY = 0;
    } else {
        self.kl_scaleY = (self.totalHeight - self.kl_topMargin - self.kl_bottomMargin - self.timeLayerHeight) / (self.kl_maxY - self.kl_minY);
        
    }
   // self.kl_scaleY = (self.totalHeight - self.kl_topMargin - self.kl_bottomMargin - self.timeLayerHeight) / (self.kl_maxY - self.kl_minY);
}

#pragma mark -- 计算EMA极值
- (void)calcuteEMAMaxAndMinValue {
    self.kl_maxY = CGFLOAT_MIN;
    self.kl_minY = CGFLOAT_MAX;
    
    NSInteger index = 0;
    for (NSInteger i = index; i < self.currentDisplayArray.count; i++) {
        LQCandleModel *model = [self.currentDisplayArray objectAtIndex:i];
        self.kl_minY = self.kl_minY < model.Low ? self.kl_minY : model.Low;
        self.kl_maxY = self.kl_maxY > model.High ? self.kl_maxY : model.High;
        
       
        // EMA
        if (model.EMA7) {
            self.kl_minY = self.kl_minY < model.EMA7.floatValue ? self.kl_minY : model.EMA7.floatValue;
            self.kl_maxY = self.kl_maxY > model.EMA7.floatValue ? self.kl_maxY : model.EMA7.floatValue;
        }
        if (model.EMA25) {
            self.kl_minY = self.kl_minY < model.EMA25.floatValue ? self.kl_minY : model.EMA25.floatValue;
            self.kl_maxY = self.kl_maxY > model.EMA25.floatValue ? self.kl_maxY : model.EMA25.floatValue;
        }
        
    }
    
    // 缩放比
    if (self.kl_maxY == self.kl_minY) {
        self.kl_scaleY = 0;
    } else {
        self.kl_scaleY = (self.totalHeight - self.kl_topMargin - self.kl_bottomMargin - self.timeLayerHeight) / (self.kl_maxY - self.kl_minY);
        
    }
   // self.kl_scaleY = (self.totalHeight - self.kl_topMargin - self.kl_bottomMargin - self.timeLayerHeight) / (self.kl_maxY - self.kl_minY);
}

#pragma mark -- 计算BOLL 极值
- (void)calcuteBOLLMaxAndMinValue {
    self.kl_maxY = CGFLOAT_MIN;
    self.kl_minY = CGFLOAT_MAX;
    
    NSInteger index = 0;
    for (NSInteger i = index; i < self.currentDisplayArray.count; i++) {
        LQCandleModel *model = [self.currentDisplayArray objectAtIndex:i];
        self.kl_minY = self.kl_minY < model.Low ? self.kl_minY : model.Low;
        self.kl_maxY = self.kl_maxY > model.High ? self.kl_maxY : model.High;
        
        
        // BOLL
        if (model.BOLL_UP) {
            self.kl_minY = self.kl_minY < model.BOLL_UP.floatValue ? self.kl_minY : model.BOLL_UP.floatValue;
            self.kl_maxY = self.kl_maxY > model.BOLL_UP.floatValue ? self.kl_maxY : model.BOLL_UP.floatValue;
        }
        if (model.BOLL_MB) {
            self.kl_minY = self.kl_minY < model.BOLL_MB.floatValue ? self.kl_minY : model.BOLL_MB.floatValue;
            self.kl_maxY = self.kl_maxY > model.BOLL_MB.floatValue ? self.kl_maxY : model.BOLL_MB.floatValue;
        }
        
        if (model.BOLL_DN) {
            self.kl_minY = self.kl_minY < model.BOLL_DN.floatValue ? self.kl_minY : model.BOLL_DN.floatValue;
            self.kl_maxY = self.kl_maxY > model.BOLL_DN.floatValue ? self.kl_maxY : model.BOLL_DN.floatValue;
        }
        
    }
    
    // 缩放比
    
    if (self.kl_maxY <= self.kl_minY) {
        self.kl_scaleY = 0;
    } else {
        self.kl_scaleY = (self.totalHeight - self.kl_topMargin - self.kl_bottomMargin - self.timeLayerHeight) / (self.kl_maxY - self.kl_minY);

    }
    
}
#pragma mark -- 计算位置
- (void)calcutePosition {
    [self.currentPositionArray removeAllObjects];

    CGFloat maxValue = CGFLOAT_MIN;
    CGFloat minValue = CGFLOAT_MAX;
    for (NSInteger i = 0; i < self.currentDisplayArray.count; i++) {
        LQCandleModel *model = [self.currentDisplayArray objectAtIndex:i];
        
//        NSLog(@"%f",self.kl_maxY);
//        NSLog(@"%f",model.high);

        CGFloat high = (self.kl_maxY - model.High) * self.kl_scaleY;
        CGFloat open = (self.kl_maxY - model.Open) * self.kl_scaleY;
        CGFloat low = (self.kl_maxY - model.Low) * self.kl_scaleY;
        CGFloat close = (self.kl_maxY - model.Close) * self.kl_scaleY;
//        if (self.kl_maxY - model.high <= 0) {
//            high = 0;
//        }
//        if (self.kl_maxY - model.open <= 0) {
//            open = 0;
//        }
//        if (self.kl_maxY - model.low <= 0) {
//            low = 0;
//        }
//        if (self.kl_maxY - model.close <= 0) {
//            close = 0;
//        }
        CGFloat left = self.leftPostion + ((self.candleWidth + self.candleSpace) * i) + self.kl_leftMargin;
        
        if (left >= self.superScrollView.contentSize.width) {
            left = self.superScrollView.contentSize.width - self.candleWidth / 2.0f;
        }
        
        LQCandlePositionModel *positionModel = [LQCandlePositionModel modelWithOpen:CGPointMake(left, open) close:CGPointMake(left, close) high:CGPointMake(left, high) low:CGPointMake(left, low) date:model.date];
        
        positionModel.isDrawDate = model.isDrawDate;
        positionModel.localIndex = model.localIndex;
        
        [self.currentPositionArray addObject:positionModel];
        
        // 获取最大值坐标
        if (maxValue <= model.High) {
            maxValue = model.High;
            
           CGFloat maxHigh = (self.kl_maxY - model.High) * self.kl_scaleY;
            self.maxValuePointModel = [LQCandlePositionModel modelWithOpen:CGPointMake(left, open) close:CGPointMake(left, close) high:CGPointMake(left, maxHigh) low:CGPointMake(left, low) date:nil];

        }
        
        if (minValue >= model.Low) {
            minValue = model.Low;
            
            CGFloat min = (self.kl_maxY - model.Low) * self.kl_scaleY;
            self.minValuePositionModel = [LQCandlePositionModel modelWithOpen:CGPointMake(left, open) close:CGPointMake(left, close) high:CGPointMake(left, min) low:CGPointMake(left, low) date:nil];
        }
    }
    

}





// 画蜡烛
- (void)drawCandelSublayers {

    CGMutablePathRef redRef = CGPathCreateMutable();
    CGMutablePathRef greenRef = CGPathCreateMutable();
    
    for (LQCandlePositionModel *model in _currentPositionArray) {
        // 开盘 < 收盘 涨
        if (model.openPoint.y <= model.closePoint.y) {
            [self addCandleRef:redRef position:model];
        }
        else  {
            [self addCandleRef:greenRef position:model];
        }
        
    }
    
    self.redLayer.lineWidth = (1 / [UIScreen mainScreen].scale) * 1.5f;
    self.redLayer.path = redRef;
    self.redLayer.fillColor = SERedColor.CGColor;
    self.redLayer.strokeColor = SERedColor.CGColor;
    
    self.greenLayer.lineWidth = (1 / [UIScreen mainScreen].scale) * 1.5f;
    self.greenLayer.path = greenRef;
    self.greenLayer.fillColor = SEGreenColor.CGColor;
    self.greenLayer.strokeColor = SEGreenColor.CGColor;
}

- (void)addCandleRef:(CGMutablePathRef)ref position:(LQCandlePositionModel *)position {
    
    CGFloat openY = position.openPoint.y + self.kl_topMargin;
    CGFloat closeY = position.closePoint.y + self.kl_topMargin;
    CGFloat highY = position.highPoint.y + self.kl_topMargin;
    CGFloat lowY = position.lowPoint.y + self.kl_topMargin;
    
    CGFloat x = position.openPoint.x;
    
    // 取小值
    CGFloat y = openY > closeY ? closeY : openY;
    
    // 高度
    CGFloat height = MAX(fabs(closeY - openY), _minHeight);
    
    CGRect rect = CGRectMake(x, y, self.candleWidth, height);
    
    if (isEqualZero(fabs(closeY - openY))) {
        rect = CGRectMake(x, closeY - height, _candleWidth, height);
    }
    
    CGPathAddRect(ref, NULL, rect);
    
    CGFloat xPosition = x + _candleWidth / 2;
    if (closeY < openY) {
        if (!isEqualZero(closeY - highY)) {
            CGPathMoveToPoint(ref, NULL, xPosition, closeY);
            CGPathAddLineToPoint(ref, NULL, xPosition, highY);
        }
        
        if (!isEqualZero(lowY - openY)) {
            CGPathMoveToPoint(ref, NULL, xPosition, lowY);
            CGPathAddLineToPoint(ref, NULL, xPosition, openY + self.kl_lineWidth / 2.f);
        }
    } else {
        if (!isEqualZero(openY - highY)) {
            CGPathMoveToPoint(ref, NULL, xPosition, openY);
            CGPathAddLineToPoint(ref, NULL, xPosition, highY);
        }
        if (!isEqualZero(lowY - closeY)) {
            CGPathMoveToPoint(ref, NULL, xPosition, lowY);
            CGPathAddLineToPoint(ref, NULL, xPosition, closeY - self.kl_lineWidth);
        }
    }
    
    
}


// 画ma
- (void)drawMaLayer {
    [self calcuteMaPosition];
    [self drawMALineLayer];
}

#pragma mark -- 计算ma位置
- (void)calcuteMaPosition {
    [self.MAPositionArray removeAllObjects];
    
    for (NSInteger jj = 0; jj < 2; jj++) {
        
        NSMutableArray *array = [NSMutableArray new];
        CGFloat ma = 0;
        UIColor *lineColor = nil;
        
        for (NSInteger i = 0; i < self.currentDisplayArray.count; i++) {
            LQCandleModel *model = self.currentDisplayArray[i];
            switch (jj) {
                case 0:
                    
                    if (!model.MA7) {
                        continue;
                    }
                    ma = model.MA7.floatValue;
                    lineColor = [UIColor cyanColor];
                    break;
                    
                case 1:
                    if (!model.MA25) {
                        continue;
                    }
                    ma = model.MA25.floatValue;
                    lineColor = [UIColor magentaColor];
                    break;
                
                default:
                    break;
            }
            
            CGFloat xPosition = self.leftPostion + ((self.candleWidth  + self.candleSpace) * i) + self.candleWidth/2;
            CGFloat yPosition = ((self.kl_maxY - ma) *self.kl_scaleY) + self.kl_topMargin;
            
            LQLineModel *lineModel = [LQLineModel initPositionX:xPosition yPosition:yPosition];
            
            [array addObject:lineModel];
        }
        [self.MAPositionArray addObject:array];
    }

}


#pragma mark -- 画MA
- (void)drawMALineLayer {
    
    if (self.MAPositionArray.count < 2) {
        return;
    }
    UIBezierPath *ma7Path = [UIBezierPath drawLine:self.MAPositionArray[0]];
    self.ma7Layer.path = ma7Path.CGPath;
   
    
    UIBezierPath *ma25Path = [UIBezierPath drawLine:self.MAPositionArray[1]];
    self.ma25Layer.path = ma25Path.CGPath;
    
}


#pragma mark -- 画EMA
- (void)drawEMALineLayer {
    [self calcuteEMAPasition];
    [self drawEMA];
}

// 1.计算位置
- (void)calcuteEMAPasition {
    [self.EMAPositionArray removeAllObjects];
    
    for (NSInteger jj = 0; jj < 2; jj++) {
        
        NSMutableArray *array = [NSMutableArray new];
        CGFloat ema = 0;
        
        for (NSInteger i = 0; i < self.currentDisplayArray.count; i++) {
            LQCandleModel *model = self.currentDisplayArray[i];
            switch (jj) {
                case 0:
                    
                    if (!model.EMA7) {
                        continue;
                    }
                    ema = model.EMA7.floatValue;
                    break;
                    
                case 1:
                    if (!model.EMA25) {
                        continue;
                    }
                    ema = model.EMA25.floatValue;
                    break;
                    
                default:
                    break;
            }
            
            CGFloat xPosition = self.leftPostion + ((self.candleWidth  + self.candleSpace) * i) + self.candleWidth/2;
            CGFloat yPosition = ((self.kl_maxY - ema) *self.kl_scaleY) + self.kl_topMargin;
            
            LQLineModel *lineModel = [LQLineModel initPositionX:xPosition yPosition:yPosition];
            
            [array addObject:lineModel];
        }
        [self.EMAPositionArray addObject:array];
    }
}


// 2 画EMA
- (void)drawEMA {
    
    if (self.EMAPositionArray.count < 2) {
        return;
    }
    UIBezierPath *ema7Path = [UIBezierPath drawLine:self.EMAPositionArray[0]];
    self.EMA7Layer.path = ema7Path.CGPath;
    
    
    UIBezierPath *ema25Path = [UIBezierPath drawLine:self.EMAPositionArray[1]];
    self.EMA25Layer.path = ema25Path.CGPath;
}


#pragma mark -- 画BOLL
- (void)drawBollLayer {
    [self calcuteBollPosition];
    [self drawBoll];
}


// 计算位置
- (void)calcuteBollPosition {
    [self.BOLLPositionArray removeAllObjects];
    
    for (NSInteger jj = 0; jj < 3; jj++) {
        
        NSMutableArray *array = [NSMutableArray new];
        CGFloat boll = 0;
        
        for (NSInteger i = 0; i < self.currentDisplayArray.count; i++) {
            LQCandleModel *model = self.currentDisplayArray[i];
            switch (jj) {
                case 0:
                    
                    if (!model.BOLL_UP) {
                        continue;
                    }
                    boll = model.BOLL_UP.floatValue;
                    break;
                    
                case 1:
                    if (!model.BOLL_MB) {
                        continue;
                    }
                    boll = model.BOLL_MB.floatValue;
                    break;
                case 2:
                    if (!model.BOLL_DN) {
                        continue;
                    }
                    boll = model.BOLL_DN.floatValue;
                    break;
                    
                default:
                    break;
            }
            
            CGFloat xPosition = self.leftPostion + ((self.candleWidth  + self.candleSpace) * i) + self.candleWidth/2;
            CGFloat yPosition = ((self.kl_maxY - boll) *self.kl_scaleY) + self.kl_topMargin;
            
            LQLineModel *lineModel = [LQLineModel initPositionX:xPosition yPosition:yPosition];
            
            [array addObject:lineModel];
        }
        [self.BOLLPositionArray addObject:array];
    }
}

// 画Boll
- (void)drawBoll {
    if (self.BOLLPositionArray.count < 3) {
        return;
    }
    UIBezierPath *bollUPPath = [UIBezierPath drawLine:self.BOLLPositionArray[0]];
    self.bollUPLayer.path = bollUPPath.CGPath;
    
    
    UIBezierPath *bollMBPath = [UIBezierPath drawLine:self.BOLLPositionArray[1]];
    self.bollMBLayer.path = bollMBPath.CGPath;
    
    UIBezierPath *bollDNPath = [UIBezierPath drawLine:self.BOLLPositionArray[2]];
    self.bollDNLayer.path = bollDNPath.CGPath;
}
#pragma mark -- 画时间
- (void)drawTimeLayer {
    
    [self.currentPositionArray enumerateObjectsUsingBlock:^(LQCandlePositionModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.isDrawDate) {
            
            // 时间
            CATextLayer *layer = [self getTextLayer];
            layer.string = [ToolClass stringWithTimestamp:[NSString stringWithFormat:@"%f",[model.date floatValue]] dateFormat:self.timeFormat];
            
            if (isEqualZero(model.highPoint.x)) {
                layer.frame = CGRectMake(0, self.totalHeight - self.timeLayerHeight , 60, self.timeLayerHeight);
            } else {
                layer.position = CGPointMake(model.highPoint.x + self.candleWidth, self.totalHeight - self.timeLayerHeight / 2);
                layer.bounds = CGRectMake(0, 0, 60, self.timeLayerHeight);
            }
            
            [self.timeLayer addSublayer:layer];
        }
    }];
}


// 获取layer
- (CATextLayer *)getTextLayer {
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.font = CFBridgingRetain(@"PingFangSC-Regular");
    textLayer.fontSize = 9.0f;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.foregroundColor = GaryTextColor.CGColor;
    
    return textLayer;
}

#pragma mark -- 画坐标系
- (void)drawAxisLine {
    
    
    // 时间顶部线
    CAShapeLayer *topTimeLayer = [self getTimeAxisLayer];
    UIBezierPath *topTimePath = [UIBezierPath bezierPath];
    [topTimePath moveToPoint:CGPointMake(0, self.height)];
    [topTimePath addLineToPoint:CGPointMake(self.width, self.height)];
    topTimeLayer.path = topTimePath.CGPath;
    [self.timeLayer addSublayer:topTimeLayer];
    // 时间底部线
    CAShapeLayer *bottomTimeLayer = [self getTimeAxisLayer];
    UIBezierPath *bottomTpath = [UIBezierPath bezierPath];
    [bottomTpath moveToPoint:CGPointMake(0, self.height - self.timeLayerHeight)];
    [bottomTpath addLineToPoint:CGPointMake(self.width, self.height - self.timeLayerHeight)];
    bottomTimeLayer.path = bottomTpath.CGPath;
    [self.timeLayer addSublayer:bottomTimeLayer];
    
    
    // 中间虚线
    CAShapeLayer *centerLayer = [self getCenterAxisLayer];
    UIBezierPath *centerPath = [UIBezierPath bezierPath];
    [centerPath moveToPoint:CGPointMake(0, (self.height - self.kl_topMargin - self.kl_bottomMargin - self.timeLayerHeight) / 2 + self.kl_topMargin)];
    [centerPath addLineToPoint:CGPointMake(self.width, (self.height - self.kl_topMargin - self.kl_bottomMargin - self.timeLayerHeight) / 2 + self.kl_topMargin)];
    centerLayer.path = centerPath.CGPath;
    [self.timeLayer addSublayer:centerLayer];
}

// 时间坐标系
- (CAShapeLayer *)getTimeAxisLayer {
    CAShapeLayer *timeAxisLayer = [CAShapeLayer layer];
    timeAxisLayer.strokeColor = UIColorHex(#E0E0E0).CGColor;
    timeAxisLayer.fillColor = [UIColor clearColor].CGColor;
    timeAxisLayer.contentsScale = [UIScreen mainScreen].scale;
    timeAxisLayer.lineWidth = 1.0;

    return timeAxisLayer;
}

// 中间虚线坐标系
- (CAShapeLayer *)getCenterAxisLayer {
    CAShapeLayer *centerAxisLayer = [CAShapeLayer layer];
    centerAxisLayer.strokeColor = UIColorHex(#E0E0E0).CGColor;
    centerAxisLayer.fillColor = [UIColor clearColor].CGColor;
    centerAxisLayer.contentsScale = [UIScreen mainScreen].scale;
    centerAxisLayer.lineWidth = 1.0;
    //虚线的间隔
    centerAxisLayer.lineDashPattern = @[@2, @2];
    return centerAxisLayer;
}
#pragma mark -- 画最大最小值
- (void)drawMaxAndMinLayer {
    CATextLayer *maxLayer = [self getTextLayer];
    CATextLayer *minLayer = [self getTextLayer];
    
    // 宽度
    CGFloat width = 60;
    // 最大值
    if (self.maxValuePointModel.highPoint.x - self.superScrollView.contentOffset.x > self.superScrollView.lq_width / 2) {
        maxLayer.string = [NSString stringWithFormat:@"%.7f→",self.maxPrice];
        maxLayer.frame = CGRectMake(self.maxValuePointModel.highPoint.x - 45 + self.candleWidth / 2 + self.kl_leftMargin, self.maxValuePointModel.highPoint.y + self.kl_topMargin - 3, width, 14);
    } else {
         maxLayer.frame = CGRectMake(self.maxValuePointModel.highPoint.x - 1, self.maxValuePointModel.highPoint.y + self.kl_topMargin - 10, width, 14);
        maxLayer.string = [NSString stringWithFormat:@"←%.7f",self.maxPrice];
    }
    
    // 最小值
    if (self.minValuePositionModel.highPoint.x - self.superScrollView.contentOffset.x > self.superScrollView.lq_width / 2) {
        minLayer.string = [NSString stringWithFormat:@"%.7f→",self.minPrice];
        minLayer.frame = CGRectMake(self.minValuePositionModel.highPoint.x - 45 + self.candleWidth / 2 + self.kl_leftMargin, self.minValuePositionModel.highPoint.y + self.kl_topMargin - 3, width, 14);
    } else {
        minLayer.frame = CGRectMake(self.minValuePositionModel.highPoint.x - 1, self.minValuePositionModel.highPoint.y + self.kl_topMargin - 10, width, 14);
        minLayer.string = [NSString stringWithFormat:@"←%.7f",self.minPrice];
    }
    
    [self.timeLayer addSublayer:maxLayer];
    [self.timeLayer addSublayer:minLayer];
}
#pragma mark -- 填充
- (void)stockFill {
    
    if (self.dataArray.count == 0) {
        return;
    }
    NSLog(@"%ld",self.dataArray.count);
    [self initConfig];
    [self initMainLayer];
    [self initDependentIndexLayer];
    
    [self calcuteCandleWidth];
    [self updateWidth];
    _indexType = IndexViewTypeSMA;
    [self drawLine];
}

#pragma mark -- 重载
- (void)reload
{
    if (self.dataArray.count == 0)
    {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(self.superScrollView.width));
        }];
        
        self.superScrollView.contentSize = CGSizeMake(self.superScrollView.width,0);
        return;
    }
    
    CGFloat prevContentOffset = self.superScrollView.contentOffset.x;
    CGFloat klineWidth = self.dataArray.count*(self.candleWidth) + (self.dataArray.count - 1) *self.candleSpace + self.kl_leftMargin + self.kl_rightMargin;
    if(klineWidth < self.superScrollView.width)
    {
        klineWidth = self.superScrollView.width;
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(klineWidth));
    }];
    
    self.superScrollView.contentSize = CGSizeMake(klineWidth,0);
    self.superScrollView.contentOffset = CGPointMake(prevContentOffset,0);
    [self layoutIfNeeded];
    [self drawLine];
}


- (void)drawLine {
    [self drawIndependentIndexLine];
    [self drawDependentIndexLine];
}
- (void)displayLayer:(CALayer *)layer {
    
    if (self.dataArray.count == 0) {
        return;
    }
     [self drawLine];
}

#pragma mark -- 画

// 画和指标无关的
- (void)drawIndependentIndexLine {
    [self initCurrentDisplayModels];
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(displayScreenLeftPosition:startIndex:count:)]) {
        [self.delegate displayScreenLeftPosition:self.leftPostion startIndex:self.currentStartIndex count:self.displayCount];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(displayLastModel:)]) {
        LQCandleModel *lastModel = self.currentDisplayArray.lastObject;
        [self.delegate displayLastModel:lastModel];
    }
    
   
}
// 画和指标有关的
- (void)drawDependentIndexLine {
    
    [self initDependentIndexLayer];
    if (_indexType == IndexViewTypeSMA) {
        [self calcuteMAMaxAndMinValue];
        [self drawMaLayer];

       
    }
    if (_indexType ==  IndexViewTypeEMA) {
        [self calcuteEMAMaxAndMinValue];
        [self drawEMALineLayer];
    }
    
    if (_indexType == IndexViewTypeBOLL) {
        [self calcuteBOLLMaxAndMinValue];
        [self drawBollLayer];
    }
    [self calcutePosition];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    [self removeAllSubTextLayer];
    [self drawMaxAndMinLayer];
    [self drawTimeLayer];
    [self drawAxisLine];
    [self drawCandelSublayers];
    [CATransaction commit];
   
}

- (void)setIndexType:(IndexViewType)indexType {
    if (_indexType == indexType) {
        return;
    }
    _indexType = indexType;
    [self drawDependentIndexLine];
}


#pragma mark 长按获取坐标

-(CGPoint)getLongPressModelPostionWithXPostion:(CGFloat)xPostion
{
    CGFloat localPostion = xPostion;
    NSInteger startIndex = (NSInteger)((localPostion - self.leftPostion) / (self.candleSpace + self.candleWidth));
    NSInteger arrCount = self.currentPositionArray.count;
    for (NSInteger index = startIndex > 0 ? startIndex - 1 : 0; index < arrCount; ++index) {
        LQCandlePositionModel *kLinePositionModel = self.currentPositionArray[index];
        
        CGFloat minX = kLinePositionModel.highPoint.x - (self.candleSpace + self.candleWidth/2);
        CGFloat maxX = kLinePositionModel.highPoint.x + (self.candleSpace + self.candleWidth/2);
        
        if(localPostion > minX && localPostion < maxX)
        {
            if(self.delegate && [self.delegate respondsToSelector:@selector(longPressCandleViewWithIndex:kLineModel:)])
            {
                [self.delegate longPressCandleViewWithIndex:index kLineModel:self.currentDisplayArray[index]];
            }
            
            return CGPointMake(kLinePositionModel.highPoint.x, kLinePositionModel.closePoint.y);
        }
    }
    
    //最后一根线
    LQCandlePositionModel *lastPositionModel = self.currentPositionArray.lastObject;
    
    if (localPostion >= lastPositionModel.closePoint.x)
    {
        return CGPointMake(lastPositionModel.highPoint.x, lastPositionModel.closePoint.y);
    }
    
    //第一根线
    LQCandlePositionModel *firstPositionModel = self.currentPositionArray.firstObject;
    if (firstPositionModel.closePoint.x >= localPostion)
    {
        return CGPointMake(firstPositionModel.highPoint.x, firstPositionModel.closePoint.y);
    }
    
    return CGPointZero;
}

#pragma mark -- scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.contentOffset = scrollView.contentOffset.x;
    [self.layer setNeedsDisplay];
    
}




@end
