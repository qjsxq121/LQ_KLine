//
//  SETableView.m
//  Exchange
//
//  Created by lq on 2018/6/22.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import "SEBaseTableView.h"

@implementation SEBaseTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.separatorStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

@end
