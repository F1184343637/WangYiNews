//
//  CJHTTPSessionManager.m
//  Together
//
//  Created by 程建 on 16/9/9.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import "CJHTTPSessionManager.h"

@implementation CJHTTPSessionManager

+ (instancetype)sharedSessionManager{

    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        instance = [self manager];
    
    });

    return instance;
}


@end
