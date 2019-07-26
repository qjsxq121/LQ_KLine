//
//  SEMarketFullScreenViewController.h
//  Exchange
//
//  Created by lq on 2018/7/3.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SEMarketFullScreenViewController : UIViewController

/** 交易对 */
@property (nonatomic, copy) NSString *comb;

/** 时间 */
@property (nonatomic, copy) NSString *timeStr;


/** base */
@property (nonatomic, copy) NSString *base;

/** 时间title */
@property (nonatomic, copy) NSString *timeTitle;



@end
