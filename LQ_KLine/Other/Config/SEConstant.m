//
//  SEConstant.m
//  Exchange
//
//  Created by lq on 2018/6/21.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import "SEConstant.h"

/** 横向边距 */
CGFloat const HorMargin = 15;


/**浮动的圆角 */
CGFloat const FloatRadius = 3.0;

/** 线的高度 */
CGFloat const LineHeight = 1.0;

/** 字体间距   */
CGFloat const kLineSpacing = 5.0;

/** 委托订单 最新成交 的Cell 的高度 */
CGFloat const kEntrustDealViewCellHeight = 30;

/** 委托订单 最新成交 的topView 的高度 */
CGFloat const kEntrustDealTopViewHeight = 30;


/** 登录注册模块 的边距 */
CGFloat const kLoginRegMargin = 40;






#pragma mark -- 通知
/** 登录 注册 刷新我的信息的通知 */
NSString * const RefreshMyInfoNotification = @"RefreshMyInfoNotification";

NSString * const UserNOLoginNOtification = @"UserNOLoginNOtification";

/** 自选更新的通知 */
NSString *const MyOptionalRefreshNotification = @"MyOptionalRefreshNotification";

/** 选择交易币 */
NSString *const SelectDealCoinNotification = @"SelectDealCoinNotification";


/** 点击买入的通知 */
NSString *const ClickBuyNotification = @"ClickBuyNotification";


/** 点击首页跳转市场BTC */
NSString *const ClickMoreToMarketNotification = @"ClickMoreToMarketNotification";
