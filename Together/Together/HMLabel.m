//
//  HMLabel.m
//  Together
//
//  Created by 刘宗飞 on 16/9/10.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import "HMLabel.h"

#define kSmall 15
#define kBig 18


@implementation HMLabel

+ (instancetype)tiGong:(NSString *)name{
    
    HMLabel *label  = [[HMLabel alloc]init];
    label.tintColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:kBig];
    label.text = name;
    [label setTextAlignment:NSTextAlignmentCenter];
    [label sizeToFit];//此句计算出了label的宽
    label.font = [UIFont systemFontOfSize:kSmall];
    //设置用户交互
    label.userInteractionEnabled = YES;
    
    return label;
}

- (void)setScale:(CGFloat)scale{
    
    CGFloat max = 0.2;
    [self setTextColor:[UIColor colorWithRed:scale green:0 blue:0 alpha:1]];
    self.transform = CGAffineTransformMakeScale(max * scale + 1, max * scale + 1);
}



@end
