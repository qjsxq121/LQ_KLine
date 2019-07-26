//
//  LQSmallDepthView.h
//  Exchange
//
//  Created by lq on 2018/8/3.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import "LQBaseKLineView.h"
@class DepthGroupModel;

@interface LQSmallDepthView : LQBaseKLineView
/** 数据 */
@property (nonatomic, strong) DepthGroupModel *groupModel;

- (void)stockFill;
@end
