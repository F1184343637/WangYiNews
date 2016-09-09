//
//  WDLooperModel.h
//  Together
//
//  Created by 王迪 on 16/9/9.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDLooperModel : NSObject



@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *imgsrc;

+ (instancetype)modelWithDict:(NSDictionary *)dict ;

+ (void)getModelArrayWithCompleteBlock:(void(^)(NSArray *array))comBlock andErrorBlock:(void(^)())errorBlock;



@end
