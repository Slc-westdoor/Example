//
//  serviceView.m
//  EXAMPLE
//
//  Created by 王雅强 on 15/3/31.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import "serviceView.h"
#import "Tool.h"
#import "RootViewController.h"
#import "UMMobClick/MobClick.h"

@interface serviceView ()

@end

@implementation serviceView

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithWhite:0.6 alpha:0.5];
    [self initNavigationItems];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"OnePage"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"OnePage"];
}

-(void)initNavigationItems
{

    UIView * popView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height /2.0)];
    
    popView.backgroundColor = [UIColor grayColor];
    
    //加个阴影
    popView.layer.shadowColor = [UIColor blackColor].CGColor;
    popView.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    popView.layer.shadowOpacity = 0.8;
    popView.layer.shadowRadius = 5;
    
//    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"cat" withExtension:@"gif"];
//    _gifView = [[SvGifView alloc] initWithCenter:CGPointMake(160, 130) fileURL:fileUrl];
//    _gifView.backgroundColor = [UIColor clearColor];
//    _gifView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//    [popView addSubview:_gifView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(50, 200, 100, 60);
    btn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"Start Gif" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(startGif) forControlEvents:UIControlEventTouchUpInside];
    [popView addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame = CGRectMake(200, 200, 100, 60);
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn2.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [btn2 setTitle:@"Stop Gif" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(stopGif) forControlEvents:UIControlEventTouchUpInside];
    [popView addSubview:btn2];

    //导航栏一定要加载ROOTVC上面
    RootViewController * root = [[RootViewController alloc]init];
    
    //关闭btn
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, 0, 150, 40);
    [closeBtn setTitle:@"关闭装逼模式" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor colorWithRed:200/255.0 green:110/255.0 blue:90/255.0 alpha:1] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [popView addSubview:closeBtn];
    
    //开启btn。
    UIButton * openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    openBtn.frame = CGRectMake((self.view.frame.size.width - 200)/2.0, 222, 200, 40);
    [openBtn setTitle:@"开启装逼模式" forState:UIControlStateNormal];
    [openBtn setTitleColor:[UIColor colorWithRed:180/255.0 green:110/255.0 blue:95/255.0 alpha:1] forState:UIControlStateNormal];
    [openBtn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    //组件也要加在rootVC上面
    [root.view addSubview:openBtn];
    
    
    [self createPopVCWithRootVC:root andPopView:popView];

}




-(void)creatViews{
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"cat" withExtension:@"gif"];
    _gifView = [[SvGifView alloc] initWithCenter:CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - 200) fileURL:fileUrl];
    _gifView.backgroundColor = [UIColor clearColor];
    _gifView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:_gifView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 0, 100, 60);
    btn.center = CGPointMake(100, self.view.bounds.size.height - 80);
    btn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [btn setTitle:@"Start Gif" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(startGif) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame = CGRectMake(0, 0, 100, 60);
    btn2.center = CGPointMake(220, self.view.bounds.size.height - 80);
    btn2.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [btn2 setTitle:@"Stop Gif" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(stopGif) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

}

//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection
 didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

- (void)startGif
{
//    NSLog(@"-----");
    [_gifView startGif];
    
    NSDictionary *dict = @{@"type" : @"button", @"quantity" : @"6"};
    [MobClick event:@"bt6" attributes:dict];
}

- (void)stopGif
{
//    NSLog(@"*****");
    [_gifView stopGif];
    
    NSDictionary *dict = @{@"type" : @"button", @"quantity" : @"6"};
    [MobClick event:@"bt7" attributes:dict];
}

@end
