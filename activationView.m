//
//  activationView.m
//  EXAMPLE
//
//  Created by Slc on 15/6/10.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import "activationView.h"
#import "Tool.h"
#import "LoginView.h"

@implementation activationView

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self initNavigationItems];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)initNavigationItems
//{
//    UINavigationBar *navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44+20)];
//    [navigationBar setBackgroundImage:[UIImage imageNamed:@"sp_unfold_red@2x"] forBarMetrics:UIBarMetricsDefault];
//    [navigationBar setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:navigationBar];
//    
//    [navigationBar pushNavigationItem:[Tool addNavigationItemLeft:nil Title:@"激活账号" bartitle:@"back" color:[UIColor whiteColor] barcolor:nil target:self action:@selector(goBack)] animated:NO];
//    
//}

-(void)goBack{
    LoginView *vc=[[LoginView alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
