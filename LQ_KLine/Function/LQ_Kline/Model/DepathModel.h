//
//  DepathModel.h
//  LQ_KLine
//
//  Created by lq on 2018/7/23.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEEntrustModel.h"

@interface DepathModel : NSObject

/** 价格 */
@property (nonatomic, assign) double price;

/** 量 */
@property (nonatomic, assign) double num;


#pragma mark --

/** 该model及其之前所有量的和 */
@property (nonatomic, strong) NSNumber *sumOfNum;


/** 前一个mode· */
@property (nonatomic, strong) DepathModel *previousModel;



- (void)initWithItemArray:(NSArray *)itemArray;


// 根据委托模型初始化
- (void)initWithEntrustModel:(SEEntrustModel *)model;
@end
