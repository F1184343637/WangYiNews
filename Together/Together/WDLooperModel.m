//
//  WDLooperModel.m
//  Together
//
//  Created by 王迪 on 16/9/9.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import "WDLooperModel.h"
#import "CJHTTPSessionManager.h"

@implementation WDLooperModel

+ (instancetype)modelWithDict:(NSDictionary *)dict  {
    
    WDLooperModel *model = [[WDLooperModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

-(NSString *)description{
    //自定义输出
    return [NSString stringWithFormat:@"%@{title = %@,imgSrc = %@}",[super description],self.title,self.imgsrc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

+ (void)getModelArrayWithCompleteBlock:(void(^)(NSArray *array))comBlock andErrorBlock:(void(^)())errorBlock {
    
    CJHTTPSessionManager *manager = [CJHTTPSessionManager manager];
    
    [manager GET:@"http://c.m.163.com/nc/ad/headline/0-4.html" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nonnull responseObject) {
    
        NSString *firstKey = responseObject.keyEnumerator.nextObject;
        
        NSArray *jsonArray = responseObject[firstKey];
        
        NSMutableArray *nmArr = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [nmArr addObject:[WDLooperModel modelWithDict:obj]];
        }];
        
        if (comBlock) {
            comBlock(nmArr.copy);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (errorBlock) {
            errorBlock();
        }
    }];
    
}

@end
