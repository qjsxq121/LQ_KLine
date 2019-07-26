//
//  SEFullScreenKTimeSelectView.m
//  Exchange
//
//  Created by lq on 2018/7/3.
//  Copyright © 2018年 2SE. All rights reserved.
//
// 全屏 k线时间选择view
#import "SEFullScreenKTimeSelectView.h"
#import "XTPopView.h"

@interface SEFullScreenKTimeSelectView ()<SelectIndexPathDelegate>

/** 小时选择 */
@property (nonatomic, strong) LQImageAtRightButton *hourSelectBtn;

/** 分钟选择按钮 */
@property (nonatomic, strong) LQImageAtRightButton *minuteSelectBtn;

/** selectBtn */
@property (nonatomic, strong) UIButton *selectBtn;


/** 小时item的title */
@property (nonatomic, strong) NSArray *hourItemTitleArray;



/** 分钟item的title */
@property (nonatomic, strong) NSArray *minuteItemTitleArray;


/** time */
@property (nonatomic, copy) NSString *timeTitle;

@end
@implementation SEFullScreenKTimeSelectView

- (instancetype)initWithFrame:(CGRect)frame withTime:(NSString *)timeTitle {
    if (self = [super initWithFrame:frame]) {
        
        self.timeTitle = timeTitle;
        self.hourItemTitleArray = @[@"1小时",@"2小时",@"4小时",@"6小时",@"12小时"];
        self.minuteItemTitleArray = @[@"1分",@"5分",@"15分",@"30分"];
        [self addSubviews];
        
    }
    return self;
}

- (void)addSubviews {
    
    // 分时
    UIButton *timeButton = [self createBtnWithTitle:@"分时"];
    
    if ([_timeTitle isEqualToString:@"分时"]) {
        timeButton.selected = YES;
        self.selectBtn = timeButton;
    }
    timeButton.tag = 10;
    [self addSubview:timeButton];
    
    [timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
    }];
    
    // 日线
    UIButton *dayBtn = [self createBtnWithTitle:@"日线"];
    if ([_timeTitle isEqualToString:@"日线"]) {
        dayBtn.selected = YES;
        self.selectBtn = dayBtn;
    }
    dayBtn.tag = 11;
    [self addSubview:dayBtn];
    
    [dayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(timeButton.mas_right);
        make.top.bottom.width.mas_equalTo(timeButton);
    }];
    
    // 周线
    UIButton *weekBtn = [self createBtnWithTitle:@"周线"];
    if ([_timeTitle isEqualToString:@"周线"]) {
        weekBtn.selected = YES;
        self.selectBtn = weekBtn;
    }
    weekBtn.tag = 12;
    [self addSubview:weekBtn];
    
    [weekBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dayBtn.mas_right);
        make.top.bottom.width.mas_equalTo(timeButton);
    }];
    
    //小时
    self.hourSelectBtn = [self createImageAtRightBtnWithTitle:@"小时"];
    if ([self.hourItemTitleArray containsObject:_timeTitle]) {
        self.hourSelectBtn.selected = YES;
        [self.hourSelectBtn setTitle:_timeTitle forState:UIControlStateSelected];
        self.selectBtn = self.hourSelectBtn;
    }
    self.hourSelectBtn.tag = 13;
    [self.hourSelectBtn addTarget:self action:@selector(clickHourBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_hourSelectBtn];
    
    [_hourSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weekBtn.mas_right);
        make.top.bottom.width.mas_equalTo(timeButton);
    }];
    
    // 分钟
    self.minuteSelectBtn = [self createImageAtRightBtnWithTitle:@"分钟"];
    if ([self.minuteItemTitleArray containsObject:_timeTitle]) {
        self.minuteSelectBtn.selected = YES;
        [self.minuteSelectBtn setTitle:_timeTitle forState:UIControlStateSelected];
        self.selectBtn = self.minuteSelectBtn;
    }
    self.minuteSelectBtn.tag = 14;
    [self.minuteSelectBtn addTarget:self action:@selector(clickMinuteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_minuteSelectBtn];
    
    [_minuteSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_hourSelectBtn.mas_right);
        make.top.bottom.width.mas_equalTo(timeButton);
        make.right.mas_equalTo(0);
    }];
}


// 创建普通button
- (UIButton *)createBtnWithTitle:(NSString *)title {
    UIButton *button = [UIButton creatButtonWithTitle:title normalTitleColor:BlackTextColor font:TextFontWithSize(15)];
    [button setTitleColor:SelectedColor forState:UIControlStateSelected];
    [button addTarget:self action:@selector(clickNormalBtn:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


// 创建图片在右边的button
- (LQImageAtRightButton *)createImageAtRightBtnWithTitle:(NSString *)title {
    LQImageAtRightButton *button = [[LQImageAtRightButton alloc] initWithMargin:5];
    [button setTitleColor:SelectedColor forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"deal_down"] forState:UIControlStateNormal];
    [button setTitleColor:BlackTextColor forState:UIControlStateNormal];
    [button.titleLabel setFont:TextFontWithSize(15)];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}


#pragma mark -- 点击事件

// 点击 分时 日线 周线
- (void)clickNormalBtn:(UIButton *)button {
    
//    if (button.tag == 10) {
//        [MYProgressHUD showBlackBackgroundColorTitle:@"该功能没有开放" hudInView:APPDelegate.window];
//        return;
//    }
    self.selectBtn.selected = NO;
    button.selected = YES;
    self.selectBtn = button;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectKlineTimeWithType:)]) {
        switch (button.tag) {
            case 10:
                [self.delegate selectKlineTimeWithType:KLineTimeTypeTimeShare];
                break;
            case 11:
                [self.delegate selectKlineTimeWithType:KLineTimeTypeDay];

                break;
            case 12:
                [self.delegate selectKlineTimeWithType:KLineTimeTypeWeek];

                break;
            default:
                break;
        }
    }
}
// 点击小时选择
- (void)clickHourBtn:(LQImageAtRightButton *)button {
    
    [UIView animateWithDuration:0.2 animations:^{
        button.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    NSArray *titleArr = self.hourItemTitleArray;
    CGFloat rowHeight = 32;
    CGFloat itemWidth = self.lq_width / 5;
    CGPoint point = CGPointMake(itemWidth * 3.5, SCREEN_HEIGHT - self.lq_height + 5);
    XTPopTableView *popView = [[XTPopTableView alloc] initWithOrigin:point Width:70 Height:rowHeight * titleArr.count Type:XTTypeOfDownCenter Color:CyanBackgroundColor];
    popView.dataArray = titleArr;
    popView.row_height = rowHeight;
    popView.delegate  = self;
    [popView popView];
}

// 点击分钟选择
- (void)clickMinuteBtn:(LQImageAtRightButton *)button {
    [UIView animateWithDuration:0.2 animations:^{
        button.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    
    CGFloat rowHeight = 32;
    CGFloat itemWidth = self.lq_width / 5;
    CGPoint point = CGPointMake(itemWidth * 4.5, SCREEN_HEIGHT - self.lq_height + 5);
    XTPopTableView *popView = [[XTPopTableView alloc] initWithOrigin:point Width:70 Height:rowHeight * self.minuteItemTitleArray.count Type:XTTypeOfDownCenter Color:CyanBackgroundColor];
    popView.dataArray = self.minuteItemTitleArray;
    popView.row_height = rowHeight;
    popView.delegate  = self; 
    [popView popView];
}

#pragma mark -- SelectIndexPathDelegate
- (void)selectIndexWithText:(NSString *)title row:(NSInteger)row {
    if ([self.hourItemTitleArray containsObject:title]) { // 选择的小时
       
        [self.hourSelectBtn setTitle:title forState:UIControlStateSelected];
        if (self.selectBtn.tag != self.hourSelectBtn.tag) {
            self.selectBtn.selected = NO;
            self.hourSelectBtn.selected = YES;
            self.selectBtn = self.hourSelectBtn;
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectKlineTimeWithType:)]) {
            switch (row) {
                case 0:
                    [self.delegate selectKlineTimeWithType:KLineTimeTypeOneHour];
                    break;
                case 1:
                    [self.delegate selectKlineTimeWithType:KLineTimeTypeTwoHour];

                    break;
                case 2:
                    [self.delegate selectKlineTimeWithType:KLineTimeTypeFourHour];

                    break;
                case 3:
                    [self.delegate selectKlineTimeWithType:KLineTimeTypeSixHour];

                    break;
                case 4:
                    [self.delegate selectKlineTimeWithType:KLineTimeTypeTwelveHour];

                    break;
                default:
                    break;
            }
        }
       
    } else {  // 分钟选择
        
        
        
        [self.minuteSelectBtn setTitle:title forState:UIControlStateSelected];
        
        
        if (self.selectBtn.tag != self.minuteSelectBtn.tag) {
            self.selectBtn.selected = NO;
            self.minuteSelectBtn.selected = YES;
            self.selectBtn = self.minuteSelectBtn;
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectKlineTimeWithType:)]) {
            switch (row) {
                case 0:
                    [self.delegate selectKlineTimeWithType:KLineTimeTypeOneMinute];
                    break;
                case 1:
                    [self.delegate selectKlineTimeWithType:KLineTimeTypeFiveMinute];
                    
                    break;
                case 2:
                    [self.delegate selectKlineTimeWithType:KLineTimeTypeFifteenMinute];
                    
                    break;
                case 3:
                    [self.delegate selectKlineTimeWithType:KLineTimeTypeThirtyMinute];
                    
                    break;
                
                default:
                    break;
            }
        }
    }
    
    [self popViewDismiss];
}

- (void)popViewDismiss {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.hourSelectBtn.imageView.transform = CGAffineTransformMakeRotation(0);
        self.minuteSelectBtn.imageView.transform = CGAffineTransformMakeRotation(0);

    }];
    
    
}
@end
