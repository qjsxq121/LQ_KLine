//
//  SEFullIndexView.h
//  Exchange
//
//  Created by lq on 2018/7/3.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SEFullIndexViewDelegate <NSObject>

- (void)selectIndexWithBtnTitle:(NSString *)title;

@end
@interface SEFullIndexView : UIView

@property (nonatomic, weak) id <SEFullIndexViewDelegate> delegate;
@end
