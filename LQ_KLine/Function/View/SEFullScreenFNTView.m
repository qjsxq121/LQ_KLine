//
//  SEFullScreenFNTView.m
//  Exchange
//
//  Created by lq on 2018/7/3.
//  Copyright © 2018年 2SE. All rights reserved.
//

// 全屏时  浮动 名字 时间view
#import "SEFullScreenFNTView.h"
#import "SESuperMarketModel.h"
@interface SEFullScreenFNTView ()

/** 名字 */
@property (nonatomic, strong) UILabel *nameLabel;

/** 当前价和浮动 */
@property (nonatomic, strong) UILabel *nowPriceAFloatLabel;

/** 时间 */
@property (nonatomic, strong) UILabel *nowTimeLabel;



@end
@implementation SEFullScreenFNTView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
     //   [self teeee];
    }
    return self;
}

- (void)setUIWith:(SESuperMarketModel *)model baseCoin:(NSString *)base {
    self.nameLabel.text = [NSString stringWithFormat:@"%@／%@",[model.Obj stringByReplacingOccurrencesOfString:base withString:@""],base];
   

    NSString *floatStr = [NSString stringWithFormat:@"%0.7f %0.2f%%",model.Data.UpDown,model.Data.Increase];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",model.Data.nowPrice,floatStr]];
    [attribute addAttribute:NSFontAttributeName value:PriceFontWithSize(11) range:NSMakeRange(model.Data.nowPrice.length + 1, floatStr.length)];
    
    self.nowPriceAFloatLabel.attributedText = attribute;
    if (model.Data.Increase <= 0) {
        self.nowPriceAFloatLabel.textColor = SERedColor;
    }
    if (model.Data.Increase > 0) {
        self.nowPriceAFloatLabel.textColor = SEGreenColor;
    }
}
- (void)addSubviews {
    
    // 名字
    self.nameLabel = [UILabel creatLabelWithTextColor:BlackTextColor font:TextFontWithSize(15)];
    [self addSubview:_nameLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HorMargin);
        make.height.mas_equalTo(16);
        make.centerY.mas_equalTo(self);
    }];
    
    
    // 当前价和浮动
    self.nowPriceAFloatLabel = [UILabel creatLabelWithTextColor:BlackTextColor font:PriceFontWithSize(15)];
    [self addSubview:_nowPriceAFloatLabel];
    [_nowPriceAFloatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.mas_equalTo(_nameLabel);
        make.centerX.mas_equalTo(self);
    }];
    
    // 关闭横屏的按钮
    UIButton *closeFullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeFullScreenBtn setImage:[UIImage imageNamed:@"full_screen_Close"] forState:UIControlStateNormal];
    [closeFullScreenBtn addTarget:self action:@selector(clickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeFullScreenBtn];
    [closeFullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(30);
        make.right.mas_equalTo(-5);
    }];
    
    // 时间
    self.nowTimeLabel = [UILabel creatLabelWithTextColor:GaryTextColor font:TextFontWithSize(11)];
    [self addSubview:_nowTimeLabel];
    
    [_nowTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.mas_equalTo(_nameLabel);
        make.right.mas_equalTo(closeFullScreenBtn.mas_left).mas_offset(-10);
    }];
    
}


#pragma mark -- 关闭横屏
- (void)clickCloseBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(closeFullScreen)]) {
        [self.delegate closeFullScreen];
    }
}
@end
