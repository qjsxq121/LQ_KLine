//
//  LQBaseKLineView.h
//  LQ_KLine
//
//  Created by lq on 2018/6/15.
//  Copyright © 2018年 YiYoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQBaseKLineView : UIView

/** 最大y值 */
@property (nonatomic, assign) CGFloat kl_maxY;

/** 最小y值 */
@property (nonatomic, assign) CGFloat kl_minY;

/** 最大x值 */
@property (nonatomic, assign) CGFloat kl_maxX;

/** 最小x值 */
@property (nonatomic, assign) CGFloat kl_minX;

/** y方向缩放比 */
@property (nonatomic, assign) CGFloat kl_scaleY;

/** x方向缩放比 */
@property (nonatomic, assign) CGFloat kl_scaleX;


/** k线宽度 */
@property (nonatomic, assign) CGFloat kl_lineWidth;

/** k线间距 */
@property (nonatomic, assign) CGFloat kl_lineSpace;

/** 左边边距 */
@property (nonatomic, assign) CGFloat kl_leftMargin;

/** 右边的边距 */
@property (nonatomic, assign) CGFloat kl_rightMargin;

/** 上面的边距 */
@property (nonatomic, assign) CGFloat kl_topMargin;

/** 底部的边距 */
@property (nonatomic, assign) CGFloat kl_bottomMargin;


@end
