//
//  WDLooperCell.m
//  Together
//
//  Created by 王迪 on 16/9/9.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import "WDLooperCell.h"
#import <UIImageView+WebCache.h>
@interface WDLooperCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iv_imageView;

@property (weak, nonatomic) IBOutlet UILabel *lb_label;

@property (weak, nonatomic) IBOutlet UIPageControl *pc_pageControll;




@end

@implementation WDLooperCell

- (void)setModel:(WDLooperModel *)model {
    
    _model = model;
    
    _pc_pageControll.currentPage = self.tag;
    
    [_iv_imageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    
    _lb_label.text = model.title;
    
}



@end
