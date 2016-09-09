//
//  NewsModels.h
//  Together
//
//  Created by 程建 on 16/9/9.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModels : NSObject

//回复
@property (nonatomic, copy)NSNumber *replyCount;

//标题
@property (nonatomic, copy)NSString *title;

//副标题
@property (nonatomic, copy)NSString *digest;

//图片
@property (nonatomic, copy)NSString *imgsrc;

//时间
@property (nonatomic, copy)NSString *ptime;

//新闻来源
@property (nonatomic, copy)NSString *source;



+ (instancetype)nesWithDict:(NSDictionary *)dict;



+ (void)nesListWithURL:(NSString *)currentURLString success:(void(^)(NSArray <NewsModels *>*))successBlock error:(void(^)())errorBlock;




@end
