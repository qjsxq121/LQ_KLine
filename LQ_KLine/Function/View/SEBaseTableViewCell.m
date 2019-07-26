//
//  SEBaseTableViewCell.m
//  Exchange
//
//  Created by lq on 2018/6/22.
//  Copyright © 2018年 2SE. All rights reserved.
//

#import "SEBaseTableViewCell.h"

@implementation SEBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = WhiteBackGroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
@end
