//
//  LQDateFormatter.m
//  BFGP
//
//  Created by lq on 2017/10/12.
//  Copyright © 2017年 bfgp. All rights reserved.
//

#import "LQDateFormatter.h"

static LQDateFormatter *_dateFormatter;
@implementation LQDateFormatter

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _dateFormatter = [super allocWithZone:zone];
    });
    //    返回对象
    return _dateFormatter;
}

+ (LQDateFormatter *)shareDateFormatter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _dateFormatter = [[self alloc] init];
    });
    return  _dateFormatter;
}


@end
