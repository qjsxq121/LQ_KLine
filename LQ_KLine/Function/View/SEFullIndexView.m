//
//  SEFullIndexView.m
//  Exchange
//
//  Created by lq on 2018/7/3.
//  Copyright © 2018年 2SE. All rights reserved.
//
// 全屏时指标view
#import "SEFullIndexView.h"
@interface SEFullIndexView ()

/** 选中的btn */
@property (nonatomic, strong) UIButton *selectBtn;
@end
@implementation SEFullIndexView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addsubViews];
    }
    return self;
}

#pragma mark -- 添加子控件
- (void)addsubViews {
    
    // SMA
    UIButton *SMABtn = [self creatButtonWititle:@"SMA"];
    [SMABtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    SMABtn.selected = YES;
    self.selectBtn = SMABtn;
    [self addSubview:SMABtn];
    [SMABtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
    }];
    
    //EMA
    UIButton *EMABtn = [self creatButtonWititle:@"EMA"];
    [EMABtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:EMABtn];
    [EMABtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(SMABtn);
        make.top.mas_equalTo(SMABtn.mas_bottom);
        
    }];
    //BOLL
    UIButton *BOLLBtn = [self creatButtonWititle:@"BOLL"];
    [BOLLBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:BOLLBtn];
    [BOLLBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(SMABtn);
        make.top.mas_equalTo(EMABtn.mas_bottom);
    }];


    //VOL
    UIButton *VOLBtn = [self creatButtonWititle:@"VOL"];
    [VOLBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:VOLBtn];
    [VOLBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(SMABtn);
        make.top.mas_equalTo(BOLLBtn.mas_bottom);

    }];
//

    //MACD
    UIButton *MACDBtn = [self creatButtonWititle:@"MACD"];
    [MACDBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:MACDBtn];
    [MACDBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(SMABtn);
        make.top.mas_equalTo(VOLBtn.mas_bottom);

    }];
    
    
    //KDJ
    UIButton *KDJBtn = [self creatButtonWititle:@"KDJ"];
    [KDJBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:KDJBtn];
    [KDJBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(SMABtn);
        make.top.mas_equalTo(MACDBtn.mas_bottom);

    }];


    //RSI
    UIButton *RSIBtn = [self creatButtonWititle:@"RSI"];
    [RSIBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:RSIBtn];
    [RSIBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(SMABtn);
        make.top.mas_equalTo(KDJBtn.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    
}

- (UIButton *)creatButtonWititle:(NSString *)title {
    UIButton *button = [UIButton creatButtonWithTitle:title normalTitleColor:BlackTextColor font:TextFontWithSize(11)];
    [button setTitleColor:SelectedColor forState:UIControlStateSelected];
    
    return button;
}

#pragma mark -- btn点击事件
- (void)clickBtn:(UIButton *)button {
    
    if ([button.titleLabel.text isEqualToString:self.selectBtn.titleLabel.text]) {
        return;
    }
    self.selectBtn.selected = NO;
    button.selected = YES;
    self.selectBtn = button;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectIndexWithBtnTitle:)]) {
        [self.delegate selectIndexWithBtnTitle:button.titleLabel.text];
    }
}
@end
