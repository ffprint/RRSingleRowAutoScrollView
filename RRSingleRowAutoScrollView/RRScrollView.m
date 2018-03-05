//
//  RRScrollView.m
//  scroll
//
//  Created by enway on 2017/11/15.
//  Copyright © 2017年 Enway. All rights reserved.
//

#import "RRScrollView.h"


@interface RRScrollView()<UIScrollViewDelegate>{
    NSTimeInterval _interval;
}

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSMutableArray *mutArray;

@end

@implementation RRScrollView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = false;
        self.showsVerticalScrollIndicator = false;
        self.delegate = self;
        self.pagingEnabled = true;
        _interval = 2;
    }
    return self;
}
-(void)setContentArray:(NSArray *)contentArray {
    self.mutArray = [NSMutableArray arrayWithArray:contentArray];
    [self.mutArray addObject:contentArray.firstObject];
    [self.mutArray insertObject:contentArray.lastObject atIndex:0];
    self.contentSize = CGSizeMake(0, self.mutArray.count * self.frame.size.height);
    self.contentOffset = CGPointMake(0, self.frame.size.height);//
    [self setSubViews:self.mutArray];
}
-(void)setSubViews:(NSMutableArray *)mutArray {
    for (int i = 0; i < mutArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, i*self.frame.size.height, self.frame.size.width, self.frame.size.height);
        button.backgroundColor = [UIColor grayColor];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.textColor = [UIColor blackColor];
        [button setTitle:mutArray[i] forState:UIControlStateNormal];
        button.tag = i+10;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    [self AutoScroll];
}

-(void)buttonAction:(UIButton *)button{
    _buttontagBlock(button.tag - 10);
}

-(void)contentTag:(ButtonTagBlock)block {
    _buttontagBlock = block;
}

//自动滚动
-(void)AutoScroll {
    self.timer = [NSTimer timerWithTimeInterval:_interval target:self selector:@selector(scroll) userInfo:nil repeats:true];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}
-(void)scroll {
    [self setContentOffset:CGPointMake(0, self.contentOffset.y + self.frame.size.height) animated:YES];
}

//停止自动滚动
-(void)StopAutoScroll {
    [self.timer invalidate];
    self.timer = nil;
}
//拖拽,停止自动滚动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self StopAutoScroll];
}
//拖拽结束,回复自动滚动
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self AutoScroll];
}
//每次滑动结束(注意:setContentOffset:animated:中animated设置为NO时不调用)
//停止滚动动画时触发
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self adjustScrollViewContent];
}
//拖拽结束的滑动完毕调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self adjustScrollViewContent];
}
//每次调整展示内容
-(void)adjustScrollViewContent {
    NSInteger currentPage = (self.contentOffset.y + self.frame.size.height)/self.frame.size.height;
    if (currentPage == 1) {//第一页
        [self setContentOffset:CGPointMake(0, (self.mutArray.count-1) * self.frame.size.height) animated:NO];
    }else if (currentPage == self.mutArray.count){
        [self setContentOffset:CGPointMake(0, self.frame.size.height) animated:NO];
    }
}

@end
