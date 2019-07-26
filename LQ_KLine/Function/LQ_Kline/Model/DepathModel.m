//
//  DepathModel.m
//  LQ_KLine
//
//  Created by lq on 2018/7/23.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import "DepathModel.h"
@implementation DepathModel
- (NSNumber *)sumOfNum {
    if (!_sumOfNum) {
        _sumOfNum = @(self.previousModel.sumOfNum.floatValue + self.num);
    }
    return _sumOfNum;
}

- (void)initWithItemArray:(NSArray *)itemArray {
    _price = [itemArray[0] doubleValue];
    _num = [itemArray[1] doubleValue];
    [self sumOfNum];
}

- (void)initWithEntrustModel:(SEEntrustModel *)model {
    _price = model.Price;
    _num = model.Amount;
    [self sumOfNum];
    
}


@end
