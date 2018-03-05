//
//  RRScrollView.h
//  scroll
//
//  Created by enway on 2017/11/15.
//  Copyright © 2017年 Enway. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonTagBlock)(long tag);

@interface RRScrollView : UIScrollView

//model
@property (nonatomic,strong) NSArray *contentArray;
@property (nonatomic,copy) ButtonTagBlock buttontagBlock;

-(void)contentTag:(ButtonTagBlock)block;

@end
