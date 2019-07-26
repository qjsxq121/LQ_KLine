//
//  LQDepthView.m
//  LQ_KLine
//
//  Created by lq on 2018/7/23.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import "LQDepthView.h"
#import "DepthGroupModel.h"
#import "DepathModel.h"
#import "LQLineModel.h"

@interface LQDepthView ()

/** buyPasitionArray */
@property (nonatomic, strong) NSMutableArray *buyPositionArray;

/** sellPosition */
@property (nonatomic, strong) NSMutableArray *sellPositionArray;

/** buyLayer */
@property (nonatomic, strong) CAShapeLayer *buyLayer;

/** sellLayer */
@property (nonatomic, strong) CAShapeLayer *sellLayer;

/** 价格的高度 */
@property (nonatomic,assign) CGFloat priceLayerHeight;

/** 坐标layer */
@property (nonatomic, strong) CAShapeLayer *coordinateLayer;
/** 文字 */
@property (nonatomic, strong) CAShapeLayer *textLayer;


/** 买 */
@property (nonatomic, strong) UILabel *buyLabel;

/** 卖 */
@property (nonatomic, strong) UILabel *sellLabel;

/** 比例 */
@property (nonatomic, strong) UILabel *precentLabel;


/** 买盘x比例 */
@property (nonatomic, assign) CGFloat buyScalX;

/** 卖盘x轴比例 */
@property (nonatomic, assign) CGFloat sellScalX;
@end



@implementation LQDepthView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.priceLayerHeight = 14;
        self.kl_topMargin = 74;
        
        [self.layer addSublayer:self.coordinateLayer];
        [self addAxisLayer];
        
        [self addSubviews];
        
       // [self tetttt];
      
    }
    return self;
}


- (void)addSubviews {
    
    // 底部线
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = LightLineColor;
    [self addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    
    CGFloat buttonWidht = self.lq_width / 6;
    CGFloat buttonHeight = self.lq_height / 8;
    // 卖
    UIButton *sellButton = [self creatButtonWithImage:@"sell_icon" title:@"卖"];
    [self addSubview:sellButton];
    
    [sellButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.width.mas_equalTo(buttonWidht);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    
    // 买
    UIButton *buyButton = [self creatButtonWithImage:@"buy_icon" title:@"买"];
    [self addSubview:buyButton];
    
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerY.height.mas_equalTo(sellButton);
        make.right.mas_equalTo(sellButton.mas_left);
    }];
    
    //
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cover_icon"]];
    [imageView sizeToFit];
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(13);
    }];
    
    self.buyLabel = [UILabel creatLabelWithTextColor:GaryTextColor font:TextFontWithSize(9)];
    [self addSubview:_buyLabel];
    
    [_buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageView.mas_left).mas_offset(-6);
        make.height.mas_equalTo(10);
        make.centerY.mas_equalTo(imageView);
    }];
    
    self.sellLabel = [UILabel creatLabelWithTextColor:GaryTextColor font:TextFontWithSize(9)];
    [self addSubview:_sellLabel];
    
    [_sellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).mas_offset(6);
        make.height.centerY.mas_equalTo(self.buyLabel);
    }];
    
    self.precentLabel = [UILabel creatLabelWithTextColor:GaryTextColor font:TextFontWithSize(9)];
    [self addSubview:_precentLabel];
    
    [_precentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(2);
        make.centerX.mas_equalTo(self);
    }];
    
    
}

- (void)tetttt {
    self.buyLabel.text = @"0.070737";
    self.sellLabel.text = @"0.070753";
    self.precentLabel.text = @"0.05%";
}

- (UIButton *)creatButtonWithImage:(NSString *)imageName title:(NSString *)title {
    UIButton *button = [UIButton creatButtonWithTitle:title normalTitleColor:GaryTextColor font:TextFontWithSize(13)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];

    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -4);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 0);
    return button;
}

// 赋值
- (void)setUIWithData {
    self.buyLabel.text = [NSString stringWithFormat:@"%0.7f",self.groupModel.buyArray.firstObject.price];
    self.sellLabel.text = [NSString stringWithFormat:@"%0.7f",self.groupModel.sellArray.firstObject.price];
    
    CGFloat precent = (self.groupModel.sellArray.firstObject.price - self.groupModel.buyArray.firstObject.price) / (self.groupModel.sellArray.lastObject.price - self.groupModel.buyArray.lastObject.price);
    
    self.precentLabel.text = [NSString stringWithFormat:@"%0.2f%%",precent];
}



- (CAShapeLayer *)coordinateLayer {
    if (!_coordinateLayer) {
        _coordinateLayer = [CAShapeLayer layer];
        _coordinateLayer.contentsScale = [[UIScreen mainScreen] scale];
        _coordinateLayer.strokeColor = [UIColor clearColor].CGColor;
        _coordinateLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _coordinateLayer;
}

- (CAShapeLayer *)textLayer {
    if (!_textLayer) {
        _textLayer = [CAShapeLayer layer];
        _textLayer.contentsScale = [[UIScreen mainScreen] scale];
        _textLayer.strokeColor = [UIColor clearColor].CGColor;
        _textLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _textLayer;
}

- (CAShapeLayer *)buyLayer {
    if (!_buyLayer) {
        _buyLayer = [CAShapeLayer layer];
        _buyLayer.lineWidth = 1.0;
        _buyLayer.lineCap = kCALineCapRound;
        _buyLayer.lineJoin = kCALineJoinRound;
        _buyLayer.strokeColor = SEGreenColor.CGColor;
       // _buyLayer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.3].CGColor;
        _buyLayer.fillColor = [UIColor clearColor].CGColor;
        _buyLayer.contentsScale = [UIScreen mainScreen].scale;

    }
    return _buyLayer;
}





- (CAShapeLayer *)sellLayer {
    if (!_sellLayer) {
        _sellLayer = [CAShapeLayer layer];
        _sellLayer.lineWidth = 1.0;
        _sellLayer.lineCap = kCALineCapRound;
        _sellLayer.lineJoin = kCALineJoinRound;
        _sellLayer.strokeColor = SERedColor.CGColor;
        _sellLayer.fillColor = [UIColor clearColor].CGColor;
;
        _sellLayer.contentsScale = [UIScreen mainScreen].scale;

    }
    return _sellLayer;
}


- (NSMutableArray *)sellPositionArray {
    if (!_sellPositionArray) {
        _sellPositionArray = [NSMutableArray new];
    }
    return _sellPositionArray;
}

- (NSMutableArray *)buyPositionArray {
    if (!_buyPositionArray) {
        _buyPositionArray = [NSMutableArray new];
    }
    return _buyPositionArray;
}

- (void)initLayer {
    
    if (self.buyLayer) {
        [self.buyLayer removeFromSuperlayer];
        self.buyLayer = nil;
    }
    [self.layer addSublayer:self.buyLayer];
    
    if (self.sellLayer) {
        [self.sellLayer removeFromSuperlayer];
        self.sellLayer = nil;
    }
    [self.layer addSublayer:self.sellLayer];

    if (self.textLayer.sublayers.count > 0) {
        [self.textLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];

    }
    
    if (self.textLayer) {
        [self.textLayer removeFromSuperlayer];
        self.textLayer = nil;
    }
    [self.layer addSublayer:self.textLayer];
}
// 求极值
- (void)initMaxAndMinValue {
    self.kl_maxX = CGFLOAT_MIN;
    self.kl_minX = CGFLOAT_MAX;
    
    self.kl_maxY = CGFLOAT_MIN;
    self.kl_minY = CGFLOAT_MAX;
    
    // 最后一个数据
    DepathModel *lastBuyModel = [_groupModel.buyArray lastObject];
    DepathModel *firstBuyModel = [DepathModel new];
    if (_groupModel.buyArray.count > 0) {
        firstBuyModel = _groupModel.buyArray[0];
    }
    DepathModel *lastSellModel = [_groupModel.sellArray lastObject];
    DepathModel *firstSellModel = [DepathModel new];
    if (_groupModel.sellArray.count > 0) {
        firstSellModel = _groupModel.sellArray[0];
    }
    // y轴  委托量
    self.kl_minY = firstBuyModel.sumOfNum.floatValue < firstSellModel.sumOfNum.floatValue ? firstBuyModel.sumOfNum.floatValue : firstSellModel.sumOfNum.floatValue;
    self.kl_maxY = lastBuyModel.sumOfNum.floatValue > lastSellModel.sumOfNum.floatValue ? lastBuyModel.sumOfNum.floatValue : lastSellModel.sumOfNum.floatValue;
    
//    // x轴 价格
//    self.kl_maxX = _groupModel.buyArray[0].price > lastSellModel.price ? _groupModel.buyArray[0].price : lastSellModel.price ;
//    self.kl_minX = lastBuyModel.price < _groupModel.sellArray[0].price ? lastBuyModel.price : _groupModel.sellArray[0].price;
    
    
    self.kl_scaleY = (self.lq_height - self.kl_topMargin - self.priceLayerHeight) / (self.kl_maxY - self.kl_minY);
//    self.kl_scaleX = (self.lq_width - self.kl_leftMargin - self.kl_rightMargin) / (self.kl_maxX - self.kl_minX);
    
    self.buyScalX = self.lq_width / 2 / (firstBuyModel.price - [_groupModel.buyArray lastObject].price);
    self.sellScalX = self.lq_width / 2 / ([_groupModel.sellArray lastObject].price - firstSellModel.price);
}


// 根据数据求位置
- (void)initLinesModelPosition {
    [self.buyPositionArray removeAllObjects];
    [self.sellPositionArray removeAllObjects];
    // 买
    for (NSInteger i = 0; i < _groupModel.buyArray.count; i ++) {
        DepathModel *model = _groupModel.buyArray[i];
        CGFloat buyYP = (self.kl_maxY - model.sumOfNum.floatValue) * self.kl_scaleY + self.kl_topMargin;
        CGFloat buyXP =( model.price - [_groupModel.buyArray lastObject].price) * self.buyScalX;
        
        LQLineModel *buyLineModel = [LQLineModel initPositionX:buyXP yPosition:buyYP];
        [self.buyPositionArray addObject:buyLineModel];
    }
    
    
    for (NSInteger i = 0; i < _groupModel.sellArray.count; i++) {
        DepathModel *model = _groupModel.sellArray[i];
        CGFloat sellYP = (self.kl_maxY - model.sumOfNum.floatValue) * self.kl_scaleY + self.kl_topMargin;
        CGFloat sellXP = ( model.price - _groupModel.sellArray[0].price) * self.sellScalX + self.lq_width / 2;
        
        LQLineModel *sellLineModel = [LQLineModel initPositionX:sellXP yPosition:sellYP];
        [self.sellPositionArray addObject:sellLineModel];


    }
}

// 画坐标系
- (void)addAxisLayer {
    // 画 横坐标
    CGFloat itemHeight = (self.lq_height - self.priceLayerHeight) / 8;
    for (NSInteger i = 1; i < 8; i++) {
        CAShapeLayer *layer = [self getHorAxisLayer];
        CGFloat y = self.lq_height - itemHeight * i - self.priceLayerHeight;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, y)];
        [path addLineToPoint:CGPointMake(self.lq_width, y)];
        
        layer.path = path.CGPath;
        [self.coordinateLayer addSublayer:layer];
    }
    
    // 纵向
    CGFloat itemWidth = self.lq_width / 6;
    for (NSInteger i = 1; i < 6; i ++) {
        CGFloat x = i * itemWidth;
        CAShapeLayer *layer = [self getVerAxisLayer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(x, self.lq_height - self.priceLayerHeight)];
        [path addLineToPoint:CGPointMake(x, self.priceLayerHeight)];
        
        layer.path = path.CGPath;
        [self.coordinateLayer addSublayer:layer];
    }
    
    
}


- (void)drawNumTextLayer {
    
    if (self.groupModel) {
        CGFloat itemHeight = (self.lq_height - self.priceLayerHeight) / 8;
        for (NSInteger i = 1; i < 8; i ++) {
            CGFloat  num = itemHeight * i / self.kl_scaleY;
            CATextLayer *textLayer = [self getTextLayer];
            textLayer.frame = CGRectMake(3, self.lq_height - i * itemHeight - self.priceLayerHeight - 5, 40, 10);
            textLayer.string = [NSString stringWithFormat:@"%0.2f",num];
            textLayer.alignmentMode = kCAAlignmentLeft;
            [self.textLayer addSublayer:textLayer];
        }
    }
    
}

// 横向线
- (CAShapeLayer *)getHorAxisLayer {
    CAShapeLayer *centerAxisLayer = [CAShapeLayer layer];
    centerAxisLayer.strokeColor = GaryBackGroundColor.CGColor;
    centerAxisLayer.fillColor = [UIColor clearColor].CGColor;
    centerAxisLayer.contentsScale = [UIScreen mainScreen].scale;
    centerAxisLayer.lineWidth = 1.0;
    //虚线的间隔
    centerAxisLayer.lineDashPattern = @[@2, @2];
    return centerAxisLayer;
}

// 纵坐标
- (CAShapeLayer *)getVerAxisLayer {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = GaryBackGroundColor.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.lineWidth = 1.0;
    
    return layer;
}


// 文字
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

//  画深度
- (void)drawLineLayer {
    
    
    if (self.buyPositionArray.count > 0 ) {
        UIBezierPath *buyPath = [UIBezierPath drawLine:self.buyPositionArray];
        self.buyLayer.path = buyPath.CGPath;
        
        
        buyPath.lineWidth = 0;
        LQLineModel *firstBuyModel = self.buyPositionArray[0];
        [buyPath addLineToPoint:CGPointMake(0, self.lq_height - self.priceLayerHeight)];
        [buyPath addLineToPoint:CGPointMake(firstBuyModel.xPosition, self.lq_height - self.priceLayerHeight)];
        [buyPath closePath];
        
        [SEColorAlpha(89, 199, 110, 0.3) setFill];
        [buyPath fill];
    }
    
   
    if (self.sellPositionArray.count > 0) {
        UIBezierPath *sellPath = [UIBezierPath drawLine:self.sellPositionArray];
        self.sellLayer.path = sellPath.CGPath;
        
        sellPath.lineWidth = 0;
        LQLineModel *firstSellModel = self.sellPositionArray[0];
        [sellPath addLineToPoint:CGPointMake(self.lq_width, self.lq_height - self.priceLayerHeight)];
        [sellPath addLineToPoint:CGPointMake(firstSellModel.xPosition, self.lq_height - self.priceLayerHeight)];
        [sellPath closePath];
        
        [SEColorAlpha(242, 68, 89, 0.3) setFill];
        [sellPath fill];
    }
    
    
   
    
}


- (void)stockFill {
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self draw];
}


- (void)draw {
    
    if (!self.groupModel) {
        return;
    }
    [self initLayer];
    [self initMaxAndMinValue];
    [self initLinesModelPosition];
    [self drawLineLayer];
    [self drawNumTextLayer];
    [self setUIWithData];
}
@end
