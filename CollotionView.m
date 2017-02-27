//
//  CollotionView.m
//  EXAMPLE
//
//  Created by Slc on 16/4/5.
//  Copyright © 2016年 slc. All rights reserved.
//

#import "CollotionView.h"
#import "CollecViewCell.h"
#import "StringConstants.h"
#import "imageViewController.h"
#import "UMMobClick/MobClick.h"

@interface CollotionView ()
@property(nonatomic,strong) UICollectionView *collView;
@end

@implementation CollotionView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"Collect & Scroll";
    
    [self creatViews];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden=YES;
    [MobClick beginLogPageView:@"SevenPage"];//("PageOne"为页面名称，可自定义)
}

-(void)creatViews{
    
    //需要layout 否则崩溃：UICollectionView must be initialized with a non-nil layout parameter
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置对齐方式
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //cell间距
    layout.minimumInteritemSpacing = 5.0f;
    //cell行距
    layout.minimumLineSpacing = 1.0f;
    //header
    layout.headerReferenceSize = CGSizeMake(fDeviceWidth, 150+10);//头部
    
    _collView  =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    _collView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _collView.delegate=self;
    _collView.dataSource=self;
    [self.view addSubview:_collView];
    
    //注册Cell类，否则崩溃: must register a nib or a class for the identifier or connect a prototype cell in a storyboard
    [_collView registerClass:[CollecViewCell class] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
    
    //注册ReusableView（相当于头部）
    [_collView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    /*
     ***广告栏
     */
     float AD_height = 150;//广告栏高度
    _headerView = [[AdvertisingColumn alloc]initWithFrame:CGRectMake(5, 5, fDeviceWidth-10, AD_height)];
    _headerView.backgroundColor = [UIColor blackColor];
    
    /*
     ***加载的数据
     */
    NSArray *imgArray = [NSArray arrayWithObjects:@"bgs.jpg",@"bgs.jpg",@"bgs.jpg",@"bgs.jpg",@"bgs.jpg",@"bgs.jpg", nil];
    [_headerView setArray:imgArray];
}

#pragma mark 定时滚动scrollView
-(void)viewDidAppear:(BOOL)animated{//显示窗口
    [super viewDidAppear:animated];
    //    [NSThread sleepForTimeInterval:3.0f];//睡眠，所有操作都不起作用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_headerView openTimer];//开启定时器
    });
}
-(void)viewWillDisappear:(BOOL)animated{//将要隐藏窗口  setModalTransitionStyle=UIModalTransitionStyleCrossDissolve时是不隐藏的，故不执行
     [MobClick endLogPageView:@"SevenPage"];
    [super viewWillDisappear:animated];
    if (_headerView.totalNum>1) {
        [_headerView closeTimer];//关闭定时器
    }
}
#pragma mark - scrollView也是适用于tableView的cell滚动 将开始和将要结束滚动时调用
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    [_headerView closeTimer];//关闭定时器
//}
//- (void)scrollViewWillErndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    if (_headerView.totalNum>1) {
//        [_headerView openTimer];//开启定时器
//    }
//}
//===========================================================================================

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"MyCollectionViewCell";
    CollecViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        cell = [[CollecViewCell alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    cell.imgeView.image = [UIImage imageNamed:@"bgs.jpg"];
    cell.text.text = [NSString stringWithFormat:@"Cell %ld",(long)indexPath.row];
    
    return cell;
}
//头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    
    [headerView addSubview:_headerView];//头部广告栏
    return headerView;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake((fDeviceWidth-20)/2, (fDeviceWidth-20)/2+50);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 0, 5); //(上,坐,下,右)
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIImageView * imageView = cell.subviews[1];
    imageViewController *imgVC =[[imageViewController alloc]init];
    [imgVC getImage:imageView.image];
    [self presentViewController:imgVC animated:YES completion:nil];
    NSLog(@"选择%ld",(long)indexPath.row);
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end
