//
//  rootViewContoller.m
//  EXAMPLE
//
//  Created by 王雅强 on 15/3/31.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import "rootViewContoller.h"
#import "homeView.h"
#import "serviceView.h"
#import "ProductView.h"
#import "settingView.h"
#import "ViewController.h"

#define TABBAR_BUTTON_W     80
#define TABBAR_BUTTON_H     40

#define UISCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define UISCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface rootViewContoller ()

{
    BOOL checkIfClear;
}

-(void)_initViewController;

@end


@implementation rootViewContoller

-(id)initIfClear:(BOOL)ifClear{
    self = [super init];
    if(self){
        checkIfClear = ifClear;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tabBar setHidden:YES];
    [self _initTabBarView];
    [self _initViewController];
    
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:YES];
//    LoginVC *loginVC = [[LoginVC alloc]initMyLoginViewController];
//    [self presentViewController:loginVC animated:YES completion:nil];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//初始化子控制器
-(void)_initViewController{
    
    homeView *homeVC = [[homeView alloc] init];
    
    serviceView *serviceVC = [[serviceView alloc] init];
    
    ProductView *productVC = [[ProductView alloc]init];
    
    settingView *settingVC = [[settingView alloc] init];
    
    NSArray *views = @[homeVC,serviceVC,productVC,settingVC];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:4];
    
    for (UIViewController *viewController in views) {
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
        nav.navigationBarHidden=YES;
        [viewControllers addObject:nav];
       
    }
    if(self.viewControllers){
        self.viewControllers=nil;
    }
    self.viewControllers = viewControllers;
}

//自定义tabbar
-(void)_initTabBarView{
    
    self.tabBar.hidden = YES; //隐藏原先的tabBar
    CGFloat tabBarViewY = self.view.frame.size.height - 49;
    
    _tabBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, tabBarViewY, UISCREEN_WIDTH, 49)];
    _tabBarView.userInteractionEnabled = YES; //这一步一定要设置为YES，否则不能和用户交互
    _tabBarView.image = [UIImage imageNamed:@"nav_tabbar"];
    [self.view addSubview:_tabBarView];
    
    
    NSArray *background = @[@"home",@"serve",@"goods",@"me"];
    NSArray *hiltBackground = @[@"home2",@"serve2",@"goods2",@"me2"];
    NSArray *title=@[@"主页",@"服务",@"商品",@"我"];
    
    for (NSUInteger i = 0; i < background.count; i++) {
        
        NSString *img = background[i];
        NSString *hiltImg = hiltBackground[i];
        NSString *titleStr = title[i];
        // 下面的方法是调用自定义的生成按钮的方法
        [self creatButtonWithNormalName:img andSelectName:hiltImg andTitle:titleStr andIndex:i];
    
        
    }
    GXCustomButton *btn = _tabBarView.subviews[0];
    [self changeViewController:btn]; //自定义的控件中的按钮被点击了调用的方法，默认进入界面就选中第一个按钮
    
}

#pragma mark 创建一个按钮
- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(NSUInteger)index
{
    // GXCustomButton *button = [GXCustomButton buttonWithType:UIButtonTypeCustom];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = index;
    
    CGFloat buttonW = _tabBarView.frame.size.width / 4;
    CGFloat buttonH = _tabBarView.frame.size.height;
    button.frame = CGRectMake(80 *index, 0, buttonW, buttonH);
    
    [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selected] forState:UIControlStateDisabled];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
    
    [button addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    //UIEdgeInsets insets = {25, 5, 10, 10};
    //里面的四个参数表示距离上边界、左边界、下边界、右边界的距离，默认都为零，title／image在button的正中央
    button.imageEdgeInsets=UIEdgeInsetsMake(5, buttonW/2-10, 20, 20);
    button.titleEdgeInsets=UIEdgeInsetsMake(25, 1, 5, 20);
    button.titleLabel.font = [UIFont systemFontOfSize:12]; // 设置标题的字体大小
    
    [_tabBarView addSubview:button];
    
}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(GXCustomButton *)sender{
    self.selectedIndex = sender.tag;//切换不同控制器的界面
    NSLog(@"%d",sender.tag);
    sender.enabled = NO;
    
    if (_previousBtn != sender) {
        
        _previousBtn.enabled = YES;
        
    }
    
    _previousBtn = sender;
}
-(void)sendLoginFlag:(int)flg
{
    
    
}

//
//#pragma mark - LoginStatusDelegate
//-(void)loginSuccess{
//    //[self performSelector:@selector(dismissLoginVC) withObject:nil afterDelay:0.5];
//    [self performSelector:@selector(dismissLoginVC)];
//}
//
//-(void)dismissLoginVC{
//    //登陆页面隐去
//    [self.loginVC dismissViewControllerAnimated:YES completion:^{}];
//}

@end
