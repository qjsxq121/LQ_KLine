//
//  SEKLineHPLCItemView.m
//  Exchange
//
//  Created by lq on 2018/7/5.
//  Copyright © 2018年 2SE. All rights reserved.
//
// 显示高开低收的view
#import "SEKLineHPLCItemView.h"
#import "LQCandleModel.h"
@interface SEKLineHPLCItemView ()

/** 高 */
@property (nonatomic, strong) UILabel *highLabel;

/** 开 */
@property (nonatomic, strong) UILabel *openLabel;

/** 低 */
@property (nonatomic, strong) UILabel *lowLabel;

/** 收 */
@property (nonatomic, strong) UILabel *closeLabel;

/** 浮动 */
@property (nonatomic, strong) UILabel *floatLabel;

/** 额度 */
@property (nonatomic, strong) UILabel *numLabel;

/** 时间 */
@property (nonatomic, strong) UILabel *timeLabel;

@end
@implementation SEKLineHPLCItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubViews];
       // [self ddddd];
    }
    return self;
}

- (void)ddddd {
    
    self.numLabel.text = @"343434343";
    self.floatLabel.text = @"23.3434343";
    self.timeLabel.text = @"23.3434343";

}
- (void)addSubViews {
    
    // 开
    self.openLabel = [UILabel creatLabelWithTextColor:GaryTextColor font:TextFontWithSize(9)];
    [self addSubview:_openLabel];
    
    [_openLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HorMargin);
        make.top.mas_equalTo(8);
        make.height.mas_equalTo(8);
    }];
    
    
    // 高
    self.highLabel = [UILabel creatLabelWithTextColor:GaryTextColor font:TextFontWithSize(9)];
    [self addSubview:_highLabel];
    
    [_highLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_openLabel.mas_right);
        make.top.height.width.mas_equalTo(_openLabel);
    }];
    
    
    
    // 低
    self.lowLabel = [UILabel creatLabelWithTextColor:GaryTextColor font:TextFontWithSize(9)];
    [self addSubview:_lowLabel];
    
    [_lowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_highLabel.mas_right);
        make.top.height.width.mas_equalTo(_openLabel);

    }];
    
    // 收
    self.closeLabel = [UILabel creatLabelWithTextColor:GaryTextColor font:TextFontWithSize(9)];
    [self addSubview:_closeLabel];
    
    [_closeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lowLabel.mas_right);
        make.top.width.height.mas_equalTo(_openLabel);
        make.right.mas_equalTo(-HorMargin);
    }];
    
    
    // 浮动
    self.floatLabel = [UILabel creatLabelWithTextColor:GaryTextColor font:TextFontWithSize(9)];
    [self addSubview:_floatLabel];
    
    [_floatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.left.mas_equalTo(_openLabel);
        make.bottom.mas_equalTo(-8);
        
    }];
    
    // 额度
    self.numLabel = [UILabel creatLabelWithTextColor:GaryTextColor font:TextFontWithSize(9)];
    [self addSubview:_numLabel];
    
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.mas_equalTo(_highLabel);
        make.bottom.mas_equalTo(_floatLabel);
    }];
    
    //时间
    self.timeLabel = [UILabel creatLabelWithTextColor:BlackTextColor font:TextFontWithSize(9)];
    [self addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.mas_equalTo(_lowLabel);
        make.bottom.mas_equalTo(_floatLabel);
    }];
}


#pragma mark --
- (void)setModel:(LQCandleModel *)model {
    
    // 高
    NSString *highStr = [NSString stringWithFormat:@"高 %.7f",model.High];
    self.highLabel.attributedText = [self attributedStringWithS:highStr color:BlackTextColor];
    
    // 开
    NSString *openStr = [NSString stringWithFormat:@"开 %.7f",model.Open];
    self.openLabel.attributedText = [self attributedStringWithS:openStr color:BlackTextColor];
    
    // 低
    NSString *lowStr = [NSString stringWithFormat:@"低 %.7f",model.Low];
    self.lowLabel.attributedText = [self attributedStringWithS:lowStr color:BlackTextColor];
    
    // 收
    NSString *closeStr = [NSString stringWithFormat:@"收 %.7f",model.Close];
    self.closeLabel.attributedText = [self attributedStringWithS:closeStr color:BlackTextColor];
    
    NSString *amount = [NSString stringWithFormat:@"额 %0.7f",model.dealMoney];
    self.numLabel.attributedText = [self attributedStringWithS:amount color:BlackTextColor];
    self.timeLabel.text = [ToolClass stringWithTimestamp:[NSString stringWithFormat:@"%f",[model.date floatValue] ] dateFormat:@"yyyy-MM-dd HH:mm"];
}

- (NSMutableAttributedString *)attributedStringWithS:(NSString *)string color:(UIColor *)color {
 
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    [attString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(2, string.length - 2)];
    
    return attString;

}
@end
