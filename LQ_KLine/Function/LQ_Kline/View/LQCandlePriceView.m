//
//  LQCandlePriceView.m
//  LQ_KLine
//
//  Created by lq on 2018/6/19.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import "LQCandlePriceView.h"
@interface LQCandlePriceView ()

/** <#name#> */
@property (nonatomic, strong) UILabel *priceLabel1;

/** <#name#> */
@property (nonatomic, strong) UILabel *priceLabel2;

/** <#name#> */
@property (nonatomic, strong) UILabel *priceLabel3;

/** <#name#> */
@property (nonatomic, strong) UILabel *priceLabel4;

/** <#name#> */
@property (nonatomic, strong) UILabel *priceLabel5;


/** label数组 */
@property (nonatomic, strong) NSArray *labelArray;

@end


static CGFloat const kSelfHeight = 400;

@implementation LQCandlePriceView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self layoutIfNeeded];
        [self addSubViews];
    }
    return self;
}



- (UILabel *)priceLabel1 {
    if (!_priceLabel1) {
        _priceLabel1 = [self createLabel];
        [self addSubview:_priceLabel1];
        [_priceLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.top.right.mas_equalTo(0);
            make.height.mas_equalTo(13);
        }];
        
    }
    return _priceLabel1;
}



- (UILabel *)priceLabel2 {
    if (!_priceLabel2) {
        _priceLabel2 = [self createLabel];
        [self addSubview:_priceLabel2];
        
        [_priceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.mas_equalTo(_priceLabel1);
            make.centerY.mas_equalTo(self).mas_offset(-kSelfHeight / 4);
        }];
        
    }
    return _priceLabel2;
}

- (UILabel *)priceLabel3 {
    if (!_priceLabel3) {
        _priceLabel3 = [self createLabel];
        [self addSubview:_priceLabel3];

        [_priceLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.mas_equalTo(_priceLabel1);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _priceLabel3;
}

- (UILabel *)priceLabel4 {
    if (!_priceLabel4) {
        _priceLabel4 = [self createLabel];
        [self addSubview:_priceLabel4];

        [_priceLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.mas_equalTo(_priceLabel1);
            make.centerY.mas_equalTo(kSelfHeight / 4);
        }];

    }
    return _priceLabel4;
}

- (UILabel *)priceLabel5 {
    if (!_priceLabel5) {
        _priceLabel5 = [self createLabel];
        [self addSubview:_priceLabel5];

        [_priceLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.height.right.mas_equalTo(_priceLabel1);
            make.bottom.mas_equalTo(0);
        }];

    }
    return _priceLabel5;
}


#pragma mark -- 添加subView
- (void)addSubViews {
    
    [self priceLabel1];
    [self priceLabel2];
    [self priceLabel3];
    [self priceLabel4];
    [self priceLabel5];
    
    
    self.labelArray = @[self.priceLabel1,self.priceLabel2,self.priceLabel3,self.priceLabel4,self.priceLabel5];
   
}




- (UILabel *)createLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    [label setFont:[UIFont systemFontOfSize:12]];
    
    return label;
}


#pragma mark -- 赋值
- (void)setPriceWithMaxPrice:(CGFloat)maxPrice minPrice:(CGFloat)minPrice {
    
    for (NSInteger i = 0; i < self.labelArray.count; i ++) {
        UILabel *label = self.labelArray[i];
        
        CGFloat price = maxPrice - ((maxPrice - minPrice) / (self.labelArray.count - 1)) * i;
        label.text = [NSString stringWithFormat:@"%.2f",price];
    }
}

@end
