//
//  HMLabel.h
//  Together
//
//  Created by 刘宗飞 on 16/9/10.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMLabel : UILabel

//提供文字的显示颜色变红等等,返回label

@property (nonatomic,assign)CGFloat scale;

+ (instancetype)tiGong:(NSString *)name;


@end
