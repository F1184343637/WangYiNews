//
//  CJHTTPSessionManager.h
//  Together
//
//  Created by 程建 on 16/9/9.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface CJHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedSessionManager;

@end
