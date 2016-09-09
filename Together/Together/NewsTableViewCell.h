//
//  NewsTableViewCell.h
//  Together
//
//  Created by 程建 on 16/9/9.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModels.h"

@interface NewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *source;


@property (weak, nonatomic) IBOutlet UILabel *replyCount;


@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *Imgs;







@property (nonatomic,strong)NewsModels *models;

//提供identifier
+ (NSString *)getReuse:(NewsModels *)models;


//提供cell的高度
+ (CGFloat)getHeight:(NewsModels *)models;

@end
