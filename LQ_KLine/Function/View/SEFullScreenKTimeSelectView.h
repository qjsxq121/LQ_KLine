//
//  SEFullScreenKTimeSelectView.h
//  Exchange
//
//  Created by lq on 2018/7/3.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SEFullScreenKTimeSelectViewDelegate <NSObject>
- (void)selectKlineTimeWithType:(KLineTimeType)type;
@end

@interface SEFullScreenKTimeSelectView : UIView

@property (nonatomic, weak) id <SEFullScreenKTimeSelectViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame withTime:(NSString *)timeTitle;

@end
