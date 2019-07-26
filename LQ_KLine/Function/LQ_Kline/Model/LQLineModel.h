//
//  LQLineModel.h
//  LQ_KLine
//
//  Created by lq on 2018/6/15.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQLineModel : NSObject

/** x位置 */
@property (nonatomic, assign) CGFloat xPosition;

/** y位置 */
@property (nonatomic, assign) CGFloat yPosition;


+ (instancetype)initPositionX:(CGFloat)xPosition yPosition:(CGFloat)yPosition;


@end
