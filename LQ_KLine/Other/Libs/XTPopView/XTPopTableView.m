//
//  XTPopTableView.m
//  XTPopView
//
//  Created by zjwang on 16/7/7.
//  Copyright © 2016年 夏天. All rights reserved.
//

#import "XTPopTableView.h"
#import "SEPopViewCell.h"

@interface XTPopTableView ()

@property (nonatomic, strong) SEBaseTableView *tableView;

@end


NSString * const SEPopViewCellID = @"SEPopViewCellID";
@implementation XTPopTableView
- (instancetype)initWithOrigin:(CGPoint)origin Width:(CGFloat)width Height:(CGFloat)height Type:(XTDirectionType)type Color:(UIColor *)color
{
    if ([super initWithOrigin:origin Width:width Height:height Type:type Color:color]) {
        // 添加tableview
        [self.backGoundView addSubview:self.tableView];
    }
    return self;
}

#pragma mark -
- (SEBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[SEBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.backGoundView.frame.size.width, self.backGoundView.frame.size.height)];
        _tableView.dataSource = self;
        [_tableView registerClass:[SEPopViewCell class] forCellReuseIdentifier:SEPopViewCellID];
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
    }
    return _tableView;
}
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
#pragma mark -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.row_height == 0) {
        return 44;
    }else{
        return self.row_height;
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![[touches anyObject].view isEqual:self.backGoundView]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(popViewDismiss)]) {
            [self.delegate popViewDismiss];
        }
         [self removeFromSuperview];
    }
    
}
#pragma mark -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SEPopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SEPopViewCellID forIndexPath:indexPath];
    
    cell.contentLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectIndexWithText:row:)]) {
        [self.delegate selectIndexWithText:self.dataArray[indexPath.row]row:indexPath.row];
        [self removeFromSuperview];
    }
}

@end
