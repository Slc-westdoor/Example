//
//  imageViewController.m
//  HorizontalCollectionCellExample
//
//  Created by Slc on 15/7/28.
//  Copyright (c) 2015年 Muratcan Celayir. All rights reserved.
//

#import "imageViewController.h"
#import "ViewController.h"
#import "RatingBar.h"
#import "TQStarRatingView.h"

@interface imageViewController ()<RatingBarDelegate,StarRatingViewDelegate,UITextFieldDelegate>{
    UITextField *TextField;
}

//正常评分
@property (nonatomic,strong) UILabel *mLabel;
@property (nonatomic,strong) RatingBar *ratingBar1;
@property (nonatomic,strong) RatingBar *ratingBar2;
@property (nonatomic,strong) RatingBar *ratingBar3;

//精确评分
@property (nonatomic, strong) TQStarRatingView *starRatingView;
@property (nonatomic, strong) TQStarRatingView *nibStarRatingView;

//- (void)scoreButtonTouchUpInside:(id)sender;

@end

@implementation imageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    
    //调用initWithImage:方法，它创建出来的imageview的宽高和图片的宽高一样      构造方法   是图片的真实尺寸
    imgview= [[UIImageView alloc]initWithImage:imge];

    //设置 UIScrollView的位置与屏幕大小相同
     _scrollview=[[UIScrollView alloc]initWithFrame:self.view.bounds];

    //设置实现缩放
    //设置代理scrollview的代理对象
    _scrollview.delegate=self;
    //设置最大伸缩比例
    _scrollview.maximumZoomScale=2.0;
     //设置最小伸缩比例
     _scrollview.minimumZoomScale=0.5;
    _scrollview.contentSize=imge.size;
    
    [self.view addSubview:_scrollview];
    
    [_scrollview addSubview:imgview];
    [self.view addSubview:_scrollview];
    
    UIButton * bt = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 60, 60)];
    [bt setTitle:@"Back" forState:UIControlStateNormal];
    [bt setBackgroundColor:[UIColor clearColor]];
    [bt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [bt setHighlighted:YES];
    [bt addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];

    
    // Do any additional setup after loading the view.
    //正常评分
    [self nomal];
    //详细评分
    [self detail];
}

-(void)nomal{
    //RatingBar1
    CGFloat width = 200;
    CGFloat x = (self.view.bounds.size.width - width)*0.5;
    self.ratingBar1 = [[RatingBar alloc] initWithFrame:CGRectMake(x, self.view.frame.size.height - 100, width, 50)];
    
    //添加到view中
    [self.view addSubview:self.ratingBar1];
    //是否是指示器
    self.ratingBar1.isIndicator = NO;
    [self.ratingBar1 setImageDeselected:@"iconfont-xingunselected" halfSelected:@"iconfont-banxing" fullSelected:@"iconfont-xing" andDelegate:self];
    
    //显示结果的UILabel
    CGFloat labelX = (self.view.bounds.size.width - 400)*0.5f;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, self.view.bounds.size.height - 60, 400, 50)];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    self.mLabel = label;
}

#pragma mark - RatingBar delegate
-(void)ratingBar:(RatingBar *)ratingBar ratingChanged:(float)newRating{
    if (self.ratingBar1 == ratingBar) {
        self.mLabel.text = [NSString stringWithFormat:@"第二个评分条的当前结果为:%.1f",newRating];
        
    }
}

//精确评分
-(void)detail{
    _starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(60, self.view.frame.size.height - 180, 200, 35)
                                                 numberOfStar:kNUMBER_OF_STAR];
    _starRatingView.delegate = self;
    [self.view addSubview:_starRatingView];

    TextField = [[UITextField alloc]initWithFrame:CGRectMake(120, self.view.frame.size.height - 180 + 40, 200-120, 30)];
    TextField.delegate = self;
    TextField.placeholder = @"评分:";
    TextField.textAlignment = NSTextAlignmentCenter;
    TextField.backgroundColor = [UIColor whiteColor];
    TextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:TextField];
}

//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [TextField resignFirstResponder];
    float score = [TextField.text floatValue] / 5;
    [_starRatingView getSroll:score];
    return YES;
}

-(void)starRatingView:(TQStarRatingView *)view score:(float)score
{
    self.mLabel.text = [NSString stringWithFormat:@"第二个评分条的当前结果为:%0.1f",score * 5 ];
   // NSLog(@"%@", [NSString stringWithFormat:@"%0.2f",score * 10 ]);

    [self.nibStarRatingView setScore:score withAnimation:YES];
}

- (void)scoreButtonTouchUpInside:(id)sender
{
    //设置分数。参数需要在0-1之间。
    [self.starRatingView setScore:0.5f withAnimation:YES];
    
   // [self.nibStarRatingView setScore:0.5f withAnimation:YES];
    
    //or
    /*
     
     [self.starRatingView setScore:0.5f withAnimation:YES completion:^(BOOL finished)
     {
     NSLog(@"%@",@"starOver");
     }];
     
     */
}


//实现图片的缩放
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    NSLog(@"**************viewForZoomingInScrollView");
    return imgview;
}
//实现图片在缩放过程中居中
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
    imgview.center = CGPointMake(scrollView.contentSize.width/2 + offsetX,scrollView.contentSize.height/2 + offsetY);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getImage:(UIImage *)img{
    imge = img;
    NSLog(@"imgStr:%@",imge);
}


//button 加载传值过来的image后点击返回崩
-(void)goBack{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
