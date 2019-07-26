//
//  SEPopViewCell.m
//  Exchange
//
//  Created by lq on 2018/6/25.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import "SEPopViewCell.h"

@implementation SEPopViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.backgroundColor = CyanBackgroundColor;
        self.contentLabel = [UILabel creatLabelWithTextColor:UIColorHex(#666666) font:TextFontWithSize(11)];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(12);
            make.centerY.mas_equalTo(self);
        }];
        
        UIView *bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = UIColorHex(#E1E7EB);
        [self addSubview:bottomLineView];
        
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(LineHeight);
        }];
        
    }
    
    return self;
}
@end
