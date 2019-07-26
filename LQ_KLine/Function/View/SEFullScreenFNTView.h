//
//  SEFullScreenFNTView.h
//  Exchange
//
//  Created by lq on 2018/7/3.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SESuperMarketModel.h"
@protocol SEFullScreenFNTViewDelegate <NSObject>

- (void)closeFullScreen;
@end
@interface SEFullScreenFNTView : UIView

@property (nonatomic, weak) id <SEFullScreenFNTViewDelegate> delegate;

- (void)setUIWith:(SESuperMarketModel *)model baseCoin:(NSString *)base;

@end
