//
//  DepthGroupModel.m
//  LQ_KLine
//
//  Created by lq on 2018/7/23.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import "DepthGroupModel.h"
#import "DepathModel.h"
@implementation DepthGroupModel
+ (instancetype)initWithDic:(NSDictionary *)dic {
    DepthGroupModel *groupModel = [DepthGroupModel new];
    groupModel.buyArray = [NSMutableArray new];
    groupModel.sellArray = [NSMutableArray new];
    
    DepathModel *buyPreModel = [DepathModel new];
    DepathModel *sellPreModel = [DepathModel new];
    
    
    NSArray *buyArray = dic[@"datas"][@"bids"];
    for (NSInteger i = 0; i < buyArray.count; i++) {
        DepathModel *model = [DepathModel new];
        model.previousModel = buyPreModel;
        [model initWithItemArray:buyArray[i]];
        [groupModel.buyArray addObject:model];
        
        buyPreModel = model;
    }
    
    
    NSArray *sellArray = dic[@"datas"][@"asks"];
    for (NSInteger i = 0; i < sellArray.count; i++) {
        DepathModel *model = [DepathModel new];
        model.previousModel = sellPreModel;
        [model initWithItemArray:sellArray[i]];
        [groupModel.sellArray addObject:model];
        
        sellPreModel = model;
    }
    
    
    return groupModel;
}



+ (instancetype)initWithBuyDataArray:(NSArray <SEEntrustModel *> *)buyArray sellArray:(NSArray <SEEntrustModel *> *)sellArray {
    DepthGroupModel *groupModel = [DepthGroupModel new];
    groupModel.buyArray = [NSMutableArray new];
    groupModel.sellArray = [NSMutableArray new];
    
    DepathModel *buyPreModel = [DepathModel new];
    DepathModel *sellPreModel = [DepathModel new];
    
    for (NSInteger i = 0; i < buyArray.count; i++) {
        DepathModel *model = [DepathModel new];
        model.previousModel = buyPreModel;
        [model initWithEntrustModel:buyArray[i]];
        [groupModel.buyArray addObject:model];
        
        buyPreModel = model;
    }
    
    
    for (NSInteger i = 0; i < sellArray.count; i++) {
        DepathModel *model = [DepathModel new];
        model.previousModel = sellPreModel;
        [model initWithEntrustModel:sellArray[i]];
        [groupModel.sellArray addObject:model];
        
        sellPreModel = model;
    }
    
    return groupModel;

}
@end
