//
//  ViewController.m
//  解锁
//
//  Created by lq on 2015/6/4.
//  Copyright © 2015年 lq. All rights reserved.
//


#import "UIView+MyExtention.h"
CGRect CGRectForFit(CGRect rect)
{
    CGSize size = [UIScreen mainScreen].bounds.size ;
    CGFloat scaleX = size.width / 375 ;
    CGFloat scaleY = size.height / 667 ;
    
    // newRect ： （以6为基准）i6 rect
    CGRect newRect = CGRectZero;

    
    newRect.origin.x = CGRectGetMinX(rect)*scaleX ;
    newRect.origin.y = CGRectGetMinY(rect)*scaleY ;
    newRect.size.width = CGRectGetWidth(rect)*scaleX ;
    newRect.size.height = CGRectGetHeight(rect)*scaleY;
    
    return newRect ;
}

@implementation UIView (MyExtention)
- (void)fitIphone6:(int)i
{
    if (i==1)
    {
        for (UIView *subView in self.subviews)
        {
            subView.frame = LQCustomMake(subView.frame.origin.x, subView.frame.origin.y , subView.frame.size.width, subView.frame.size.height) ;
            
        }
    }
    
    
    
    
    
    if (i==2)
    {
        for (UIView *subView in self.subviews)
        {
            subView.frame = LQCustomMake(subView.frame.origin.x, subView.frame.origin.y , subView.frame.size.width, subView.frame.size.height) ;
            
            for (UIView *subsubview in subView.subviews) {
                subsubview.frame = LQCustomMake(subsubview.frame.origin.x, subsubview.frame.origin.y , subsubview.frame.size.width, subsubview.frame.size.height) ;
            }
        }
    }
    if (i==3)
    {
        for (UIView *subView in self.subviews)
        {
            subView.frame = LQCustomMake(subView.frame.origin.x, subView.frame.origin.y , subView.frame.size.width, subView.frame.size.height) ;
            
            for (UIView *subsubview in subView.subviews) {
                subsubview.frame = LQCustomMake(subsubview.frame.origin.x, subsubview.frame.origin.y , subsubview.frame.size.width, subsubview.frame.size.height) ;
                
                for (UIView *subsubsubview in subsubview.subviews) {
                    subsubsubview.frame = LQCustomMake(subsubsubview.frame.origin.x, subsubsubview.frame.origin.y , subsubsubview.frame.size.width, subsubsubview.frame.size.height) ;
                }
            }
        }
    }
    if (i==4)
    {
        for (UIView *subView in self.subviews)
        {
            subView.frame = LQCustomMake(subView.frame.origin.x, subView.frame.origin.y , subView.frame.size.width, subView.frame.size.height) ;
            
            for (UIView *subsubview in subView.subviews) {
                subsubview.frame = LQCustomMake(subsubview.frame.origin.x, subsubview.frame.origin.y , subsubview.frame.size.width, subsubview.frame.size.height) ;
                
                for (UIView *subsubsubview in subsubview.subviews) {
                    subsubsubview.frame = LQCustomMake(subsubsubview.frame.origin.x, subsubsubview.frame.origin.y , subsubsubview.frame.size.width, subsubsubview.frame.size.height) ;
                    for (UIView *subsubsubsubview in subsubsubview.subviews) {
                        subsubsubsubview.frame = LQCustomMake(subsubsubsubview.frame.origin.x, subsubsubsubview.frame.origin.y , subsubsubsubview.frame.size.width, subsubsubview.frame.size.height) ;
                    }

                }
            }
        }
    }

    
}

- (CGSize)lq_size {
    return self.frame.size;
}

- (void)setLq_size:(CGSize)lq_size {
    CGRect frame = self.frame;
    frame.size = lq_size;
    self.frame = frame;
    
}

- (CGFloat)lq_width {
    return self.frame.size.width;
    
}

- (CGFloat)lq_height {
    return self.frame.size.height;
}

- (void)setLq_width:(CGFloat)lq_width {
    CGRect frame = self.frame;
    frame.size.width = lq_width;
    self.frame = frame;
    
}

- (void)setLq_height:(CGFloat)lq_height{
    CGRect frame = self.frame;
    frame.size.height = lq_height;
    self.frame = frame;
    
}
- (CGFloat)lq_x {
    return self.frame.origin.x;
}

- (void)setLq_x:(CGFloat)lq_x {
    CGRect frame = self.frame;
    frame.origin.x = lq_x;
    self.frame = frame;
    
}
- (CGFloat)lq_y {
    return self.frame.origin.y;
}

- (void)setLq_y:(CGFloat)lq_y{
    CGRect frame = self.frame;
    frame.origin.y = lq_y;
    self.frame = frame;
    
}
- (CGFloat)lq_centerX {
   return self.center.x;
}
- (void)setLq_centerX:(CGFloat)lq_centerX {
    CGPoint center = self.center;
    center.x = lq_centerX;
    self.center = center;
}
- (CGFloat)lq_centerY {
    return self.center.y;
}
- (void)setLq_centerY:(CGFloat)lq_centerY {
    CGPoint center = self.center;
    center.y = lq_centerY;
    self.center = center;
}
- (CGFloat) lq_right {
    return self.lq_x + self.lq_width;
//    return CGRectGetMaxY(self.frame);
}
- (CGFloat)lq_bottom {
    return self.lq_y +self.lq_height;
//    return CGRectGetMaxY(self.frame);
    
}
- (void)setLq_right:(CGFloat)lq_right {
    self.lq_x = lq_right - self.lq_width;
}


- (void)setLq_bottom:(CGFloat)lq_bottom {
    
    self.lq_y = lq_bottom - self.lq_height;
}



-(BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    CGRect newRect = [self convertRect:self.bounds toView:window];
    CGRect newView = [view convertRect:view.bounds toView:window];
    
    return CGRectIntersectsRect(newRect, newView);
}

#pragma mark --  设置圆角


- (void)setCornerOnTop:(CGFloat) conner {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                           cornerRadii:CGSizeMake(conner, conner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)setCornerOnBottom:(CGFloat) conner {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                           cornerRadii:CGSizeMake(conner, conner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)setCornerOnLeft:(CGFloat) conner {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                           cornerRadii:CGSizeMake(conner, conner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)setCornerOnRight:(CGFloat) conner {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                           cornerRadii:CGSizeMake(conner, conner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


- (void)setAllCorner:(CGFloat) conner {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                          cornerRadius:conner];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}



@end
