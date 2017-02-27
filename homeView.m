//
//  homeView.m
//  EXAMPLE
//
//  Created by 王雅强 on 15/3/31.
//  Copyright (c) 2015年 slc. All rights reserved.
//
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE_5 (fabs((double)[[ UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON)

#import "homeView.h"
#import "Tool.h"
#import "ProgressView.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "NSData+Base64.h"
#import "serviceView.h"
#import "ProductView.h"
#import "settingView.h"
#import "EFAnimationViewController.h"
#import "UMMobClick/MobClick.h"
@interface homeView ()

@property( nonatomic ,strong)ASIFormDataRequest * request;

@end

@implementation homeView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationItems];
//    self.slideShowView = [[SLGSlideshowView alloc]initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height - 91)];
//    self.slideShowView.datasource =self;
//    self.slideShowView.delegate =self;
//    [self.view addSubview:self.slideShowView];
//    _transitionOptions= @[
//                          [NSNumber numberWithInteger:UIViewAnimationOptionTransitionFlipFromLeft],
//                          [NSNumber numberWithInteger:UIViewAnimationOptionTransitionFlipFromRight],
//                          [NSNumber numberWithInteger:UIViewAnimationOptionTransitionCurlUp],
//                          [NSNumber numberWithInteger:UIViewAnimationOptionTransitionCurlDown],
//                          [NSNumber numberWithInteger:UIViewAnimationOptionTransitionFlipFromTop],
//                          [NSNumber numberWithInteger:UIViewAnimationOptionTransitionCrossDissolve],
//                          [NSNumber numberWithInteger:UIViewAnimationOptionTransitionFlipFromBottom]
//                          ];
//    
//    NSArray* section1 = @[@"IMG_1257.JPG",@"IMG_1258.JPG",@"IMG_1259.JPG",@"IMG_1260.JPG",@"IMG_1261.JPG",@"IMG_1262.JPG"];
//    NSArray* section2 = @[@"IMG_1263.JPG",@"IMG_1264.JPG",@"IMG_1265.JPG",@"IMG_1266.JPG",@"IMG_1267.JPG",@"IMG_1268.JPG"];
//    _slideshowData =[NSArray arrayWithObjects:section1,section2,nil];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)viewWillAppear:(BOOL)animated{
    
//    [self.slideShowView beginSlideShow];
    
    [MobClick beginLogPageView:@"TwoPage"];//("PageOne"为页面名称，可自定义)
//    [MobClick event:@"TwoPageTime"];
}

-(void)viewWillDisappear:(BOOL)animated{
    
//    [self.slideShowView stopSlideShow];
     [MobClick endLogPageView:@"TwoPage"];
}

//-(NSUInteger)numberOfSectionsInSlideshow:(SLGSlideshowView*)slideShowView{
//    
//    return [_slideshowData count];
//    
//}
//-(NSInteger)numberOfItems:(SLGSlideshowView*)slideShowView inSection:(NSUInteger)section{
//    
//    return [[_slideshowData objectAtIndex:section]count];
//}
//-(UIView*)viewForSlideShow:(SLGSlideshowView*)slideShowView atIndexPath:(NSIndexPath*)indexPath{
//    
//    NSString* imageName = [[_slideshowData objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
//    UIImage* img  = [UIImage imageNamed:imageName];
//    UIImageView* imageView = [[UIImageView alloc]initWithImage:img];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    return imageView;
//}
//
//-(NSTimeInterval)slideDurationForSlideShow:(SLGSlideshowView*)slideShowView atIndexPath:(NSIndexPath*)indexPath{
//    
//    // random time
//    return arc4random()%6;
//    
//}
//-(NSTimeInterval)transitionDurationForSlideShow:(SLGSlideshowView*)slideShowView atIndexPath:(NSIndexPath*)indexPath{
//    // random time
//    return (arc4random()%(4-1))+2;
//    
//}
//-(NSUInteger)transitionStyleForSlideShow:(SLGSlideshowView*)slideShowView atIndexPath:(NSIndexPath*)indexPath{
//    //random style
//    NSUInteger rIndex = arc4random()%[_transitionOptions count];
//    return [[_transitionOptions objectAtIndex:rIndex]integerValue];
//    
//}

//#pragma mark - SlideShowDelegate
//-(void)slideShowViewDidEnd:(SLGSlideshowView*)slideShowView willRepeat:(BOOL)willRepeat{
//    NSLog(@"%s",__PRETTY_FUNCTION__);
//}
//-(void)slideShowView:(SLGSlideshowView*)slideShowView willDisplaySlideAtIndexPath:(NSIndexPath*)indexPath{
//    NSLog(@"%s: %li : %li",__PRETTY_FUNCTION__,(long)indexPath.section,(long)indexPath.row);
//}
//-(void)slideShowView:(SLGSlideshowView*)slideShowView didDisplaySlideAtIndexPath:(NSIndexPath*)indexPath{
//    NSLog(@"%s: %li : %li",__PRETTY_FUNCTION__,(long)indexPath.section,(long)indexPath.row);
//}
//-(void)slideShowView:(SLGSlideshowView*)slideShowView willBeginSection:(NSUInteger)section{
//    NSLog(@"%s:%li",__PRETTY_FUNCTION__,(long)section);
//}
//-(void)slideShowView:(SLGSlideshowView*)slideShowView didBeginSection:(NSUInteger)section{
//    NSLog(@"%s:%li",__PRETTY_FUNCTION__,(long)section);
//    
//}
//-(void)slideShowViewDidPause:(SLGSlideshowView*)slideShowView{
//    NSLog(@"%s",__PRETTY_FUNCTION__);
//}
//-(void)slideShowViewDidResume:(SLGSlideshowView*)slideShowView{
//    NSLog(@"%s",__PRETTY_FUNCTION__);
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavigationItems
{
    UINavigationBar *navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44+20)];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"sp_unfold_red"] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:navigationBar];
   
    [navigationBar pushNavigationItem:[Tool addNavigationItemLeft:@"me2" Title:@"主页" bartitle:nil color:[UIColor whiteColor] barcolor:[UIColor whiteColor] target:self action:@selector(ClickedLeftAcation)]animated:NO];
    
    [self.tabBarController.tabBar setHidden:NO];
    
}

-(void)ClickedLeftAcation{
    NSDictionary *dict = @{@"type" : @"button", @"quantity" : @"6"};
    [MobClick event:@"bt5" attributes:dict];
    [self dismissViewControllerAnimated:YES completion:nil];
    EFAnimationViewController * efVC = [[EFAnimationViewController alloc]init];
    [self presentViewController:efVC animated:YES completion:nil];
}


/*
 // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
 if (!cell) {
 cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
 }
 else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
 {
 while ([cell.contentView.subviews lastObject] != nil) {
 [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
 }
 }
 // 对cell 进行简单地数据配置
 cell.textLabel.text = @"text";
 cell.detailTextLabel.text = @"text";
 cell.imageView.image = [UIImage imageNamed:@"4.png"];
*/
-(UIImageView *)draw{
    //开始图像绘图
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();//一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1.0);//画线笔的颜色
    CGContextSetLineWidth(context, 1.0);//线的宽度
    CGContextAddArc(context, 100, 80, 5, 0, 2 * M_PI, 0);//添加一个圆，x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextSetRGBFillColor(context, 0, 1, 0, 1.0);//填充颜色
    
    CGPoint aPoints[2];//坐标点
    aPoints[0] =CGPointMake(100, 80);//坐标1
    aPoints[1] =CGPointMake(100, 280);//坐标2
    //points[]坐标数组，和count大小
    CGContextAddLines(context, aPoints, 2);//添加线
    //    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径加填充
    CGContextStrokePath(context);
    
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    return imgView;
}

@end
