//
//  NewsTableViewCell.m
//  Together
//
//  Created by 程建 on 16/9/9.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import "NewsTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModels:(NewsModels *)models{

    _models = models;
    
    NSURL *url = [NSURL URLWithString:models.imgsrc];
    
    [self.img sd_setImageWithURL:url];
    
    self.title.text = models.title;
    
    self.source.text = models.source;
    
    self.replyCount.text = [NSString stringWithFormat:@"%d跟帖",models.replyCount.intValue];
    
    if(models.imgextra){
    
        [models.imgextra enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //从字典获取图片下载地址
            NSString *string = obj[@"imgsrc"];
            //获取对应的imageView
            UIImageView *imageView = self.Imgs[idx];
            //sdWebImage
            NSURL *url = [NSURL URLWithString:string];
            
            [imageView sd_setImageWithURL:url];
        }];
    }
    

}

+ (NSString *)getReuse:(NewsModels *)models{

    NSString *identifier = @"cell1";
    if(models.imgType){
    
        return identifier = @"cell2";
    }
    if(models.imgextra){
        return identifier = @"cell3";
    }
    
    return identifier;

}

+ (CGFloat)getHeight:(NewsModels *)models{

    if(models.imgType){
        return 150;
    }
    if(models.imgextra){
    
        return 200;
    }
    
    return 100;
}



@end
