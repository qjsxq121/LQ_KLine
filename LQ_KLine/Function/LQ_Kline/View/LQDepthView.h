//
//  LQDepthView.h
//  LQ_KLine
//
//  Created by lq on 2018/7/23.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import "LQBaseKLineView.h"
@class DepthGroupModel;
@interface LQDepthView : LQBaseKLineView

/** 数据 */
@property (nonatomic, strong) DepthGroupModel *groupModel;



- (void)stockFill;
@end
