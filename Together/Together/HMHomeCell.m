//
//  HMHomeCell.m
//  Together
//
//  Created by 刘宗飞 on 16/9/10.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import "HMHomeCell.h"
#import "NewsTableViewController.h"

@interface HMHomeCell ()

@property (nonatomic,strong)NewsTableViewController *vc;

@end

@implementation HMHomeCell

- (void)setCurrentString:(NSString *)currentString{
    
    _currentString = currentString;
    self.vc.urlString = currentString;
    
}


//旨在加载xib或者初始化sb 的时候调用
- (void)awakeFromNib{
    [super awakeFromNib];
    //加载mainSB的第一个界面
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    self.vc = [sb instantiateInitialViewController];
    [self.contentView addSubview:self.vc.view];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //指定vc的frame
    self.vc.view.frame = self.contentView.frame;
}

@end
