//
//  WDLooperVC.m
//  Together
//
//  Created by 王迪 on 16/9/9.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import "WDLooperVC.h"
#import "WDLooperModel.h"
#import "WDLooperCell.h"

@interface WDLooperVC ()

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic ,strong) NSArray *dataArray;

@property (nonatomic ,strong) NSTimer *timer;

@property (nonatomic ,assign) NSInteger pageNum;

@end

@implementation WDLooperVC

- (void)setDataArray:(NSArray *)dataArray {

    _dataArray = dataArray;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView reloadData];
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.itemSize = self.collectionView.bounds.size;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [WDLooperModel getModelArrayWithCompleteBlock:^(NSArray *array) {
       
        self.dataArray = array;
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        
    } andErrorBlock:^{
        
        NSLog(@"wangdi -- error");
    }];
    

    [self addTimer];
}

- (void)addTimer {

    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scrollPerSec) userInfo:nil repeats:YES];
    
}

- (void)deleteTimer {

    [_timer invalidate];
    _timer = nil;
}

- (void)scrollPerSec {
    
    NSIndexPath *indexPath ;
    
    if (_pageNum == 7) {
        
        indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
    }else {
    
        indexPath = [NSIndexPath indexPathForItem:_pageNum % 4 + 1 inSection:1];
    }

    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    WDLooperCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wdCell" forIndexPath:indexPath];
    
    WDLooperModel *model = self.dataArray[indexPath.row];
    
    cell.tag = indexPath.item;
    
    cell.model = model;
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    _pageNum = scrollView.contentOffset.x / self.view.bounds.size.width;

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_pageNum % 4 inSection:1];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [self deleteTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    [self addTimer];
}








@end
