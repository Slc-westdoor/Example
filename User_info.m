//
//  User_info.m
//  EXAMPLE
//
//  Created by Slc on 15/6/8.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import "User_info.h"
#import "Tool.h"
#import "User_InfoList.h"

@implementation User_info

-(void)viewDidLoad{
    [super viewDidLoad];
    [self init_NavigationItems];
}

-(void)init_NavigationItems
{
    UINavigationBar *navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44+20)];
    // [navigationBar setBackgroundImage:[UIImage imageNamed:@"sp_unfold_red@2x"] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:navigationBar];
    
    [navigationBar pushNavigationItem:[Tool addNavigationItemLeft:nil Title:[NSString stringWithFormat:@"%@的日报",_name] bartitle:@"Cancel" color:[UIColor whiteColor] barcolor:[UIColor whiteColor] target:self action:@selector(goBack)]animated:NO];
    
    [self.tabBarController.tabBar setHidden:NO];
    
}

-(void)sendInfo:(NSString *)name{
    _name = name;

}

-(void)goBack{
    User_InfoList *UserVC = [[User_InfoList alloc]init];
    [self presentViewController:UserVC animated:YES completion:nil];
}
@end
