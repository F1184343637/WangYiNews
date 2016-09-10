//
//  HMChannelModel.m
//  Together
//
//  Created by 刘宗飞 on 16/9/10.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import "HMChannelModel.h"

@implementation HMChannelModel

/**
 *  对象初始化方法,对象方法
 *
 *  @param dict 传入字典数据
 *
 *  @return 返回当前类的对象
 */
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    //完成初始化
    self = [super init];
    
    //判断对象是否存在
    if (self) {
        
        //使用KVC的方式设置数据
        [self setValuesForKeysWithDictionary:dict];
    }
    
    //返回当前对象
    return self;
    
}

/**
 *  对象初始化方法,类方法
 *
 *  @param dict 传入字典数据
 *
 *  @return 返回当前类的对象
 */
+ (instancetype)modelWithDict:(NSDictionary *)dict{
    
    //调用上方的方法完成初始化
    return [[self alloc]initWithDict:dict];
}

- (NSString *)currentString{
    //拼接urlString
    //http://c.m.163.com/nc/article/list/T1348648517839/0-20.html
    //article/list/%@/0-20.html
    return [NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/%@/0-20.html",self.tid];
    
}



+ (NSArray *)loadLocalData{
    
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    //
    NSData *data = [NSData dataWithContentsOfFile:path];
    //json的反序列化
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    //取出数组
    NSArray *dataArray = dic[@"tList"];
    
    NSMutableArray *muArr = [NSMutableArray array];
    [dataArray enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HMChannelModel *channelModel = [HMChannelModel modelWithDict:obj];
        [muArr addObject:channelModel];
    }];
    
    //对数组进行排序
    //参数1,2分别为两个字典数据
    return [muArr sortedArrayUsingComparator:^NSComparisonResult(HMChannelModel *  _Nonnull obj1, HMChannelModel*  _Nonnull obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
    //    return muArr.copy;
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@{tname = %@,tid =%@}",[super description],self.tname,self.tid];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


@end
