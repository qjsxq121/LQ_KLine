//
//  SEMarketDetailVController.m
//  Exchange
//
//  Created by lq on 2018/6/28.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import "SEMarketDetailVController.h"
//#import "SEMarketDetailSelectItemView.h"

#import "LQCandleModel.h"
#import "LQCandleView.h"
#import "LQGroupCandleModel.h"
#import "TradeVolumeView.h"
#import "LQCandlePositionModel.h"

#import "SEMarketFullScreenViewController.h"
#import "SEKLineHPLCItemView.h"
//#import "SEEntrustDealTopView.h"
//#import "SEBottomItemView.h"
//#import "SEKLineNewDealView.h"
#import "LQDepthView.h"
#import "DepthGroupModel.h"
#import "SEEntrustModel.h"
//#import "SENewDealModel.h"
static NSInteger const kMaxDisplayCount = 100;
static NSInteger const kMinDisplsayCount = 10;
@interface SEMarketDetailVController ()<LQCandleProtocol>



/** 时间 */
@property (nonatomic, copy) NSString *timeStr;


/** titleTime */
@property (nonatomic, copy) NSString *timeTitle;


/** 中间选择 */
@property (nonatomic, strong) UIView *selectView;

/** 高开 低收的view */
@property (nonatomic, strong) SEKLineHPLCItemView *holcView;

/** 深度图 */
@property (nonatomic, strong) LQDepthView *depthView;
#pragma mark -- k线相关

/** k线模型的集合 */
@property (nonatomic, strong) LQGroupCandleModel *groupCandleModel;

/** 显示k线的view */
@property (nonatomic, strong) UIView *gatherKLineView;

/** 横线 */
@property (nonatomic, strong) UIView *horLineView;

/** 垂线 */
@property (nonatomic, strong) UIView *verLineView;

/** k线的scrollView */
@property (nonatomic, strong) UIScrollView *kLineScrollView;

/** 蜡烛图 */
@property (nonatomic, strong) LQCandleView *candleView;


/** 换手量 */
@property (nonatomic, strong) TradeVolumeView *volumeView;


/** 转子 */
@property (nonatomic, strong) UIActivityIndicatorView * IndicatorView;

#pragma mark -- 一长按些指标 时间 价格的显示
/** 收盘价 */
@property (nonatomic, strong) UILabel *closeLabel;

/** 时间 */
@property (nonatomic, strong) UILabel *timeLabel;

/** 副图长按显示的指标 */
@property (nonatomic, strong) UILabel *subCandleIndexLabel;

/** ma7 */
@property (nonatomic, strong) UILabel *MA7IndexLabel;

/** MA25 */
@property (nonatomic, strong) UILabel *MA25IndexLabel;

/** <#name#> */
@property (nonatomic, assign) CGFloat currentZoom;

/** <#name#> */
@property (nonatomic, assign) NSInteger zoomRigthIndex;

/** 展示的个数 */
@property (nonatomic, assign) NSInteger displayCount;



#pragma mark -- k线下面的view




/** 是否是第一次加载数据 */
@property (nonatomic, assign) BOOL isFirstLoad;
@end

CGFloat const kBottomViewHeight = 49;
CGFloat const kGatherViewHeight = 306;
@implementation SEMarketDetailVController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    
//    // 默认是15分
//    self.timeStr = @"15m";
//    self.timeTitle = @"15分";
//    // 添加子控件
    [self addSubViews];
//    // 添加手势
    [self addGestureToCandleView];
    
    
    [self loadData];
}


#pragma mark -- 解析数据
- (void)loadData {
    NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LineData"ofType:@"plist"]];

    self.groupCandleModel = [LQGroupCandleModel initWithArr:dataDict[@"list"]];
    NSLog(@"%ld",self.groupCandleModel.list.count);
    
    self.candleView.dataArray = self.groupCandleModel.list;
    self.volumeView.dataArray = self.groupCandleModel.list;
    [self.candleView stockFill];

//    NSLog(@"%@", dic);
    
}


#pragma mark -- 添加子控件
- (void)addSubViews {
    
    [self.view addSubview:self.selectView];
    // 添加显示高开低收的view
    [self.view addSubview:self.holcView];
    [self.view addSubview:self.depthView];
    // 添加和k 线有关的view
    [self addKlineViews];
    
}

// 添加和k 线有关的view
- (void)addKlineViews {
    [self.view addSubview:self.gatherKLineView];

    [self kLineScrollView];
    [self candleView];
    [self volumeView];
    
    // 添加十字线
    [self verLineView];
    [self horLineView];
    
    // 收盘价
    [self closeLabel];
    // 时间
    [self timeLabel];
    
    // 主图指标
    [self MA7IndexLabel];
    [self MA25IndexLabel];
    
    
    // 副图指标
    [self subCandleIndexLabel];
    
    // 转子
//    [self IndicatorView];
}



// selectView
- (UIView *)selectView {
    if (!_selectView) {
        _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.lq_width, 40)];
        _selectView.backgroundColor = GaryBackGroundColor;
        
        
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"全屏" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickFullScreen) forControlEvents:UIControlEventTouchUpInside];
        [_selectView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(40);
            make.right.mas_equalTo(-10);
        }];
    }
    return _selectView;
}


// 显示高 开 低 收 的view
- (SEKLineHPLCItemView *)holcView {
    if (!_holcView) {
        _holcView = [[SEKLineHPLCItemView alloc] initWithFrame:CGRectMake(0, 100, self.view.lq_width, 40)];
        _holcView.backgroundColor = GaryBackGroundColor;
        _holcView.hidden = YES;
    }
    return _holcView;
}

- (LQDepthView *)depthView {
    if (!_depthView) {
        _depthView = [[LQDepthView alloc] initWithFrame:CGRectMake(0,  _selectView.lq_bottom, self.view.lq_width, kGatherViewHeight)];
        _depthView.backgroundColor = [UIColor whiteColor];
        _depthView.hidden = YES;
    }
    return _depthView;
}

#pragma mark -- k 线相关的view

- (UIActivityIndicatorView *)IndicatorView {
    if (!_IndicatorView) {
        _IndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_gatherKLineView addSubview:_IndicatorView];
        
        [_IndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
            make.centerX.centerY.mas_equalTo(self.gatherKLineView);
        }];
    }
    return _IndicatorView;
}



- (UIView *)gatherKLineView {
    if (!_gatherKLineView) {
        _gatherKLineView = [[UIView alloc] initWithFrame:CGRectMake(0,  _selectView.lq_bottom, self.view.lq_width, kGatherViewHeight)];
    }
    return _gatherKLineView;
}

// k 线底部的scrollView
- (UIScrollView *)kLineScrollView {
    if (!_kLineScrollView) {
        _kLineScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _gatherKLineView.lq_width, _gatherKLineView.lq_height)];
        _kLineScrollView.showsHorizontalScrollIndicator = NO;
        [_gatherKLineView addSubview:_kLineScrollView];
        
        [_kLineScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_equalTo(0);
        }];
    }
    return _kLineScrollView;
}


// 蜡烛图
- (LQCandleView *)candleView {
    if (!_candleView) {
        _candleView = [[LQCandleView alloc] initWithHeight:220];
        _currentZoom = -0.01f;
        _candleView.delegate = self;
        [_kLineScrollView addSubview:_candleView];
        [_candleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(220);
        }];
        
        _candleView.candleSpace = 2;
        _candleView.displayCount = 40;
        _candleView.kl_lineWidth = 1.5;
        _candleView.kl_topMargin = 15;
        _candleView.kl_bottomMargin = 15;
        _candleView.timeLayerHeight = 13;
        _candleView.timeFormat = @"HH:mm";
        _displayCount = _candleView.displayCount;
    }
    
    return _candleView;
}



// 换手量
- (TradeVolumeView *)volumeView {
    if (!_volumeView) {
        _volumeView = [[TradeVolumeView alloc] init];
       // _volumeView.backgroundColor = RandomColor;
        [_kLineScrollView addSubview:_volumeView];
        
        [_volumeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.candleView.mas_bottom);
            make.height.mas_equalTo(86);
        }];
        _volumeView.kl_topMargin = 5;
    }
    return _volumeView;
}


#pragma mark -- 十字线

// 垂直线
- (UIView *)verLineView {
    if (!_verLineView) {
        _verLineView = [[UIView alloc] init];
        _verLineView.backgroundColor = SEGrayColor(230, 1.0);
        _verLineView.hidden = YES;
        [self.kLineScrollView addSubview:_verLineView];
        
        [_verLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(kGatherViewHeight);
            make.width.mas_equalTo(1);
        }];
    }
    
    return _verLineView;
}

// 横线
- (UIView *)horLineView {
    if (!_horLineView) {
        _horLineView = [[UIView alloc] init];
        _horLineView.backgroundColor = SEGrayColor(230, 1.0);
        _horLineView.hidden = YES;
        [self.kLineScrollView addSubview:_horLineView];
        
        [_horLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    
    return _horLineView;
}

#pragma mark -- 一长按些指标 时间 价格的显示
// 长安街显示的收盘价
- (UILabel *)closeLabel {
    if (!_closeLabel) {
        _closeLabel = [UILabel creatLabelWithTextColor:[UIColor whiteColor] font:TextFontWithSize(9)];
        _closeLabel.backgroundColor = GaryTextColor;
        _closeLabel.textAlignment = NSTextAlignmentCenter;
        _closeLabel.hidden = YES;
        [self.view addSubview:_closeLabel];
        
        [_closeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(11);
            make.centerY.mas_equalTo(self.horLineView);
            make.width.mas_equalTo(56);
        }];
    }
    return _closeLabel;
}

// 长按显示的时间
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel creatLabelWithTextColor:[UIColor whiteColor] font:TextFontWithSize(8)];
        _timeLabel.backgroundColor = GaryTextColor;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.hidden = YES;
        [self.view addSubview:_timeLabel];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.volumeView.mas_bottom);
            make.height.mas_equalTo(11);
            make.width.mas_equalTo(78);
            make.centerX.mas_equalTo(self.verLineView);
        }];
    }
    return _timeLabel;
}


// 副图指标
- (UILabel *)subCandleIndexLabel {
    if (!_subCandleIndexLabel) {
        _subCandleIndexLabel = [UILabel creatLabelWithTextColor:BlackTextColor font:PriceFontWithSize(9)];
        _subCandleIndexLabel.backgroundColor = [UIColor whiteColor];
        _subCandleIndexLabel.hidden = YES;
        [self.view addSubview:_subCandleIndexLabel];
        
        [_subCandleIndexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.volumeView.mas_top).mas_offset(2);
            make.height.mas_equalTo(11);
            make.left.mas_equalTo(3);
        }];
    }
    return _subCandleIndexLabel;
}


// MA7
- (UILabel *)MA7IndexLabel {
    if (!_MA7IndexLabel) {
        _MA7IndexLabel = [UILabel creatLabelWithTextColor:UIColorHex(#F0C356) font:TextFontWithSize(9)];
        _MA7IndexLabel.hidden = YES;
        _MA7IndexLabel.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_MA7IndexLabel];
        
        [_MA7IndexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(4);
            make.top.mas_equalTo(self.selectView.mas_bottom).mas_offset(4);
            make.height.mas_equalTo(11);
            
        }];
    }
    return _MA7IndexLabel;
}

// MA25
- (UILabel *)MA25IndexLabel {
    if (!_MA25IndexLabel) {
        _MA25IndexLabel = [UILabel creatLabelWithTextColor:SelectedColor font:TextFontWithSize(9)];
        _MA25IndexLabel.backgroundColor = [UIColor whiteColor];
        _MA25IndexLabel.hidden = YES;
        [self.view addSubview:_MA25IndexLabel];
        
        [_MA25IndexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.mas_equalTo(self.MA7IndexLabel);
            make.left.mas_equalTo(self.MA7IndexLabel.mas_right).mas_offset(3);
        }];
    }
    return _MA25IndexLabel;
}

#pragma mark -- 添加手势
- (void)addGestureToCandleView {
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleCandleView:)];
    [self.kLineScrollView addGestureRecognizer:pinchGes];
    
    
 UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesture:)];
    [self.kLineScrollView addGestureRecognizer:longPressGesture];
}



#pragma mark -- 手势的方法
// 缩放手势
- (void)scaleCandleView:(UIPinchGestureRecognizer *)pinchGes {
    
    if (pinchGes.state == UIGestureRecognizerStateEnded) {
        _currentZoom = pinchGes.scale;
        self.kLineScrollView.scrollEnabled = YES;
    } else if (pinchGes.state == UIGestureRecognizerStateBegan && _currentZoom != 0.0f)
    {
        self.kLineScrollView.scrollEnabled = NO;
        pinchGes.scale = _currentZoom;
        
        LQCandlePositionModel *model = self.candleView.currentPositionArray.lastObject;
        
        _zoomRigthIndex = model.localIndex + 1;
        
    } else if (pinchGes.state == UIGestureRecognizerStateChanged) {
        CGFloat tmpZoom = 0.f;
        if (isnan(_currentZoom)) {
            return;
        }
        
        tmpZoom = (pinchGes.scale) / _currentZoom;
        _currentZoom = pinchGes.scale;
        
        // 四舍五入
        NSInteger showNum = round(_displayCount / tmpZoom);
        if (showNum == _displayCount) {
            return;
        }
        
        if (showNum >= kMaxDisplayCount || showNum <= kMinDisplsayCount) {
            return;
        }
        _displayCount = showNum;
        
        _displayCount = _displayCount < kMinDisplsayCount ? kMinDisplsayCount : _displayCount;
        _displayCount = _displayCount > kMaxDisplayCount ? kMaxDisplayCount : _displayCount;
        
        _candleView.displayCount = _displayCount;
        
        [_candleView calcuteCandleWidth];
        
        [_candleView updateWidthWithNoOffset];
        [_candleView drawLine];
        
        CGFloat offsetX = fabs(_zoomRigthIndex * (self.candleView.candleSpace + self.candleView.candleWidth) - self.kLineScrollView.lq_width + self.candleView.kl_leftMargin);
        if (offsetX <= self.kLineScrollView.lq_width) {
            offsetX = 0;
        }
        if (offsetX > self.kLineScrollView.contentSize.width - self.kLineScrollView.lq_width) {
            offsetX = self.kLineScrollView.contentSize.width - self.kLineScrollView.lq_width;
        }
        self.kLineScrollView.contentOffset = CGPointMake(offsetX, 0);
    }
    
}

// 长按手势
- (void)longGesture:(UILongPressGestureRecognizer*)longPress
{
    static CGFloat oldPositionX = 0;
    if(UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state)
    {
        CGPoint location = [longPress locationInView:self.candleView];
        if(ABS(oldPositionX - location.x) < (self.candleView.candleWidth + self.candleView.candleSpace)/2)
        {
            return;
        }
        
        self.kLineScrollView.scrollEnabled = NO;
        oldPositionX = location.x;
        
        CGPoint point = [self.candleView getLongPressModelPostionWithXPostion:location.x];
        CGFloat xPositoin = point.x + (self.candleView.candleWidth)/2.f - self.candleView.candleSpace/2.f ;
        CGFloat yPositoin = point.y +_candleView.kl_topMargin;
        [self.verLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(xPositoin));
        }];
        
        [self.horLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(yPositoin);
        }];
        
        [self longPressStartShowView];
    }
    
    if(longPress.state == UIGestureRecognizerStateEnded)
    {
        [self longGesEndHiddenView];
        oldPositionX = 0;
        self.kLineScrollView.scrollEnabled = YES;
    }
}

// 长按显示view
- (void)longPressStartShowView {
    self.verLineView.hidden = NO;
    self.horLineView.hidden = NO;
    self.closeLabel.hidden = NO;
    self.timeLabel.hidden = NO;
    self.subCandleIndexLabel.hidden = NO;
    self.holcView.hidden = NO;

    if (self.candleView.indexType == IndexViewTypeEMA || self.candleView.indexType == IndexViewTypeSMA) {
        self.MA7IndexLabel.hidden = NO;
        self.MA25IndexLabel.hidden = NO;
    }
    
    
}
// 长按结束隐藏相关view
- (void)longGesEndHiddenView {
    if(self.verLineView)
    {
        self.verLineView.hidden = YES;
    }
    
    if(self.horLineView)
    {
        self.horLineView.hidden = YES;
    }
    if (self.holcView) {
        self.holcView.hidden = YES;
    }
    self.closeLabel.hidden = YES;
    self.timeLabel.hidden = YES;
    self.subCandleIndexLabel.hidden = YES;
    self.MA7IndexLabel.hidden = YES;
    self.MA25IndexLabel.hidden = YES;
}

#pragma mark -- LQCandleProtocol
- (void)displayScreenLeftPosition:(CGFloat)leftPosition startIndex:(NSInteger)index count:(NSInteger)count {
    _volumeView.candleSpace = _candleView.candleSpace;
    _volumeView.candleWidth = _candleView.candleWidth;
    _volumeView.leftPostion = leftPosition;
    _volumeView.startIndex = index;
    _volumeView.displayCount = count;
    
    [_volumeView stockFill];
}


// 长按获取的数据
- (void)longPressCandleViewWithIndex:(NSInteger)klineModelIndex kLineModel:(LQCandleModel *)kLineModel {
    self.holcView.model= kLineModel;
    
    
    // 收盘价
    self.closeLabel.text = [NSString stringWithFormat:@"%0.7f",kLineModel.Close];
    
    // 时间
    self.timeLabel.text = [ToolClass stringWithTimestamp:[NSString stringWithFormat:@"%f",[kLineModel.date floatValue]] dateFormat:@"yyyy-MM-dd HH:mm"];
    
    
    // 显示的是成交量
    self.subCandleIndexLabel.text = [NSString stringWithFormat:@"VOL %.2f",kLineModel.tradeNum];

    // MA赋值
    self.MA7IndexLabel.text = [NSString stringWithFormat:@"[MA7]:%0.8f,",[kLineModel.MA7 doubleValue]];
    self.MA25IndexLabel.text = [NSString stringWithFormat:@"[MA25]:%0.8f",[kLineModel.MA25 doubleValue]];
    
  
}



//#pragma mark --  订阅
//- (void)tokeMarketData {
//
//    NSData *marketData = [[NSString stringWithFormat:@"%@?obj=%@&sub=1&Qid=DetailMarket",Socket_Dyna_Market,_comb] dataUsingEncoding:NSUTF8StringEncoding];
//     [[SESocketManger instance] sendData:marketData];
//
//    NSData *EntrustData = [[NSString stringWithFormat:@"/api/depth?obj=%@&sub=1&Qid=DetailEntrust",_comb] dataUsingEncoding:NSUTF8StringEncoding];
//   [[SESocketManger instance] sendData:EntrustData];
//
//    // 最新成交
//    NSData *newDealData = [[NSString stringWithFormat:@"/api/ticker?obj=%@&sub=1&Qid=DetailNewDeal",_comb] dataUsingEncoding:NSUTF8StringEncoding];
//    [[SESocketManger instance] sendData:newDealData];
//
//
//
//}



//// 订阅k线数据
//- (void)sendKLineData {
//    [self.IndicatorView startAnimating];
//
//    [self.groupCandleModel.list removeAllObjects];
//    self.groupCandleModel = nil;
//
//    self.isFirstLoad = YES;
//    NSData *klineData = [[NSString stringWithFormat:@"/api/kline?obj=%@&period=%@&sub=1&Qid=klineData",_comb,self.timeStr] dataUsingEncoding:NSUTF8StringEncoding];
//    [[SESocketManger instance] sendData:klineData];
//
//}
//




//- (void)SRWebSocketDidReceiveMsg:(NSNotification *)note {
//    //收到服务端发送过来的消息
//    NSString * message = note.object;
//
//    NSDictionary *result = [ToolClass dictionaryWithJsonString:message];
//
//
//    if ([result[@"Err"] integerValue] == 0) {
//
//        // k 线数据
//        if ([result[@"Qid"] isEqualToString:@"klineData"]) {
//
////            dispatch_async(dispatch_get_global_queue(0, 0), ^{
////
////
////            });
//
//             [self disposeKlineDataWithResult:result];
//        }
//
//
//
//        // 委托订单
//        if ([result[@"Qid"] isEqualToString:@"DetailEntrust"]) {
//
//            NSLog(@"委托订单");
//            [self setEntrustDataWithResult:result];
//        }
//
//        if ([result[@"Qid"] isEqualToString:@"DetailNewDeal"]) { // 最新成交
//            NSLog(@"最新成交");
//            [self setNewDealWithResutl:result];
//        }
//        if ([result[@"Qid"] isEqualToString:@"DetailMarket"]) { // 行情数据
//            NSArray <SESuperMarketModel *>*marketArray = [SESuperMarketModel mj_objectArrayWithKeyValuesArray:result[@"Data"][@"RepDataDyna"]];
//          //  self.pvhlView.marketModel = marketArray[0];
//            [self.pvhlView setUIWithModel:marketArray[0] base:self.base];
//            NSLog(@"行情");
//        }
//
//
//
//    }
//
//}

#pragma mark -- 处理k 线数据
- (void)disposeKlineDataWithResult:(NSDictionary *)result {
    
    NSArray *dataArray = result[@"Data"][@"RepDataKLine"];
    if (dataArray.count == 0) {
        return;
    }
    
    NSArray *modelArray = dataArray[0][@"Data"];
    if (modelArray.count == 0) {
        return;
    }
    if (![self.timeStr isEqualToString:dataArray[0][@"Period"]]) {
        
        return;
    }
    
    
    NSLog(@"%@",dataArray[0][@"Period"]);
    NSLog(@"%ld",self.groupCandleModel.list.count);
    // 推送的变化的数据
    if (self.groupCandleModel.list > 0) {
        LQCandleModel *lastModel = self.groupCandleModel.list.lastObject;
        
        LQCandleModel *newModel = [LQCandleModel new];
        [newModel initModelWith:modelArray[0]];
        
        // 替换
    if ([newModel.date integerValue] == [lastModel.date integerValue] ) { // 替换
        newModel.previousKlineModel = lastModel.previousKlineModel;
        newModel.superModel = self.groupCandleModel;
        [self.groupCandleModel.list removeLastObject];
        [self.groupCandleModel.list addObject:newModel];
        [newModel initData];
        
       
    } else {
        newModel.previousKlineModel = lastModel;
        newModel.superModel = self.groupCandleModel;
        [self.groupCandleModel.list addObject:newModel];

        [newModel initData];

    }

    } else {
        self.groupCandleModel = [LQGroupCandleModel initWithArr:modelArray];
    }
    
    
  
        self.candleView.dataArray = self.groupCandleModel.list;
        self.volumeView.dataArray = self.groupCandleModel.list;
        
        if ([self.timeStr isEqualToString:@"day"] || [self.timeStr isEqualToString:@"week"] ||[self.timeStr isEqualToString:@"month"]) {  // 日 周  月 线
            self.candleView.timeFormat = @"yyyy-MM-dd";
        } else {  // 分  时  线
            self.candleView.timeFormat = @"HH:mm";
        }
    
    if (_isFirstLoad) {
        _isFirstLoad = NO;
        [self.candleView stockFill];

    } else {
        [self.candleView reload];
        
        NSLog(@"刷新数据");
    }
    
        [self.IndicatorView stopAnimating];
   
}


#pragma mark -- SEMarketDetailSelectItemViewDelegate
// 全屏手势
- (void)clickFullScreen {
    SEMarketFullScreenViewController *fullScreenVC = [SEMarketFullScreenViewController new];
    fullScreenVC.timeStr = self.timeStr;
    fullScreenVC.comb = self.comb;
    fullScreenVC.timeTitle = self.timeTitle;
    fullScreenVC.base = self.base;
    [self presentViewController:fullScreenVC animated:YES completion:nil];
}

- (void)selectKLineViewOrDepathViewWithTag:(NSInteger)tag {
    if (tag == 10) { // 显示k线
        self.gatherKLineView.hidden = NO;
        self.depthView.hidden = YES;
    }
    
    if (tag == 11) {  // 显示深度
        self.gatherKLineView.hidden = YES;
        self.depthView.hidden = NO;
    }
}

// k线时间切换
- (void)selectKlineTimeWithTimeStr:(NSString *)timeStr timeTitle:(NSString *)timeTitle {
    
    if ([self.timeStr isEqualToString:timeStr]) {
        return;
    }
    
    self.timeTitle = timeTitle;
    // 时间切换时先取消 原来的推送
    self.timeStr = timeStr;
}


@end
