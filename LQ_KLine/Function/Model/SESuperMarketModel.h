//
//  SESuperMarketModel.h
//  Exchange
//
//  Created by lq on 2018/6/29.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEMarketModel.h"
@interface SESuperMarketModel : NSObject

/** 货币对 */
@property (nonatomic, copy) NSString *Obj;

/** 行情 */
@property (nonatomic, strong) SEMarketModel *Data;


/** 是否是我的自选 */
@property (nonatomic, assign) BOOL isOptional;

@end
