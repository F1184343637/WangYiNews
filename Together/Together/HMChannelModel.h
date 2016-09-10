//
//  HMChannelModel.h
//  Together
//
//  Created by 刘宗飞 on 16/9/10.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMChannelModel : NSObject

@property (nonatomic,copy) NSString *tname;

@property (nonatomic,copy) NSString *tid;

//拼接好的string
@property (nonatomic,copy)NSString *currentString;



/**
 *  对象初始化方法,对象方法
 *
 *  @param dict 传入字典数据
 *
 *  @return 返回当前类的对象
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

/**
 *  对象初始化方法,类方法
 *
 *  @param dict 传入字典数据
 *
 *  @return 返回当前类
 */
+(instancetype) modelWithDict:(NSDictionary *)dict;

//加载本地数据
+ (NSArray *)loadLocalData;

@end
