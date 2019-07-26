//
//  DepthGroupModel.h
//  LQ_KLine
//
//  Created by lq on 2018/7/23.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DepathModel;
@class SEEntrustModel;
@interface DepthGroupModel : NSObject

/** 买单 */
@property (nonatomic, strong) NSMutableArray <__kindof DepathModel *> *buyArray;

/** 卖单 */
@property (nonatomic, strong) NSMutableArray <__kindof DepathModel *> *sellArray;

+ (instancetype)initWithDic:(NSDictionary *)dic;


+ (instancetype)initWithBuyDataArray:(NSArray <SEEntrustModel *> *)buyArray sellArray:(NSArray <SEEntrustModel *> *)sellArray;
@end
