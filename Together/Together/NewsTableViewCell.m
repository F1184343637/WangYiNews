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
    

}

+ (NSString *)getReuse:(NewsModels *)models{

    NSString *identifier = @"cell1";
    
    
    
    return identifier;

}

+ (CGFloat)getHeight:(NewsModels *)models{


    return 100;
}



@end
