//
//  RootViewController.m
//  
//
//  Created by wordoor－z on 16/1/14.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "RootViewController.h"
#import "Tool.h"
#import "XRCarouselView.h"
#import "CRMediaPickerController.h"

@interface RootViewController ()<XRCarouselViewDelegate,CRMediaPickerControllerDelegate>
@property (nonatomic, strong) XRCarouselView *carouselView;
@property (strong, nonatomic) XRCarouselView *carouselView2;
@property (strong, nonatomic) CRMediaPickerController *mediaPickerController;

@end

@implementation RootViewController

-(void)viewDidAppear:(BOOL)animated{
    exitBt.alpha= 1;
    exitBt.frame =  CGRectMake(20, 64, 45, 30);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationItems];
    [self creatViews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavigationItems
{
    UINavigationBar *navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44+20)];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"sp_unfold_red@2x"] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:navigationBar];
    [navigationBar pushNavigationItem:[Tool addNavigationItemRight:nil Title:@"服务" bartitle:@"导入视频 " color:[UIColor whiteColor] barcolor:[UIColor whiteColor] target:self action:@selector(turnTovc)] animated:NO];
}

-(void)turnTovc{
    
    // 初始化自己的视频选择器
    self.mediaPickerController = [[CRMediaPickerController alloc] init];
    // 设置视频选择器的代理为自己
    self.mediaPickerController.delegate = self;
    // 设置媒体类型为视频
    self.mediaPickerController.mediaType = CRMediaPickerControllerMediaTypeVideo;
    // 设置视频来源为本地库文件
    self.mediaPickerController.sourceType = CRMediaPickerControllerSourceTypePhotoLibrary;
    // 设置是否允许编辑
    self.mediaPickerController.allowsEditing = YES;
    // 设置视频质量
    self.mediaPickerController.videoQualityType = UIImagePickerControllerQualityTypeMedium;
    // 设置视频最大持续时间
    self.mediaPickerController.videoMaximumDuration = 60.0f;
    // 显示视频选择器
    [self.mediaPickerController show];
   
}

#pragma mark - CPDMediaPickerControllerDelegate
- (void)CRMediaPickerController:(CRMediaPickerController *)mediaPickerController didFinishPickingAsset:(ALAsset *)asset error:(NSError *)error
{
    // 如果没有错误
    if (!error) {
        // 如果有选择数据
        if (asset) {
            // 如果用户选择了照片数据
            if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                
            }
            // 如果用户选择了视频数据
            if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {
                // 获取视频的url
                NSURL *contentURL = asset.defaultRepresentation.url;
                // 将数据转化为字符串
               // NSString *inputUrl = [contentURL ];
                [self CreatView:contentURL];
            }
        }
    }
}

-(void)CreatView:(NSURL *)url{
    
    
//    NSString *urlStr = [[NSBundle mainBundle]pathForResource:@"丫头.mp4" ofType:nil];
//    
//    NSURL *url = [NSURL fileURLWithPath:urlStr];
    
//    
//    _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
//    _moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
//    [_moviePlayer play];
////    [_moviePlayer.view setFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 80)];
//    
//    [self.view addSubview:_moviePlayer.view];
//    _moviePlayer.shouldAutoplay = YES;
//    [_moviePlayer setControlStyle:MPMovieControlStyleNone];
//    [_moviePlayer setFullscreen:YES];
//    
//    [_moviePlayer setRepeatMode:MPMovieRepeatModeOne];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(playbackStateChanged)
//                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
//                                               object:_moviePlayer];
//    
    
    
//    __alpaView.backgroundColor = [UIColor orangeColor];

    
//    [_moviePlayer.view addSubview:__alpaView];
    
    
}
-(void)playbackStateChanged{
    
    //取得目前状态
    MPMoviePlaybackState playbackState = [_moviePlayer playbackState];
    
    //状态类型
    switch (playbackState) {
        case MPMoviePlaybackStateStopped:
            [_moviePlayer play];
            break;
            
        case MPMoviePlaybackStatePlaying:
//            NSLog(@"播放中");
            break;
            
        case MPMoviePlaybackStatePaused:
            [_moviePlayer play];
            break;
            
        case MPMoviePlaybackStateInterrupted:
//            NSLog(@"播放被中断");
            break;
            
        case MPMoviePlaybackStateSeekingForward:
//            NSLog(@"往前快转");
            break;
            
        case MPMoviePlaybackStateSeekingBackward:
//            NSLog(@"往后快转");
            break;
            
        default:
//            NSLog(@"无法辨识的状态");
            break;
    }
}

-(void)exit{
    [_moviePlayer stop];
    _moviePlayer.shouldAutoplay = YES;
    [_moviePlayer.view removeFromSuperview];
}



-(void)creatViews{
    //本地图片
    NSArray *arr1 = @[[UIImage imageNamed:@"one.jpg"], [UIImage imageNamed:@"two.jpg"], [UIImage imageNamed:@"three.jpg"]];
    //网络图片
    NSArray *arr2 = @[@"http://www.5068.com/u/faceimg/20140725173411.jpg", @"http://file27.mafengwo.net/M00/52/F2/wKgB6lO_PTyAKKPBACID2dURuk410.jpeg", @"http://file27.mafengwo.net/M00/B2/12/wKgB6lO0ahWAMhL8AAV1yBFJDJw20.jpeg"];
    //既有本地图片也有网络图片
    NSArray *arr3 = @[@"http://www.5068.com/u/faceimg/20140725173411.jpg", [UIImage imageNamed:@"2.jpg"], @"http://file27.mafengwo.net/M00/52/F2/wKgB6lO_PTyAKKPBACID2dURuk410.jpeg", [UIImage imageNamed:@"1.jpg"]];
    
    NSArray *describeArray = @[@"这是第一张图片的描述", @"这是第二张图片的描述", @"这是第三张图片的描述", @"这是第四张图片的描述"];
    
    //创建方式1
    //    self.carouselView = [[XRCarouselView alloc] initWithImageArray:arr1];
    
    //创建方式2
    //    self.carouselView = [[XRCarouselView alloc] initWithImageArray:arr2 imageClickBlock:^(NSInteger index) {
    //        NSLog(@"第%ld张图片被点击", index);
    //    }];
    
    //创建方式3
    self.carouselView = [XRCarouselView carouselViewWithImageArray:arr2 describeArray:describeArray];
    
    
    //设置frame
    self.carouselView.frame = CGRectMake(0, 64, self.view.frame.size.width, 150);
    
    //用block处理图片点击
    self.carouselView.imageClickBlock = ^(NSInteger index) {
//        NSLog(@"1幅图第%ld张图片被点击",(long)index);
    };
    
    //用代理处理图片点击，如果两个都实现，block优先级高于代理
    self.carouselView.delegate = self;
    
    //设置每张图片的停留时间
    _carouselView.time = 1.5;
    
    //设置分页控件的图片
    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentImage:[UIImage imageNamed:@"current"]];
    
    //设置分页控件的frame
    CGFloat width = arr2.count * 30;
    CGFloat height = 20;
    CGFloat x = _carouselView.frame.size.width - width - 10;
    CGFloat y = _carouselView.frame.size.height - height - 20;
    _carouselView.pageControl.frame = CGRectMake(x, y, width, height);
    
    [self.view addSubview:_carouselView];
    
//    //最简单的使用方式
//    self.carouselView2 = [[XRCarouselView alloc]initWithFrame: CGRectMake(0, 269, self.view.frame.size.width, 150)];
//    self.carouselView2.imageClickBlock = ^(NSInteger index) {
////        NSLog(@"2幅图第%ld张图片被点击",(long)index);
//    };
//    self.carouselView2.delegate = self;
//    //其他的颜色
//    self.carouselView2.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.8 alpha:0.8];
//    //当前的颜色
//    self.carouselView2.pageControl.currentPageIndicatorTintColor = [UIColor brownColor];
//    //self.carouselView2.imageArray=arr3;
//    [_carouselView2 setImageArray:arr3];
//    _carouselView2.time = 2;
//    [self.view addSubview:self.carouselView2];
    
    exitBt = [[UIButton alloc]initWithFrame:CGRectMake(20, -30, 45, 30)];
    exitBt.alpha=0;
    [exitBt setTitle:@"exit" forState:UIControlStateNormal];
    [exitBt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [exitBt addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitBt];

}

#pragma mark XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView didClickImage:(NSInteger)index {
//    NSLog(@"点击了第%ld张图片",(long)index);
}


@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
