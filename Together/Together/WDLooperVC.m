//
//  WDLooperVC.m
//  Together
//
//  Created by 王迪 on 16/9/9.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import "WDLooperVC.h"
#import "WDLooperModel.h"

@interface WDLooperVC ()

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic ,strong) NSArray *dataArray;

@end

@implementation WDLooperVC

- (void)setDataArray:(NSArray *)dataArray {

    _dataArray = dataArray;
    
    [self.collectionView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [WDLooperModel getModelArrayWithCompleteBlock:^(NSArray *array) {
       
        self.dataArray = array;
        
    } andErrorBlock:^{
        
        NSLog(@"wangdi -- error");
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    
    return nil;
}








@end
