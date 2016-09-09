//
//  NewsModels.m
//  Together
//
//  Created by 程建 on 16/9/9.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import "NewsModels.h"
#import "CJHTTPSessionManager.h"

@implementation NewsModels

+ (instancetype)nesWithDict:(NSDictionary *)dict{

    NewsModels *models = [[NewsModels alloc]init];
    
    [models setValuesForKeysWithDictionary:dict];
    
    return models;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    
}

+ (void)nesListWithURL:(NSString *)currentURLString success:(void(^)(NSArray <NewsModels *>*))successBlock error:(void(^)())errorBlock{
    
    [[CJHTTPSessionManager sharedSessionManager]GET:currentURLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
       
         NSString *rootKey =  responseObject.keyEnumerator.nextObject;
        
        NSArray *array = responseObject[rootKey];
        
        NSMutableArray *mArray = [NSMutableArray array];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NewsModels *models = [NewsModels nesWithDict:obj];
            
            [mArray addObject:models];
        }];
        
        if(successBlock){
        
            successBlock(mArray.copy);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(errorBlock){
            
            errorBlock();
        }
        
    }];
        
    
    
}



@end
