//
//  NewsTableViewController.m
//  Together
//
//  Created by 程建 on 16/9/9.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsModels.h"
#import "NewsTableViewCell.h"

@interface NewsTableViewController ()

//新闻数据源
@property (nonatomic, strong)NSArray <NewsModels *> *newsArray;

@end

@implementation NewsTableViewController

- (void)setNewsArray:(NSArray<NewsModels *> *)newsArray{

    _newsArray = newsArray;
    
    [self.tableView reloadData];
}


- (void)setUrlString:(NSString *)urlString{

    _urlString = urlString;
    
    [NewsModels nesListWithURL:@"http://c.m.163.com/nc/article/list/T1348648517839/0-20.html" success:^(NSArray<NewsModels *> *array) {
        self.newsArray = array;
    } error:^{
        NSLog(@"网络错误");
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

}

#pragma mark
#pragma mark -数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.newsArray.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsModels *models = self.newsArray[indexPath.row];
    
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NewsTableViewCell getReuse:models] forIndexPath:indexPath];
    
    cell.models = models;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NewsModels *models = self.newsArray[indexPath.row];
    
    return [NewsTableViewCell getHeight:models];
    
}


@end
