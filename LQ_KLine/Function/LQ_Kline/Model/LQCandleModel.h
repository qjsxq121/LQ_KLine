//
//  KLineModel.h
//  LQ_KLine
//
//  Created by lq on 2018/2/28.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LQGroupCandleModel;

@interface LQCandleModel : NSObject

/** 高 */
@property (nonatomic, assign) CGFloat High;

/** 开 */
@property (nonatomic, assign) CGFloat Open;

/** 低 */
@property (nonatomic, assign) CGFloat Low;

/** 收 */
@property (nonatomic, assign) CGFloat Close;
/** 时间 */
@property (nonatomic, copy) NSString *date;
/** 换手 */
@property (nonatomic, assign) CGFloat tradeNum;

/** 成交金额 */
@property (nonatomic, assign) CGFloat dealMoney;

/**************************************/

#pragma mark -- 自己加的属性 方便计算

/** 是否画日期 */
@property (nonatomic, assign) BOOL isDrawDate;

@property (assign, nonatomic) NSInteger localIndex;

/** index */
@property (nonatomic, assign) NSInteger index;
/** superModel */
@property (nonatomic, strong) LQGroupCandleModel *superModel;


/** 前一个model */
@property (nonatomic, strong) LQCandleModel *previousKlineModel;

/** 该Model及其之前所有收盘价之和 */
@property (nonatomic, copy) NSNumber *sumOfLastClose;

#pragma mark -- MA
/** ma5 */
@property (nonatomic, copy) NSNumber *MA5;

/** ma7 */
@property (nonatomic, copy) NSNumber *MA7;


/** ma10 */
@property (nonatomic, copy) NSNumber *MA10;

/** ma20 */
@property (nonatomic, copy) NSNumber *MA20;

/** ma25 */
@property (nonatomic, copy) NSNumber *MA25;

#pragma mark -- BOLL线
/** ma20 */
//@property (nonatomic, copy) NSNumber *MA20;

/**  标准差 二次方根【下的 （n - 1）天的C-MA二次方 和】 */
@property (nonatomic, copy) NSNumber *BOLL_MD; //

/** 中轨线n - 1 天的 MA */
@property (nonatomic, copy) NSNumber *BOLL_MB;//

/** 上轨线MB + k * MD */
@property (nonatomic, copy) NSNumber *BOLL_UP; //

/**下轨线 MB - k * MD */
@property (nonatomic, copy) NSNumber *BOLL_DN;

//  n 个 ( Cn - MA20)的平方和
@property (nonatomic, copy) NSNumber *BOLL_SUBMD_SUM;

// 当前的 ( Cn - MA20)的平方
@property (nonatomic, copy) NSNumber *BOLL_SUBMD;


#pragma mark -- EMA
// EMA（N）=2/（N+1）*（C-昨日EMA）+昨日EMA； EMAtoday=α * Pricetoday + ( 1 - α ) * EMAyesterday; 其中，α为平滑指数，一般取作2/(N+1)。在计算MACD指标时，EMA计算中的N一般选取12和26天，因此α相应为2/13和2/27。
/** EMA7 */
@property (nonatomic, copy) NSNumber *EMA7;

/** EMA12 */
@property (nonatomic, copy) NSNumber *EMA12;

/** EMA25 */
@property (nonatomic, copy) NSNumber *EMA25; 

/** EMA26 */
@property (nonatomic, copy) NSNumber *EMA26;


#pragma mark -- MACD

//MACD主要是利用长短期的二条平滑平均线，计算两者之间的差离值，作为研判行情买卖之依据。MACD指标是基于均线的构造原理，对价格收盘价进行平滑处 理(求出算术平均值)后的一种趋向类指标。它主要由两部分组成，即正负差(DIF)、异同平均数(DEA)，其中，正负差是核心，DEA是辅助。DIF是 快速平滑移动平均线(EMA1)和慢速平滑移动平均线(EMA2)的差。

//在现有的技术分析软件中，MACD常用参数是快速平滑移动平均线为12，慢速平滑移动平均线参数为26。此外，MACD还有一个辅助指标——柱状线 (BAR)。在大多数技术分析软件中，柱状线是有颜色的，在低于0轴以下是绿色，高于0轴以上是红色，前者代表趋势较弱，后者代表趋势较强。

//MACD(12,26.9),下面以该参数为例说明计算方法。


//12日EMA的算式为
//EMA（12）=昨日EMA（12）*11/13+C*2/13＝(C－昨日的EMA)×0.1538＋昨日的EMA；   即为MACD指标中的快线-快速平滑移动平均线；
//26日EMA的算式为
//EMA（26）=昨日EMA（26）*25/27+C*2/27；   即为MACD指标中的慢线-慢速平滑移动平均线；

//DIF=EMA（12）-EMA（26）         DIF的值即为红绿柱；
/** DIF */
@property (nonatomic, copy) NSNumber *DIF;

//今日的DEA值（即MACD值）=前一日DEA*8/10+今日DIF*2/10.
/** DEA */
@property (nonatomic, copy) NSNumber *DEA;

//EMA（12）=昨日EMA（12）*11/13+C*2/13；   即为MACD指标中的快线；
//EMA（26）=昨日EMA（26）*25/27+C*2/27；   即为MACD指标中的慢线；
/** MACD */
@property (nonatomic, copy) NSNumber *MACD;


#pragma mark -- KDJ



//KDJ(9,3.3),下面以该参数为例说明计算方法。
//9，3，3代表指标分析周期为9天，K值D值为3天
//RSV(9)=（今日收盘价－9日内最低价）÷（9日内最高价－9日内最低价）×100
//K(3日)=（当日RSV值+2*前一日K值）÷3
//D(3日)=（当日K值+2*前一日D值）÷3
//J=3K－2D

/** 九日内最低价 */
@property (nonatomic, copy) NSNumber *NineClocksMinPrice;

/** 九日内最高价 */
@property (nonatomic, copy) NSNumber *NineClocksMaxPrice;



/** RSV_9 */
@property (nonatomic, copy) NSNumber *RSV_9;

/** KDJ_K */
@property (nonatomic, copy) NSNumber *KDJ_K;

/** KDJ_D */
@property (nonatomic, copy) NSNumber *KDJ_D;

/** KDJ_J */
@property (nonatomic, copy) NSNumber *KDJ_J;



#pragma mark -- WR
/*
 WR1一般是10天买卖强弱指标；
 WR2一般是6天买卖强弱指标。
 以N日威廉指标为例，
 WR(N) = 100 * [ HIGH(N)-C ] / [ HIGH(N)-LOW(N) ]
 C：当日收盘价
 HIGH(N)：N日内的最高价
 LOW(n)：N日内的最低价 [1]
 */

/** WR10 */
@property (nonatomic, copy) NSNumber *WR10;

/** WR6 */
@property (nonatomic, copy) NSNumber *WR6;


#pragma mark -- RSI 指标
/*
 
 RS(相对强度)=N日内收盘价涨数和之均值÷N日内收盘价跌数和之均值
 
 　　RSI(相对强弱指标)=100－100÷(1+RS)
 
 　　以14日RSI指标为例，从当起算，倒推包括当日在内的15个收盘价，以每一日的收盘价减去上一日的收盘价，得到14个数值，这些数值有正有负。这样，RSI指标的计算公式具体如下：
 
 　　A=14个数字中正数之和
 
 　　B=14个数字中负数之和乘以(—1)
 
 　　RSI(14)=A÷(A＋B)×100
 
 　　式中：A为14日中股价向上波动的大小
 
 　　B为14日中股价向下波动的大小
 
 　　A＋B为股价总的波动大小
 */

/** 正数和 A 上波动 */
@property (nonatomic, copy) NSNumber *sumUpFluctute;

/** 总波动BA+ B */
@property (nonatomic, copy) NSNumber *sumTotalFluctute;


/** RSI6 */
@property (nonatomic, copy) NSNumber *RSI6;

/** RSI12 */
@property (nonatomic, copy) NSNumber *RSI12;

/** RSI24 */
@property (nonatomic, strong) NSNumber *RSI24;

#pragma mark -- 初始化数据
- (void)initData;

- (void)initModelWith:(id)response;

@end
