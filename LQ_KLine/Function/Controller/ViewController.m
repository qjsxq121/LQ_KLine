//
//  ViewController.m
//  LQ_KLine
//
//  Created by lq on 2019/6/16.
//  Copyright © 2019年 2SE. All rights reserved.
//

#import "ViewController.h"
#import "SEMarketDetailVController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SEMarketDetailVController *marketDetailVC = [[SEMarketDetailVController alloc] init];
    [self.navigationController pushViewController:marketDetailVC animated:YES];
}

@end
