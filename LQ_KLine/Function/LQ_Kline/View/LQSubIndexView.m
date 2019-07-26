//
//  LQSubIndexView.m
//  LQ_KLine
//
//  Created by lq on 2018/6/19.
//  Copyright © 2018年 YiYoff. All rights reserved.
//
// 副图指标view
#import "LQSubIndexView.h"
@interface LQSubIndexView ()

/** 指标文字的数组 */
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation LQSubIndexView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleArray = @[@"MACD",@"KDJ",@"WR"];
    }
    return self;
}

- (void)addSubviews {
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
      //  UIButton *button = [self creatBtnWithTitle:_titleArray[i]];
       // button.lq_width = 
    }
}


- (UIButton *)creatBtnWithTitle:(NSString *)title {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    
    return button;
}
@end
