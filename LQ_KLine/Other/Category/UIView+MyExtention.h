//
//  ViewController.m
//  解锁
//
//  Created by lq on 2015/6/4.
//  Copyright © 2015年 lq. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LQCustomMake(x,y,width,height) CGRectForFit(    CGRectMake(x, y, width, height))

CGRect CGRectForFit(CGRect rect) ;
@interface UIView (MyExtention)
@property (nonatomic, assign)CGSize lq_size;

@property (nonatomic, assign)CGFloat lq_width;
@property (nonatomic, assign)CGFloat lq_height;
@property (nonatomic, assign)CGFloat lq_x;
@property (nonatomic, assign)CGFloat lq_y;
@property (nonatomic, assign)CGFloat lq_centerX;
@property (nonatomic, assign)CGFloat lq_centerY;
@property (nonatomic, assign)CGFloat lq_right;
@property (nonatomic, assign)CGFloat lq_bottom;
- (void)fitIphone6:(int)i ;

- (void)setCornerOnTop:(CGFloat) conner;

- (void)setCornerOnBottom:(CGFloat) conner;

- (void)setCornerOnLeft:(CGFloat) conner;

- (void)setCornerOnRight:(CGFloat) conner;

- (void)setAllCorner:(CGFloat) conner;
-(BOOL)intersectWithView:(UIView *)view;

@end
