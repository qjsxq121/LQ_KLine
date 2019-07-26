//
//  SEConstant.h
//  Exchange
//
//  Created by lq on 2018/6/21.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import <UIKit/UIKit.h>


/** 横向边距 */
UIKIT_EXTERN CGFloat const HorMargin;


/**浮动的圆角 */
UIKIT_EXTERN CGFloat const FloatRadius;

/** 线的高度 */
UIKIT_EXTERN CGFloat const LineHeight;


/** 字体间距   */
UIKIT_EXTERN  CGFloat const kLineSpacing;

/** 委托订单 最新成交 的Cell 的高度 */
UIKIT_EXTERN CGFloat const kEntrustDealViewCellHeight;

/** 委托订单 最新成交 的topView 的高度 */
UIKIT_EXTERN CGFloat const kEntrustDealTopViewHeight;

/** 登录注册模块 的边距 */
UIKIT_EXTERN CGFloat const kLoginRegMargin;





#pragma mark -- 通知
/** 登录注册成功 刷新我的信息的通知 */
UIKIT_EXTERN NSString * const RefreshMyInfoNotification;


/** 用户没有登录的通知 */
UIKIT_EXTERN NSString * const UserNOLoginNOtification;


/** 自选更新的通知 */
UIKIT_EXTERN NSString *const MyOptionalRefreshNotification;


/** 选择交易币 */
UIKIT_EXTERN NSString *const SelectDealCoinNotification;

/** 点击买入的通知 */
UIKIT_EXTERN NSString *const ClickBuyNotification;

/** 点击首页跳转市场BTC */
UIKIT_EXTERN NSString *const ClickMoreToMarketNotification;
