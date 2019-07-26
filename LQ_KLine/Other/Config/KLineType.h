//
//  KLineType.h
//  LQ_KLine
//
//  Created by lq on 2019/6/16.
//  Copyright © 2019年 2SE. All rights reserved.
//

#ifndef KLineType_h
#define KLineType_h

// k线横屏 指标 的选择类型
typedef NS_ENUM(NSInteger,IndexViewType) {
    IndexViewTypeSMA = 0,
    IndexViewTypeEMA,
    IndexViewTypeBOLL,
    IndexViewTypeVOL,
    IndexViewTypeMACD,
    IndexViewTypeKDJ,
    IndexViewTypeRSI
};

// k线 时间 选择 类型
typedef NS_ENUM(NSInteger, KLineTimeType) {
    KLineTimeTypeTimeShare = 0, // 分时
    KLineTimeTypeOneMinute,             // 1分
    KLineTimeTypeFiveMinute,            // 5分
    KLineTimeTypeFifteenMinute,         // 15分
    KLineTimeTypeThirtyMinute,          // 30分
    KLineTimeTypeOneHour,               // 1小时
    KLineTimeTypeTwoHour,               // 2小时
    KLineTimeTypeFourHour,              // 4小时
    KLineTimeTypeSixHour,               // 6小时
    KLineTimeTypeTwelveHour,            // 12小时
    KLineTimeTypeDay,                   // 日线
    KLineTimeTypeWeek                   // 周线
};


#endif /* KLineType_h */
