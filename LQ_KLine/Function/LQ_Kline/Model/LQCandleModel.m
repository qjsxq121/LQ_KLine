//
//  KLineModel.m
//  LQ_KLine
//
//  Created by lq on 2018/2/28.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import "LQCandleModel.h"
#import "LQGroupCandleModel.h"
@implementation LQCandleModel

- (NSNumber *)sumOfLastClose {
    if (!_sumOfLastClose) {
        _sumOfLastClose = @(self.previousKlineModel.sumOfLastClose.floatValue + self.Close);
    }
    return _sumOfLastClose;
}


#pragma mark -- MA 线
- (NSNumber *)MA5 {
    if (!_MA5) {
        _MA5 = [self calculateMAWithNum:5];
    }
    
    return _MA5;
}

- (NSNumber *)MA7 {
    if (!_MA7) {
        _MA7 = [self calculateMAWithNum:7];
    }
    return _MA7;
}
- (NSNumber *)MA10 {
    if (!_MA10) {
        _MA10 = [self calculateMAWithNum:10];
    }
    return _MA10;
}

- (NSNumber *)MA20 {
    if (!_MA20) {
        _MA20 = [self calculateMAWithNum:20];
    }
    return _MA20;
}


- (NSNumber *)MA25 {
    if (!_MA25) {
        _MA25 = [self calculateMAWithNum:25];
    }
    
    return _MA25;
}


// 求MA的通用方法
- (NSNumber *)calculateMAWithNum:(NSInteger)num {
//    NSInteger index = [self.superModel.list indexOfObject:self];
//
//    if (index >= self.superModel.list.count) {
//        NSLog(@"%ld",index);
//
//        return nil;
//    }
    if (_index >= num - 1) {
        if (_index > num - 1) {
            return  @((self.sumOfLastClose.floatValue - self.superModel.list[_index - num].sumOfLastClose.floatValue) / num);
        } else {
            return @(self.sumOfLastClose.floatValue / num);
        }
    } else {
        return nil;
    }
    
}

#pragma mark -- BOLL 线 20MA为基础

- (NSNumber *)BOLL_MB {
    if (!_BOLL_MB) {
      //  NSInteger index = [self.superModel.list indexOfObject:self];
        if (_index >= 19) {
            if (_index > 19) {
                _BOLL_MB = @((self.sumOfLastClose.floatValue - self.superModel.list[_index - 19].sumOfLastClose.floatValue) / 19);
            } else {
                _BOLL_MB = @(self.sumOfLastClose.floatValue / _index);
            }
        }
    }
    
    return _BOLL_MB;
}


// 标准差
- (NSNumber *)BOLL_MD {
    if (!_BOLL_MD) {
       // NSInteger index = [self.superModel.list indexOfObject:self];
        if (_index >= 20) {
            _BOLL_MD = @(sqrt((self.previousKlineModel.BOLL_SUBMD_SUM.floatValue - self.superModel.list[_index - 20].BOLL_SUBMD_SUM.floatValue) / 20));
        }
    }
    return _BOLL_MD;
}

// 上轨线
- (NSNumber *)BOLL_UP {
    if (!_BOLL_UP) {
       // NSInteger index = [self.superModel.list indexOfObject:self];
        
        if (_index >= 20) {
            _BOLL_UP = @(self.BOLL_MB.floatValue + 2 * self.BOLL_MD.floatValue);
        }
    }
    
    return _BOLL_UP;
}

// 下轨线
- (NSNumber *)BOLL_DN {
    if (!_BOLL_DN) {
      //  NSInteger index = [self.superModel.list indexOfObject:self];
        if (_index >= 20) {
            _BOLL_DN = @(self.BOLL_MB.floatValue - 2 * self.BOLL_MD.floatValue);
        }
    }
    return _BOLL_DN;
}
- (NSNumber *)BOLL_SUBMD_SUM {
    if (!_BOLL_SUBMD_SUM) {
      //  NSInteger index = [self.superModel.list indexOfObject:self];
        if (_index >= 20) {
            _BOLL_SUBMD_SUM = @(self.previousKlineModel.BOLL_SUBMD_SUM.floatValue + self.BOLL_SUBMD.floatValue);
        }
    }
    
    return _BOLL_SUBMD_SUM;
}


- (NSNumber *)BOLL_SUBMD {
    if (!_BOLL_SUBMD) {
       // NSInteger index = [self.superModel.list indexOfObject:self];
        if (_index >= 20) {
            _BOLL_SUBMD = @((self.Close - self.MA20.floatValue) * (self.Close - self.MA20.floatValue));
            
        }
    }
    
    return _BOLL_SUBMD;
}


#pragma mark -- EMA

- (NSNumber *)EMA7 {
    if (!_EMA7) {
        _EMA7 = @((2 * self.Close + 6 * self.previousKlineModel.EMA7.floatValue) / 8);
        
    }
    return _EMA7;
}
- (NSNumber *)EMA12 {
    if (!_EMA12) {
        _EMA12 = @((2 * self.Close + 11 * self.previousKlineModel.EMA12.floatValue) / 13);
    }
    return _EMA12;
}


- (NSNumber *)EMA25 {
    if (!_EMA25) {
        _EMA25 = @((2 * self.Close + 24 * self.previousKlineModel.EMA25.floatValue) / 26);
    }
    return _EMA25;
}
- (NSNumber *)EMA26 {
    if (!_EMA26) {
        _EMA26 = @((2 * self.Close + 25 * self.previousKlineModel.EMA26.floatValue) / 27);
    }
    return _EMA26;
}


#pragma mark -- MACD
- (NSNumber *)DIF {
    if (!_DIF) {
        _DIF = @(self.EMA12.floatValue - self.EMA26.floatValue);
    }
    return _DIF;
}

- (NSNumber *)DEA {
    if (!_DEA) {
        _DEA = @(self.previousKlineModel.DEA.floatValue * 0.8 + 0.2 * self.DIF.floatValue);
    }
    return _DEA;
}

- (NSNumber *)MACD {
    if (!_MACD) {
        _MACD = @(2 * (self.DIF.floatValue - self.DEA.floatValue));
    }
    return _MACD;
}



#pragma mark -- KDJ
- (NSNumber *)NineClocksMaxPrice {
    if (!_NineClocksMaxPrice) {
        
      //  NSInteger index = [self.superModel.list indexOfObject:self];
        if (_index >= 8) {
            _NineClocksMaxPrice = [self calcuteDaysMaxAndMinValueByArray:[self.superModel.list subarrayWithRange:NSMakeRange(_index - 8, 9)] condition:NSOrderedAscending];
        }
    }
    return _NineClocksMaxPrice;
}

- (NSNumber *)NineClocksMinPrice {
    if (!_NineClocksMinPrice) {
       // NSInteger index = [self.superModel.list indexOfObject:self];
        if (_index >= 8) {
            _NineClocksMinPrice = [self calcuteDaysMaxAndMinValueByArray:[self.superModel.list subarrayWithRange:NSMakeRange(_index - 8, 9)] condition:NSOrderedDescending];
        }
    }
    return _NineClocksMinPrice;
}

- (NSNumber *)RSV_9 {
    if (_NineClocksMaxPrice) {
        if (!_RSV_9) {
            if (self.NineClocksMinPrice.floatValue == self.NineClocksMaxPrice.floatValue) {
                _RSV_9 = @100;
            } else {
                _RSV_9 = @((self.Close - self.NineClocksMinPrice.floatValue) / (self.NineClocksMaxPrice.floatValue - self.NineClocksMinPrice.floatValue) * 100);
            }
        }
    }
    return _RSV_9;
}

- (NSNumber *)KDJ_K {
    if (_RSV_9) {
        if (!_KDJ_K) {
            _KDJ_K =  @((self.RSV_9.floatValue + 2 * (self.previousKlineModel.KDJ_K ? self.previousKlineModel.KDJ_K.floatValue : 50) )/3);
        }
    }
    return _KDJ_K;
}


- (NSNumber *)KDJ_D {
    if (_KDJ_K) {
        if (!_KDJ_D) {
            _KDJ_D = @((self.KDJ_K.floatValue + 2 * (self.previousKlineModel.KDJ_D ? self.previousKlineModel.KDJ_D.floatValue : 50))/3);
        }
    }
    return _KDJ_D;
}


- (NSNumber *)KDJ_J {
    if (_KDJ_D) {
        if (!_KDJ_J) {
            _KDJ_J = @(3*self.KDJ_K.floatValue - 2*self.KDJ_D.floatValue);
        }
    }
    return _KDJ_J;
}



#pragma mark -- WR
//100 * [ HIGH(N)-C ] / [ HIGH(N)-LOW(N) ]
- (NSNumber *)WR10 {
    if (!_WR10) {
        _WR10 = [self calcuteWRWithNum:10];
    }
    return _WR10;
}


- (NSNumber *)WR6 {
    if (!_WR6) {
        _WR6 = [self calcuteWRWithNum:6];
    }
    return _WR6;
}

//求WR 的通用方法
- (NSNumber *)calcuteWRWithNum:(NSInteger)num {
    
   // NSInteger index = [self.superModel.list indexOfObject:self];
    if (_index >= num - 1) {
        // 10日内最高价
        NSNumber *highDays = [self calcuteDaysMaxAndMinValueByArray:[self.superModel.list subarrayWithRange:NSMakeRange(_index - num + 1, num)] condition:NSOrderedAscending];
        
        // 10日内最低价
        NSNumber *lowDays = [self calcuteDaysMaxAndMinValueByArray:[self.superModel.list subarrayWithRange:NSMakeRange(_index - num + 1,num)] condition:NSOrderedDescending];
        
        return  @(100 * (highDays.floatValue - self.Close) / (highDays.floatValue - lowDays.floatValue));
    } else {
        return nil;
    }
    
}

// 计算几日内的极值
- (NSNumber *)calcuteDaysMaxAndMinValueByArray:(NSArray<LQCandleModel *> *)modes condition:(NSComparisonResult)cond {
    
    
    //  求几日内的最高价
    if (cond == NSOrderedAscending) {
        NSComparator cmptr;
        cmptr = ^(LQCandleModel *model1, LQCandleModel *model2) {
            if (model1.High > model2.High) {
                return NSOrderedAscending;
                
            }
            if (model1.High < model2.High) {
                return NSOrderedDescending;
            }
            return   NSOrderedSame;
        };
        NSArray <LQCandleModel *> *resultArr = [modes sortedArrayUsingComparator:cmptr];
        
        return @(resultArr[0].High);
        
    }
    
    
    // 求几日内的最低价
    else {
        
        NSComparator cmptr;
        cmptr = ^(LQCandleModel *model1, LQCandleModel *model2) {
            if (model1.Low < model2.Low) {
                return NSOrderedAscending;
                
            }
            if (model1.Low > model2.Low) {
                return NSOrderedDescending;
            }
            return   NSOrderedSame;
        };
        NSArray <LQCandleModel *> *resultArr = [modes sortedArrayUsingComparator:cmptr];
        
        return @(resultArr[0].Low);
    }
}

#pragma mark -- RSI

// 正数和
- (NSNumber *)sumUpFluctute {
    if (!_sumUpFluctute) {
        _sumUpFluctute = @(fmax(self.Close - self.previousKlineModel.Close, 0) + self.previousKlineModel.sumUpFluctute.floatValue);
    }
    return _sumUpFluctute;
}


// 总波动
- (NSNumber *)sumTotalFluctute {
    if (!_sumTotalFluctute) {
        _sumTotalFluctute = @(fabs(self.Close - self.previousKlineModel.Close) + self.previousKlineModel.sumTotalFluctute.floatValue);
    }
    return _sumTotalFluctute;
}



// RSI6
- (NSNumber *)RSI6 {
    if (!_RSI6) {
        _RSI6 = [self calcuteRSIWithNum:6];
    }
    return _RSI6;
}


//RSI12
- (NSNumber *)RSI12 {
    if (!_RSI12) {
        _RSI12 = [self calcuteRSIWithNum:12];
    }
    return _RSI12;
}

// RSI24
- (NSNumber *)RSI24 {
    if (!_RSI24) {
        _RSI24 = [self calcuteRSIWithNum:24];
    }
    return _RSI24;
}

- (NSNumber *)calcuteRSIWithNum:(NSInteger)num {
   // NSInteger index = [self.superModel.list indexOfObject:self];
    
  
    if (_index >= num - 1) {
        if (_index > num - 1) {
            if (self.sumTotalFluctute.floatValue == self.superModel.list[_index - num].sumTotalFluctute.floatValue) {
                return nil;
            }
            return @((self.sumUpFluctute.floatValue - self.superModel.list[_index - num].sumUpFluctute.floatValue) / (self.sumTotalFluctute.floatValue - self.superModel.list[_index - num].sumTotalFluctute.floatValue) * 100);
        } else {
            return @(self.sumUpFluctute.floatValue / self.sumTotalFluctute.floatValue * 100);
        }
    } else {
        return nil;
    }

}
#pragma mark -- 初始化
- (void)initData {
    
    // ma 现在用到 ma7  和 ma25
//    [self MA5];
    [self sumOfLastClose];
    [self MA7];
//    [self MA10];
//    [self MA20];
    [self MA25];
    // BOLL 数据
    [self BOLL_SUBMD];
    [self BOLL_SUBMD_SUM];
    [self BOLL_MB];
    [self BOLL_MD];
    [self BOLL_UP];
    [self BOLL_DN];
    
    //EMA
    [self EMA7];
    [self EMA25];
    
    //MACD
    [self EMA12];
    [self EMA26];
    [self DIF];
    [self DEA];
    [self MACD];
    
    
    // KDJ
    [self NineClocksMaxPrice];
    [self NineClocksMinPrice];
    [self RSV_9];
    [self KDJ_K];
    [self KDJ_D];
    [self KDJ_J];
    
    //WR
//    [self WR10];
//    [self WR6];
    
    // RSI
    [self sumUpFluctute];
    [self sumTotalFluctute];
    [self RSI6];
    
}


- (void)initModelWith:(id)response {
    if (self) {
        
            _High = [response[@"High"] doubleValue];
            _Open = [response[@"Open"] doubleValue];
            _Low = [response[@"Low"] doubleValue];
            _Close = [response[@"Close"] doubleValue];
            _date = response[@"TimeStamp"];
        _tradeNum = [response[@"tradeNum"] doubleValue];
        _dealMoney = [response[@"Amount"] doubleValue];
      //  self.sumOfLastClose = @(self.previousKlineModel.sumOfLastClose.floatValue + self.close);
        
    }
}

@end
