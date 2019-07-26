//
//  SEMarketFullScreenViewController.m
//  Exchange
//
//  Created by lq on 2018/7/3.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import "SEMarketFullScreenViewController.h"
#import "SEFullScreenKTimeSelectView.h"
#import "SEFullScreenFNTView.h"
#import "SEFullIndexView.h"

#import "LQCandleModel.h"
#import "LQCandleView.h"
#import "LQGroupCandleModel.h"
#import "LQCandlePositionModel.h"

#import "LQMacdView.h"
#import "LQKDJLineView.h"
#import "LQRSILineView.h"
#import "TradeVolumeView.h"
#import "SEKLineHPLCItemView.h"

static NSInteger const kMaxDisplayCount = 150;
static NSInteger const kMinDisplsayCount = 25;
@interface SEMarketFullScreenViewController ()<SEFullScreenFNTViewDelegate,SEFullIndexViewDelegate,LQCandleProtocol,SEFullScreenKTimeSelectViewDelegate>



/** 名字 浮动 时间 view */
@property (nonatomic, strong) SEFullScreenFNTView *fntView;

/** 时间选择 */
@property (nonatomic, strong) SEFullScreenKTimeSelectView *timeSelectView;

/** 指标view */
@property (nonatomic, strong) SEFullIndexView *indexView;

/** K线集合的scrollView */
@property (nonatomic, strong) UIScrollView *groupScrollView;

/**  k线幅图的view高度 */
@property (nonatomic, assign) CGFloat kAssistantViewHeight;

/** k线主图view高度 */
@property (nonatomic, assign) CGFloat kMainViewHeight;

/** k线模型的集合 */
@property (nonatomic, strong) LQGroupCandleModel *groupCandleModel;

/** 蜡烛图 */
@property (nonatomic, strong) LQCandleView *candleView;

/** 转子 */
@property (nonatomic, strong) UIActivityIndicatorView * IndicatorView;


/** 高开 低收的view */
@property (nonatomic, strong) SEKLineHPLCItemView *holcView;
#pragma mark -- 副图
/** MACD */
@property (nonatomic, strong) LQMacdView *macdView;

/** kdj */
@property (nonatomic, strong) LQKDJLineView *kdjView;

/** RSI */
@property (nonatomic, strong) LQRSILineView *rsiView;

/** 成交量 */
@property (nonatomic, strong) TradeVolumeView *volumeView;

/** 横线 */
@property (nonatomic, strong) UIView *horLineView;

/** 垂线 */
@property (nonatomic, strong) UIView *verLineView;

/** 指标类型 */
@property (nonatomic, assign) IndexViewType indexType;


/** <#name#> */
@property (nonatomic, assign) CGFloat currentZoom;

/** <#name#> */
@property (nonatomic, assign) NSInteger zoomRigthIndex;

/** 展示的个数 */
@property (nonatomic, assign) NSInteger displayCount;


#pragma mark -- 一长按些指标 时间 价格的显示
/** 收盘价 */
@property (nonatomic, strong) UILabel *closeLabel;

/** 时间 */
@property (nonatomic, strong) UILabel *timeLabel;

/** 副图长按显示的指标 */
@property (nonatomic, strong) UILabel *subCandleIndexLabel;


/** BOLL指标 */
@property (nonatomic, strong) UILabel *BOLLLIndexabel;

/** ma7 */
@property (nonatomic, strong) UILabel *MA7IndexLabel;

/** MA25 */
@property (nonatomic, strong) UILabel *MA25IndexLabel;
@end

//名字 浮动 时间 view 高度
CGFloat const kFntViewHeigth = 40;

// 时间选择的高度
CGFloat const kTimeSelectViewHeight = 49;
CGFloat const kIndexViewWidth = 40;
CGFloat const kMargin = 10;

CGFloat const kVerSpace = 5;


@implementation SEMarketFullScreenViewController





- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    self.view.backgroundColor = GaryBackGroundColor;
    
    self.kAssistantViewHeight = 55;
    self.kMainViewHeight =  SCREEN_WIDTH - kFntViewHeigth - kTimeSelectViewHeight - kVerSpace - _kAssistantViewHeight;
    [self addsubViews];
    
    _indexType = IndexViewTypeVOL;
    
    // 添加手势
    [self addGestureToCandleView];
    // 请求数据
    
    [self loadData];
}

#pragma mark -- 解析数据
- (void)loadData {
    NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LineData"ofType:@"plist"]];
    
    self.groupCandleModel = [LQGroupCandleModel initWithArr:dataDict[@"list"]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.candleView.dataArray = self.groupCandleModel.list;
        self.volumeView.dataArray = self.groupCandleModel.list;
        self.macdView.dataArray = self.groupCandleModel.list;
        self.kdjView.dataArray = self.groupCandleModel.list;
        self.rsiView.dataArray = self.groupCandleModel.list;
        if ([self.timeStr isEqualToString:@"day"] || [self.timeStr isEqualToString:@"week"] ||[self.timeStr isEqualToString:@"month"]) {  // 日 周  月 线
            self.candleView.timeFormat = @"yyyy-MM-dd";
        } else {  // 分  时  线
            self.candleView.timeFormat = @"HH:mm";
        }
        [self.candleView stockFill];
        
        [self.IndicatorView stopAnimating];
    });
//    self.candleView.dataArray = self.groupCandleModel.list;
//    self.volumeView.dataArray = self.groupCandleModel.list;
//    [self.candleView stockFill];
    
    //    NSLog(@"%@", dic);
    
}


- (void)addsubViews {
    // 浮动view
    [self fntView];
    
    // 高 开 低收
    [self holcView];
    // 时间选择view
    [self timeSelectView];
    
    // 指标view
    [self indexView];
    
    // scrollView
    [self groupScrollView];
    
    // 蜡烛图
    [self candleView];
    
    [self addCandelSubView];
    
    // 添加长按显示的view
    [self addLongPresshowView];
    
    // 转子
//    [self IndicatorView];
}

// 副图
- (void)addCandelSubView {
    
    [self volumeView];
    // MACD
    [self macdView];
    
    // KDJ
    [self kdjView];
    
    [self rsiView];
}

// 长按显示的view
- (void)addLongPresshowView {
    
    // 十字线
    [self verLineView];
    [self horLineView];
    
    
    // 收盘价
    [self closeLabel];
    // 时间
    [self timeLabel];
    
    // 主图指标
    [self BOLLLIndexabel];
    [self MA7IndexLabel];
    [self MA25IndexLabel];
    
    
    // 副图指标
    [self subCandleIndexLabel];
    
}


- (SEFullScreenFNTView *)fntView {
    if (!_fntView) {
        _fntView = [[SEFullScreenFNTView alloc] init];
        _fntView.delegate = self;
        [self.view addSubview:_fntView];
        
        [_fntView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(kFntViewHeigth);
            
        }];
    }
    return _fntView;
}

// 显示高 开 低 收 的view
- (SEKLineHPLCItemView *)holcView {
    if (!_holcView) {
        _holcView = [[SEKLineHPLCItemView alloc] init];
        _holcView.backgroundColor = GaryBackGroundColor;
        [self.view addSubview:_holcView];
        _holcView.hidden = YES;
        
        [_holcView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(kFntViewHeigth);
            
        }];
    }
    return _holcView;
}

// k线时间选择
- (SEFullScreenKTimeSelectView *)timeSelectView {
    if (!_timeSelectView) {
        _timeSelectView = [[SEFullScreenKTimeSelectView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH - kTimeSelectViewHeight, SCREEN_HEIGHT, kTimeSelectViewHeight)withTime:self.timeTitle];
        _timeSelectView.backgroundColor = WhiteBackGroundColor;
        _timeSelectView.delegate = self;
        [self.view addSubview:_timeSelectView];
        
//        [_timeSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.bottom.mas_equalTo(0);
//            make.height.mas_equalTo(kTimeSelectViewHeight);
//        }];
    }
    return _timeSelectView;
}

// 指标view
- (SEFullIndexView *)indexView {
    if (!_indexView) {
        _indexView = [[SEFullIndexView alloc] init];
        _indexView.backgroundColor = WhiteBackGroundColor;
        _indexView.delegate = self;
        [self.view addSubview:_indexView];
        
        [_indexView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_fntView.mas_bottom).mas_offset(3);
            make.bottom.mas_equalTo(_timeSelectView.mas_top).mas_offset(-3);
            make.width.mas_equalTo(kIndexViewWidth);
            make.right.mas_equalTo(-kMargin);
        }];
    }
    return _indexView;
}
// 集合 scrollView
- (UIScrollView *)groupScrollView {
    if (!_groupScrollView) {
        _groupScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - kIndexViewWidth - kMargin - kMargin, 100)];
        _groupScrollView.backgroundColor = WhiteBackGroundColor;
        _groupScrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_groupScrollView];
        
        [_groupScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(_indexView.mas_left).mas_offset(-kMargin);
            make.top.mas_equalTo(_fntView.mas_bottom);
            make.bottom.mas_equalTo(_timeSelectView.mas_top).mas_offset(-kVerSpace);
        }];
        
    }
    return _groupScrollView;
}

- (UIActivityIndicatorView *)IndicatorView {
    if (!_IndicatorView) {
        _IndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        // _IndicatorView.backgroundColor = RandomColor;
        // _IndicatorView.color = [UIColor lightGrayColor];
        [self.view addSubview:_IndicatorView];
        
        [_IndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
            make.centerX.centerY.mas_equalTo(self.view);
        }];
    }
    return _IndicatorView;
}
// 蜡烛图
- (LQCandleView *)candleView {
    if (!_candleView) {
        _candleView = [[LQCandleView alloc] initWithHeight:self.kMainViewHeight];
        _currentZoom = -0.01f;
        _candleView.delegate = self;
        [_groupScrollView addSubview:_candleView];
        
        [_candleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(self.kMainViewHeight);
        }];
        
        _candleView.candleSpace = 2;
        _candleView.displayCount = 60;
        _candleView.kl_lineWidth = 1.5;
        _candleView.kl_topMargin = 15;
        _candleView.kl_bottomMargin = 15;
        _candleView.timeLayerHeight = 13;
        
        _displayCount = _candleView.displayCount;
    }
    
    return _candleView;
}

- (TradeVolumeView *)volumeView {
    if (!_volumeView) {
        _volumeView = [[TradeVolumeView alloc] init];
        [self.groupScrollView addSubview:_volumeView];
        
        [_volumeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(_candleView.mas_bottom);
            make.height.mas_equalTo(_kAssistantViewHeight);
        }];
        _volumeView.kl_topMargin = 5;
        _volumeView.kl_bottomMargin = 0;
    }
    
    return _volumeView;
}
// macdView
- (LQMacdView *)macdView {
    if (!_macdView) {
        _macdView = [[LQMacdView alloc] init];
        [self.groupScrollView addSubview:_macdView];
        
        [_macdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(_candleView.mas_bottom);
            make.height.mas_equalTo(_kAssistantViewHeight);
        }];
    }
    return _macdView;
}

//KDJ
- (LQKDJLineView *)kdjView {
    if (!_kdjView) {
        _kdjView = [[LQKDJLineView alloc] init];
        [self.groupScrollView addSubview:_kdjView];
       // _kdjView.backgroundColor = RandomColor;
        [_kdjView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(_candleView.mas_bottom);
            make.height.mas_equalTo(_kAssistantViewHeight);
        }];
    }
    
    return _kdjView;
}

//RSI
- (LQRSILineView *)rsiView {
    if (!_rsiView) {
        _rsiView = [[LQRSILineView alloc] init];
        [self.groupScrollView addSubview:_rsiView];
        
        [_rsiView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(_candleView.mas_bottom);
            make.height.mas_equalTo(_kAssistantViewHeight);
        }];
    }
    return _rsiView;
}

#pragma mark -- 十字线

// 垂直线
- (UIView *)verLineView {
    if (!_verLineView) {
        _verLineView = [[UIView alloc] init];
        _verLineView.backgroundColor = SEGrayColor(230, 1.0);
        _verLineView.hidden = YES;
        [self.groupScrollView addSubview:_verLineView];
        
        [_verLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(SCREEN_WIDTH - kFntViewHeigth - kVerSpace - kTimeSelectViewHeight);
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
        [self.groupScrollView addSubview:_horLineView];
        
        [_horLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    
    return _horLineView;
}

#pragma mark -- 一些指标 时间 价格的显示

// 长安显示的收盘价
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
            make.centerY.mas_equalTo(_horLineView);
            make.width.mas_equalTo(50);
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
            make.bottom.mas_equalTo(_timeSelectView.mas_top).mas_offset(-kVerSpace);
            make.height.mas_equalTo(11);
            make.width.mas_equalTo(78);
            make.centerX.mas_equalTo(_verLineView);
        }];
    }
    return _timeLabel;
}


// 副图指标
- (UILabel *)subCandleIndexLabel {
    if (!_subCandleIndexLabel) {
        _subCandleIndexLabel = [UILabel creatLabelWithTextColor:BlackTextColor font:PriceFontWithSize(9)];
        _subCandleIndexLabel.backgroundColor = WhiteBackGroundColor;
        _subCandleIndexLabel.hidden = YES;
        [self.view addSubview:_subCandleIndexLabel];
        
        [_subCandleIndexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_volumeView.mas_top).mas_offset(2);
            make.height.mas_equalTo(11);
            make.left.mas_equalTo(3);
        }];
    }
    return _subCandleIndexLabel;
}


// BOLL指标
- (UILabel *)BOLLLIndexabel {
    if (!_BOLLLIndexabel) {
        _BOLLLIndexabel = [UILabel creatLabelWithTextColor:BlackTextColor font:PriceFontWithSize(9)];
        _BOLLLIndexabel.backgroundColor = WhiteBackGroundColor;
        _BOLLLIndexabel.hidden = YES;
        [self.view addSubview:_BOLLLIndexabel];
        
        [_BOLLLIndexabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(4);
            make.top.mas_equalTo(_fntView.mas_bottom).mas_offset(4);
            make.height.mas_equalTo(11);
        }];
    }
    return _BOLLLIndexabel;
}

// MA7
- (UILabel *)MA7IndexLabel {
    if (!_MA7IndexLabel) {
        _MA7IndexLabel = [UILabel creatLabelWithTextColor:UIColorHex(#F0C356) font:TextFontWithSize(9)];
        _MA7IndexLabel.hidden = YES;
        _MA7IndexLabel.backgroundColor = WhiteBackGroundColor;
        [self.view addSubview:_MA7IndexLabel];
        
        [_MA7IndexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.height.top.mas_equalTo(_BOLLLIndexabel);
        }];
    }
    return _MA7IndexLabel;
}

// MA25
- (UILabel *)MA25IndexLabel {
    if (!_MA25IndexLabel) {
        _MA25IndexLabel = [UILabel creatLabelWithTextColor:SelectedColor font:TextFontWithSize(9)];
        _MA25IndexLabel.backgroundColor = WhiteBackGroundColor;
        _MA25IndexLabel.hidden = YES;
        [self.view addSubview:_MA25IndexLabel];
        
        [_MA25IndexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.mas_equalTo(_BOLLLIndexabel);
            make.left.mas_equalTo(_MA7IndexLabel.mas_right).mas_offset(3);
        }];
    }
    return _MA25IndexLabel;
}








- (void)SRWebSocketDidReceiveMsg:(NSNotification *)note {
    
    //收到服务端发送过来的消息
    NSString * message = note.object;
    
    NSDictionary *result = [ToolClass dictionaryWithJsonString:message];
    if ([result[@"Err"] integerValue] == 0) {
        // k 线数据
        if ([result[@"Qid"] isEqualToString:@"FullScreenKlineData"]) {
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [self disposeKlineDataWithResult:result];

            });
        }
        
        if ([result[@"Qid"] isEqualToString:@"fullScreenMarket"]) { // 行情
            [self disposeMarketDataWithResult:result];
        }
    }
}

#pragma mark -- 行情
- (void)disposeMarketDataWithResult:(NSDictionary *)result {
//    NSArray <SESuperMarketModel *>*dataArray = [SESuperMarketModel mj_objectArrayWithKeyValuesArray:result[@"Data"][@"RepDataDyna"]];
//    //self.marketModel = dataArray[0];
//    //[self.transView setMarketWith:self.marketModel baseCoin:self.baseCoin];
//    [self.fntView setUIWith:dataArray[0] baseCoin:self.base];
    
}
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
            
            
            //        NSLog(@"high%f open%fclose%f",lastModel.high,lastModel.open,lastModel.close);
            //
         //   NSLog(@"CBBBclose%f",newModel.close);
         //   NSLog(@"替换哈哈哈哈哈哈哈");
        } else {
            newModel.previousKlineModel = lastModel;
            newModel.superModel = self.groupCandleModel;
            [self.groupCandleModel.list addObject:newModel];
            
            [newModel initData];
            
        //    NSLog(@"增加增加增加非法燃放方法");
        }
        
    } else {
        self.groupCandleModel = [LQGroupCandleModel initWithArr:modelArray];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.candleView.dataArray = self.groupCandleModel.list;
        self.volumeView.dataArray = self.groupCandleModel.list;
        self.macdView.dataArray = self.groupCandleModel.list;
        self.kdjView.dataArray = self.groupCandleModel.list;
        self.rsiView.dataArray = self.groupCandleModel.list;
        if ([self.timeStr isEqualToString:@"day"] || [self.timeStr isEqualToString:@"week"] ||[self.timeStr isEqualToString:@"month"]) {  // 日 周  月 线
            self.candleView.timeFormat = @"yyyy-MM-dd";
        } else {  // 分  时  线
            self.candleView.timeFormat = @"HH:mm";
        }
        [self.candleView stockFill];
        
        [self.IndicatorView stopAnimating];
    });
   
}

#pragma mark -- 添加手势
- (void)addGestureToCandleView {
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleCandleView:)];
    [self.groupScrollView addGestureRecognizer:pinchGes];
    
    // 长按手势
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesture:)];
    [self.groupScrollView addGestureRecognizer:longPressGesture];
}



#pragma mark -- 手势的方法

// 缩放手势
- (void)scaleCandleView:(UIPinchGestureRecognizer *)pinchGes {
    
    if (pinchGes.state == UIGestureRecognizerStateEnded) {
        _currentZoom = pinchGes.scale;
        self.groupScrollView.scrollEnabled = YES;
    } else if (pinchGes.state == UIGestureRecognizerStateBegan && _currentZoom != 0.0f)
    {
        self.groupScrollView.scrollEnabled = NO;
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
        
        CGFloat offsetX = fabs(_zoomRigthIndex * (self.candleView.candleSpace + self.candleView.candleWidth) - self.groupScrollView.lq_width + self.candleView.kl_leftMargin);
        if (offsetX <= self.groupScrollView.lq_width) {
            offsetX = 0;
        }
        if (offsetX > self.groupScrollView.contentSize.width - self.groupScrollView.lq_width) {
            offsetX = self.groupScrollView.contentSize.width - self.groupScrollView.lq_width;
        }
        self.groupScrollView.contentOffset = CGPointMake(offsetX, 0);
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
        
        self.groupScrollView.scrollEnabled = NO;
        oldPositionX = location.x;
        
        CGPoint point = [self.candleView getLongPressModelPostionWithXPostion:location.x];
        CGFloat xPositoin = point.x + (self.candleView.candleWidth)/2.f - self.candleView.candleSpace/2.f ;
        CGFloat yPositoin = point.y +_candleView.kl_topMargin;
        
        
        // 更新约束
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
        self.groupScrollView.scrollEnabled = YES;
    }
}


// 长按显示view
- (void)longPressStartShowView {
    self.verLineView.hidden = NO;
    self.horLineView.hidden = NO;
    self.closeLabel.hidden = NO;
    self.timeLabel.hidden = NO;
    self.subCandleIndexLabel.hidden = NO;
    
    if (self.candleView.indexType == IndexViewTypeEMA || self.candleView.indexType == IndexViewTypeSMA) {
        self.MA7IndexLabel.hidden = NO;
        self.MA25IndexLabel.hidden = NO;
    }
    
    if (self.candleView.indexType == IndexViewTypeBOLL) {
        self.BOLLLIndexabel.hidden = NO;
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
    self.BOLLLIndexabel.hidden = YES;
}

#pragma mark -- LQCandleProtocol
// 长按获取的数据
- (void)longPressCandleViewWithIndex:(NSInteger)klineModelIndex kLineModel:(LQCandleModel *)kLineModel {
    self.holcView.hidden = NO;
    self.holcView.model= kLineModel;
    
    // 收盘价
    self.closeLabel.text = [NSString stringWithFormat:@"%0.7f",kLineModel.Close];
    
    // 时间
     self.timeLabel.text = [ToolClass stringWithTimestamp:[NSString stringWithFormat:@"%f",[kLineModel.date floatValue] / 1000] dateFormat:@"yyyy-MM-dd HH:mm"];
    
    
    if (!self.volumeView.hidden) { // 显示的是成交量
        self.subCandleIndexLabel.text = [NSString stringWithFormat:@"VOL %.2f",kLineModel.tradeNum];
    }
    if (!self.macdView.hidden) {
        self.subCandleIndexLabel.text = [NSString stringWithFormat:@"MACD{12,26,9}:w %.6f,%.6f,%.6f",[kLineModel.MACD doubleValue],[kLineModel.DIF doubleValue],[kLineModel.DEA floatValue]];
    }
    
    if (!self.kdjView.hidden) {
        self.subCandleIndexLabel.text = [NSString stringWithFormat:@"KDJ{9,3,3}K:%.6f,D:%.6f,J:%.6f",[kLineModel.KDJ_K doubleValue],[kLineModel.KDJ_D doubleValue],[kLineModel.KDJ_J doubleValue]];
    }
    if (!self.rsiView.hidden) {
        self.subCandleIndexLabel.text = [NSString stringWithFormat:@"RSI{6,12,24}:%.6f,%.6f,%.6f",[kLineModel.RSI6 doubleValue],[kLineModel.RSI12 doubleValue],[kLineModel.RSI24 doubleValue]];
    }
    
    // MA赋值
    if (self.candleView.indexType == IndexViewTypeSMA) {
        self.MA7IndexLabel.text = [NSString stringWithFormat:@"[MA7]:%0.8f,",[kLineModel.MA7 doubleValue]];
        self.MA25IndexLabel.text = [NSString stringWithFormat:@"[MA25]:%0.8f",[kLineModel.MA25 doubleValue]];
    }
    
    // EMA
    if (self.candleView.indexType == IndexViewTypeEMA) {
        self.MA7IndexLabel.text = [NSString stringWithFormat:@"[EMA7]:%0.8f",[kLineModel.EMA7 doubleValue]];
        self.MA25IndexLabel.text = [NSString stringWithFormat:@"[EMA25]:%0.8f",[kLineModel.EMA25 doubleValue]];
    }
    
    //BOLL
    if (self.candleView.indexType == IndexViewTypeBOLL) {
        self.BOLLLIndexabel.text = [NSString stringWithFormat:@"BOLL[%.8f,%.8f,%.8f]",[kLineModel.BOLL_UP doubleValue],[kLineModel.BOLL_MB doubleValue],[kLineModel.BOLL_DN doubleValue]];
    }
}


- (void)displayScreenLeftPosition:(CGFloat)leftPosition startIndex:(NSInteger)index count:(NSInteger)count {

    [self showIndexViewWithLeftPosition:leftPosition startIndex:index count:count];
   
}


- (void)showIndexViewWithLeftPosition:(CGFloat)leftPosition startIndex:(NSInteger)index count:(NSInteger)count {
    switch (_indexType) {
        case IndexViewTypeVOL:
        {
            self.macdView.hidden = YES;
            self.kdjView.hidden = YES;
            self.rsiView.hidden = YES;
            
            _volumeView.hidden = NO;
            _volumeView.candleSpace = _candleView.candleSpace;
            _volumeView.candleWidth = _candleView.candleWidth;
            _volumeView.leftPostion = leftPosition;
            _volumeView.startIndex = index;
            _volumeView.displayCount = count;
            
            [_volumeView stockFill];
        }
            break;
        case IndexViewTypeMACD:
        {
            self.volumeView.hidden = YES;
            self.kdjView.hidden = YES;
            self.rsiView.hidden = YES;
            
             _macdView.hidden = NO;
                _macdView.candleSpace = _candleView.candleSpace;
                _macdView.candleWidth = _candleView.candleWidth;
                _macdView.leftPostion = leftPosition;
                _macdView.startIndex = index;
                _macdView.displayCount = count;
            
                [_macdView stockFill];
        }
            break;
        case IndexViewTypeKDJ:
        {
            self.volumeView.hidden = YES;
            self.rsiView.hidden = YES;
            self.macdView.hidden = YES;
            
            _kdjView.hidden = NO;
            
            _kdjView.candleSpace = _candleView.candleSpace;
            _kdjView.candleWidth = _candleView.candleWidth;
            _kdjView.kl_lineWidth = _candleView.kl_lineWidth;
            _kdjView.leftPostion = leftPosition;
            _kdjView.startIndex = index;
            _kdjView.displayCount = count;
            [_kdjView stockFill];
        }
            break;
        case IndexViewTypeRSI:
        {
            self.volumeView.hidden = YES;
            self.kdjView.hidden = YES;
            self.macdView.hidden = YES;
            
            _rsiView.hidden = NO;
            
            _rsiView.candleSpace = _candleView.candleSpace;
            _rsiView.candleWidth = _candleView.candleWidth;
            _rsiView.kl_lineWidth = _candleView.kl_lineWidth;
            _rsiView.leftPostion = leftPosition;
            _rsiView.startIndex = index;
            _rsiView.displayCount = count;
            [_rsiView stockFill];
        }
            break;
        default:
            break;
    }
}

#pragma mark -- 关闭横屏
- (void)closeFullScreen {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- SEFullIndexViewDelegate
- (void)selectIndexWithBtnTitle:(NSString *)title {
    if ([title isEqualToString:@"SMA"]) {
        self.candleView.indexType = IndexViewTypeSMA;
        return;
    }
    
    
    if ([title isEqualToString:@"EMA"]) {
        self.candleView.indexType = IndexViewTypeEMA;
        return;
    }
    
    if ([title isEqualToString:@"BOLL"]) {
        self.candleView.indexType = IndexViewTypeBOLL;
        return;
    }
    
    if ([title isEqualToString:@"VOL"]) {
        self.indexType = IndexViewTypeVOL;
    }
    
    if ([title isEqualToString:@"MACD"]) {
        self.indexType = IndexViewTypeMACD;
    }
    
    if ([title isEqualToString:@"KDJ"]) {
        self.indexType = IndexViewTypeKDJ;
    }
    if ([title isEqualToString:@"RSI"]) {
        self.indexType = IndexViewTypeRSI;
    }
    
    [self showIndexViewWithLeftPosition:self.candleView.leftPostion startIndex:self.candleView.currentStartIndex count:self.candleView.displayCount];
}


#pragma mark -- SEFullScreenKTimeSelectViewDelegate 时间选择
- (void)selectKlineTimeWithType:(KLineTimeType)type {
    
   // [self cancleAllTakeCoin];
    if (type == KLineTimeTypeOneMinute) {
        self.timeStr = @"1m";
    }
    if (type == KLineTimeTypeFiveMinute) {
        self.timeStr = @"5m";
    }
    
    if (type == KLineTimeTypeFifteenMinute) {
        self.timeStr = @"15m";
    }
    
    if (type == KLineTimeTypeThirtyMinute) {
        self.timeStr = @"30m";
    }
    if (type == KLineTimeTypeOneHour) {
        self.timeStr = @"60m";
    }
    if (type == KLineTimeTypeTwoHour) {
        self.timeStr = @"120m";
    }
    if (type == KLineTimeTypeFourHour) {
        self.timeStr = @"240m";
    }
    if (type == KLineTimeTypeSixHour) {
        self.timeStr = @"360m";
    }
    if (type == KLineTimeTypeTwelveHour) {
        self.timeStr = @"720m";
    }
    if (type == KLineTimeTypeDay) {
        self.timeStr = @"day";
    }
    if (type == KLineTimeTypeWeek) {
        self.timeStr = @"week";
    }
    
    // 订阅
//    [self sendKLineData];
}



#pragma mark -- 屏幕旋转
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return (UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight);
//}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}


- (BOOL)shouldAutorotate {
    return NO;
}

@end
