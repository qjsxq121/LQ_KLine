//
//  LQImageAtRightButton.m
//  BFGP
//
//  Created by lq on 2017/9/28.
//  Copyright © 2017年 bfgp. All rights reserved.
//
/** button 图片靠右 文字靠在*/

#import "LQImageAtRightButton.h"
@interface LQImageAtRightButton ()

/** 图片和文字之间的距离 */
@property (nonatomic, assign) CGFloat margin;

@end
@implementation LQImageAtRightButton

- (instancetype)initWithMargin:(CGFloat)margin {
    if (self = [super init]) {
        
        self.margin = margin;
    }
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame WithMargin:(CGFloat)margin {
    if (self = [super initWithFrame:frame]) {
        self.margin = margin;
    }
    
    return self;
}
- (void)layoutSubviews {
   
    [super layoutSubviews];
    CGRect titleF = self.titleLabel.frame;
    CGRect imageF = self.imageView.frame;
   // titleF.origin.x = 0;
  
    // 图片和 title 之间的距离
    CGFloat margin = self.margin;
    
    if (self.margin == 0) {
        margin = 2;
    }
    // 为了让 图片和title 整体剧中
    titleF.origin.x = (self.frame.size.width - titleF.size.width - margin - imageF.size.width) / 2;
      self.titleLabel.frame = titleF;
    imageF.origin.x = CGRectGetMaxX(self.titleLabel.frame) + margin;
    self.imageView.frame = imageF;
}


- (void)setHighlighted:(BOOL)highlighted{
    
}

@end
