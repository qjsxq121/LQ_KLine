//
//  LQGroupCandleModel.h
//  LQ_KLine
//
//  Created by lq on 2018/6/15.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LQCandleModel;
@interface LQGroupCandleModel : NSObject

/** 数据源 */
@property (nonatomic,strong) NSMutableArray<__kindof LQCandleModel*> *list;


/** 最新的一条数据 */
@property (nonatomic, strong) LQCandleModel *newestModel;

+ (instancetype)initWithArr:(NSArray *)modelArr;

@end
