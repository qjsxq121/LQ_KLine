//
//  SEMarketModel.h
//  Exchange
//
//  Created by lq on 2018/6/22.
//  Copyright © 2018年 2SE. All rights reserved.
//

// 行情模型
#import <Foundation/Foundation.h>

@interface SEMarketModel : NSObject

/** 成交量 */
@property (nonatomic, assign) double Volume;

/** 最新价 */
@property (nonatomic,assign) double New;

/** 涨跌幅 */
@property (nonatomic, assign) double Increase;


/** 最低价 */
@property (nonatomic, assign) double Low;

/** 最高价 */
@property (nonatomic, assign) double High;

/** 涨幅额 */
@property (nonatomic, assign) double UpDown;

#pragma mark -- 自己添加的字段
/** 最新价 */
@property (nonatomic, copy) NSString *nowPrice;

@end
