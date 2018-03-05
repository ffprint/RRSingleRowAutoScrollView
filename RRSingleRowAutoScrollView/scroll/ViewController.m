//
//  ViewController.m
//  scroll
//
//  Created by enway on 2017/11/15.
//  Copyright © 2017年 Enway. All rights reserved.
//

#import "ViewController.h"
#import "RRScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    RRScrollView *scr = [[RRScrollView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 40)];
    NSArray *array = @[@"参考频道大升级",@"为什么苦口婆心劝,你不要提前还房贷!",@"要是能重来,我要选李白",@"话题:你的王者荣耀分段为什么这么低?",@"基金定投是坏主意吗?",@"怎么降低投资风险,支你一招",@"给阿姨倒一杯卡布奇诺"];
    scr.contentArray = array;
    //点击事件
    [scr contentTag:^(long tag) {
        NSLog(@"%ld",tag);
    }];
    [self.view addSubview:scr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
