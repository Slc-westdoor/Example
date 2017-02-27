//
//  ProductView.m
//  EXAMPLE
//
//  Created by 王雅强 on 15/3/31.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import "ProductView.h"
#import "Tool.h"
#import "ChineseString.h"
#import "exampleCell.h"
#import "example2Cell.h"
#import "musicView.h"
#import "UMMobClick/MobClick.h"
@interface ProductView (){
    NSMutableDictionary * dic;
    NSArray * arr;
    BOOL tag;
}

@end

@implementation ProductView

- (void)viewDidLoad {
    [super viewDidLoad];
    tag = NO;
    self.view.backgroundColor= [UIColor colorWithWhite:0.9 alpha:0.5];
    [self initNavigationItems];
    [self init_tabelview];
    
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
    [navigationBar pushNavigationItem:[Tool addNavigationItemLeft:nil Title:@"商品" bartitle:@"..." color:[UIColor whiteColor] barcolor:[UIColor whiteColor] target:self action:@selector(animation)] animated:NO];
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(100, 70, 110, 30)];
    [button setTitle:@"Tag" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeTagValue) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor brownColor]];
    [self.view addSubview:button];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"ThreePage"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"ThreePage"];
}

//转场动画
-(void)animation{

}

-(void)init_tabelview{
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(5, 110, self.view.frame.size.width-10, self.view.frame.size.height-200) style:UITableViewStylePlain];
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    imgView.image = [UIImage imageNamed:@"qieh_btn2"];
    _tabelView.tableHeaderView.backgroundColor = [UIColor brownColor];
    _tabelView.delegate=self;
    _tabelView.dataSource=self;
    [self.view addSubview:_tabelView];

}


-(void)changeTagValue{
    if(tag){
        tag = NO;
    }else{
        tag = YES;
    }
    if(tag){
        arr =[[NSArray alloc]initWithObjects:@"exer_icon_biology_hover",@"exer_icon_chemistry_hover",@"exer_icon_chinese_hover",@"exer_icon_english_hover",@"exer_icon_geography_hover", nil];
        dic = [[NSMutableDictionary alloc]init];
        [dic setValue:@"5.0" forKey:@"usedAmount"];
        [dic setValue:@"分钟" forKey:@"unitName"];
        [dic setValue:@"民生170-20元产品" forKey:@"productName"];
        [dic setValue:@"的身份和化肥额外热舞海口市，地方被浪费不发货物流费本网发布额违反本办法备份数据库，的爆发设备不说了宝贝布里斯班覅覅额外!" forKey:@"toptitle"];
    }else{
        arr =[[NSArray alloc]initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg", nil];
        dic = [[NSMutableDictionary alloc]init];
        [dic setValue:@"powerbuttonoff" forKey:@"powerbuttonoff"];
        [dic setValue:@"powerbuttonon" forKey:@"powerbuttonon"];
        [dic setValue:@"30.0" forKey:@"usedAmount"];
        [dic setValue:@"0" forKey:@"count"];
        [dic setValue:@"瓜娃子，棒老孩儿，青钩子，方老壳，哈闷灯儿，蛤蟆皮，而罗霍尔!" forKey:@"toptitle"];
    }
    
    [_tabelView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tag){
        static NSString * cellIdntify = @"cell";
        
        exampleCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdntify];
        if (cell == nil) {
            cell = [[exampleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdntify];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [dic setValue:arr[indexPath.row] forKey:@"imageStr"];
        [cell loadData:dic];
        return cell;
    }else{
        
        static NSString * cellIdntify = @"cell";
        
        example2Cell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdntify];
        
        if (cell == nil) {
            
            cell = [[example2Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdntify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [dic setValue:arr[indexPath.row] forKey:@"imageStr"];
            [cell loadData:dic];
            return cell;

        }
     return cell;
    }

    
}

//获取当前时间 格式为2015年4月1日
-(NSString *)getCurrentDate{
    
    //获取当前时间
    NSDate *now = [NSDate date];
    NSString *str = [NSString stringWithFormat:@"%@",now];
    NSMutableString *mutStr = [NSMutableString stringWithString:str];
    //NSLog(@"mutStr:%@", mutStr);
    NSLog(@"mutStr:%@", [mutStr substringToIndex:19]);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSUInteger year = [dateComponent year];
    NSUInteger month = [dateComponent month];
    NSUInteger day = [dateComponent day];
    
    NSString *dateStr = [NSString stringWithFormat:@"%lu年%lu月%lu日" ,(unsigned long)year,(unsigned long)month,(unsigned long)day];

    return dateStr;
    
}


@end
