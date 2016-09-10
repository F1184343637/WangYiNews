//
//  HMHomeViewController.m
//  Together
//
//  Created by 刘宗飞 on 16/9/10.
//  Copyright © 2016年 刘宗飞. All rights reserved.
//

#import "HMHomeViewController.h"
#import "HMChannelModel.h"
#import "HMLabel.h"
#import "HMHomeCell.h"

@interface HMHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *channelScroll;
@property (weak, nonatomic) IBOutlet UICollectionView *newsCollection;

@property (nonatomic,strong)NSArray<HMChannelModel *> *dataArray;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;


//记录当前新闻分类的index
@property(nonatomic,assign) NSInteger currentChannelIndex;

//记录下一个新闻分类的index
@property (nonatomic,assign)NSInteger nextChannelIndex;


@end

@implementation HMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataArray = [HMChannelModel loadLocalData];
    
    [self showChannel];

}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    [self flowLayouts];
    
}
- (void)flowLayouts{
    
    self.flowLayout.itemSize = self.newsCollection.frame.size;
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    
    self.newsCollection.pagingEnabled = YES;
    self.newsCollection.bounces = NO;
    self.newsCollection.showsHorizontalScrollIndicator = YES;
    
}

//显示新闻分类
- (void)showChannel{
    
    //让UIScrollView在导航栏下面的时候,自动的添加上导航栏的高度
    self.automaticallyAdjustsScrollViewInsets =  NO;
    
    CGFloat label_heigh = self.channelScroll.frame.size.height;
    CGFloat label_y = 0;
    CGFloat label_margin = 5;
    __block CGFloat label_x = label_margin;
    
    //遍历数组添加标题
    [self.dataArray enumerateObjectsUsingBlock:^(HMChannelModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //自定义label
        HMLabel *label = [HMLabel tiGong:obj.tname];
        //设置label初始化显示的时候为放大
        if (idx == 0) {
            label.scale = 1;
        }
        
        CGFloat label_width = label.frame.size.width;
        //先设置第一个label的frame
        label.frame = CGRectMake(label_x, label_y, label_width, label_heigh);
        //x的累加
        label_x +=  label_margin + label_width;
        
        
        //单指点击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTap:)];
        //将手势添加到label上
#pragma mark -- 注意:不要忘记设置用户交互啊!!!
        [label addGestureRecognizer:tapGesture];
        //设置index,目的是为了点击的时候取出index,手势滚动界面
        label.tag = idx;
        
        
        [self.channelScroll addSubview:label];
        
    }];
    
    //然而发现此时scroll并不能滚动
    //设置contentSize
    //    self.channelScroll.contentSize = CGSizeMake(label_x, self.channelScroll.frame.size.height);
    [self.channelScroll setContentSize:CGSizeMake(label_x, self.channelScroll.frame.size.height)];
    
    
}


//点击label的时候调用此方法
- (void)labelTap:(UITapGestureRecognizer *)tapGesture{
    //    NSLog(@"sss");
    //点击滚动界面
    //首先要获取到label的tag值
#warning mark -- 取出当前这个手势点击的view控件
    HMLabel *label = (HMLabel *)tapGesture.view;
    NSInteger tag = label.tag;
    
    self.nextChannelIndex = tag;
    //设置当前滚动的界面
    //设置collectionView跟着一起滚动
#pragma mark -- 设置indexPath的下标和组数是在哪组的哪一个
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:tag inSection:0];
    [self.newsCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HMHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell" forIndexPath:indexPath];
    
    HMChannelModel *model = self.dataArray[indexPath.item];
//    cell.currentString = model.currentString;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"a" object:model.currentString];
    
    
    
    return cell;
}

//滚动过程中调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
#warning mark -- BUG:判断是否相邻label
    if (ABS(self.currentChannelIndex - self.nextChannelIndex) > 1) {
        //不相邻就不要走下面了
        return;
    }
    
    
    //滚动过程中一个界面会有两个界面
    //所以先获取到当前的两个界面下标
    //先获取一下当前的这个label
    HMLabel *currentlabel = self.channelScroll.subviews[self.currentChannelIndex];
    //设置下一个label
    HMLabel *nextLabel;
    //获取当前的两个界面下标
    //先获取界面的下标集合
    NSArray *array = [self.newsCollection indexPathsForVisibleItems];
    //遍历此集合找出下一个界面
    for (NSIndexPath *indexPath in array) {
        if (indexPath.item != self.currentChannelIndex) {
            nextLabel = self.channelScroll.subviews[indexPath.item];
            break;
        }
    }
    
#pragma mark -- 以上获取两个label
    
    
    
    //现已获取到两个前一个和后一个label
    //设置label的文字颜色放大等等
    //获取两个变化率
    CGFloat nextScale = scrollView.contentOffset.x;
    nextScale = nextScale / self.newsCollection.frame.size.width;
    //    NSLog(@"%f",bianHua);
    nextScale = nextScale - self.currentChannelIndex;
    //绝对值
    nextScale = ABS(nextScale);
    
    CGFloat currentScale = 1 - nextScale;
    
    //    NSLog(@"%f",currentScale);
    //变化率
    currentlabel.scale = currentScale;
    nextLabel.scale = nextScale;
    
}

//代码的滚动停止
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndDecelerating:scrollView];
}

//滚动结束调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //滚动结束获取当前下方界面de页号
    self.currentChannelIndex = scrollView.contentOffset.x / self.newsCollection.frame.size.width;
    //记录一下当前index
    self.nextChannelIndex = self.currentChannelIndex;
#pragma mark -- BUG1:让其滚动结束后,让所有的label状态更新
    for (UIView *views in self.channelScroll.subviews) {
        //最好做一下类型判断,因为scroll中不仅仅只有label,还有滚动条呢
        if ([views isKindOfClass:[HMLabel class]]) {
            //判断label的tag值是否与当前的index一致,那就设置当前的label为大和红
            HMLabel *label = (HMLabel *)views;
            if (label.tag == self.currentChannelIndex) {
                label.scale = 1;
            }else{
                label.scale = 0;
            }
            
        }
        
    }
    
    
    
    
    //    NSLog(@"%zd",self.currentChannelIndex);
    //当滚动结束,让屏幕处于舒服的位置
    HMLabel *label = self.channelScroll.subviews[self.currentChannelIndex];
    //label的中间位置 - 屏幕的宽度 * 0.5
    CGFloat offSet = label.center.x - self.newsCollection.frame.size.width * 0.5;
    //max
    CGFloat max = self.channelScroll.contentSize.width - self.newsCollection.frame.size.width;
    if (offSet < 0) {
        offSet = 0;
    }else if (offSet > max){
        offSet = max;
    }
    [self.channelScroll setContentOffset:CGPointMake(offSet, 0) animated:YES];
    
}



@end
