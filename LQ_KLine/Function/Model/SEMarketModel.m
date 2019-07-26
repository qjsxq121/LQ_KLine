//
//  SEMarketModel.m
//  Exchange
//
//  Created by lq on 2018/6/22.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import "SEMarketModel.h"

@implementation SEMarketModel

- (NSString *)nowPrice {
    
    NSString *doubleString = [NSString stringWithFormat:@"%0.8lf", _New];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    
    return [decNumber stringValue];
}
@end
