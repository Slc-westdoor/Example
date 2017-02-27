//
//  HYPWWheelViewControll.m
//  EXAMPLE
//
//  Created by Slc on 15/7/23.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import "HYPWWheelViewControll.h"
#import "HYPWheelView.h"
#import "Tool.h"
#import "EFAnimationViewController.h"

@implementation HYPWWheelViewControll

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view .backgroundColor =[UIColor grayColor];
    [self initNavigationItems];
    HYPWheelView *wheelView = [HYPWheelView wheelView];
    wheelView.center = self.view.center;
    [self.view addSubview:wheelView];
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
    
    [self dismissViewControllerAnimated:YES completion:nil];
    EFAnimationViewController * efVC = [[EFAnimationViewController alloc]init];
    [self presentViewController:efVC animated:YES completion:nil];
}


@end
