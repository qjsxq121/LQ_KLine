//
//  LQGroupCandleModel.m
//  LQ_KLine
//
//  Created by lq on 2018/6/15.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import "LQGroupCandleModel.h"
#import "LQCandleModel.h"
@implementation LQGroupCandleModel

+ (instancetype)initWithArr:(NSArray *)modelArr {
    NSAssert([modelArr isKindOfClass:[NSArray class]], @"arr不是一个数组");
    LQGroupCandleModel *superModel = [LQGroupCandleModel new];
    
    NSMutableArray *tempArr = @[].mutableCopy;
    __block  LQCandleModel *preModel = [[LQCandleModel alloc] init];
    
    for (NSInteger i = 0; i < modelArr.count; i ++) {
        LQCandleModel *model =  [LQCandleModel new];
        model.previousKlineModel = preModel;
        model.index = i;
        [model initModelWith:modelArr[i]];
        model.superModel = superModel;
        
        
        
        if (i % 10 == 0) {
            model.isDrawDate = YES;
        }
        [tempArr addObject:model];
        
        preModel = model;
    }
    
    superModel.list = tempArr;
    
    
    [tempArr enumerateObjectsUsingBlock:^(LQCandleModel  * model, NSUInteger idx, BOOL * _Nonnull stop) {
        [model initData];
    }];
    
    return superModel;
}




@end
