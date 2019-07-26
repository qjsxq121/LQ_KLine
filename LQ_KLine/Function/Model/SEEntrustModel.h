//
//  SEEntrustModel.h
//  Exchange
//
//  Created by lq on 2018/6/28.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SEEntrustModel : NSObject

/** 价格 */
@property (nonatomic, assign) double Price;

/** 数量 */
@property (nonatomic, assign) double Amount;

/** type */
@property (nonatomic, copy) NSString *Type;
// 0 增加  1 删除  2 更新



/////////////////////
/** 背景占比 */
@property (nonatomic, assign) CGFloat scale;
@end
