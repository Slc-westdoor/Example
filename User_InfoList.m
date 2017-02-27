//
//  User_InfoList.m
//  EXAMPLE
//
//  Created by Slc on 15/6/8.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import "User_InfoList.h"
#import "ChineseString.h"
#import "Tool.h"
#import "User_info.h"
#import "ProgressView.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "NSData+Base64.h"
#import "StringConstants.h"
#import "ProgressView.h"


@interface User_InfoList ()

@property( nonatomic ,strong)ASIFormDataRequest * request;

@end

@implementation User_InfoList
@synthesize indexArray;
@synthesize LetterResultArr;

- (void)viewDidLoad
{
    self.view.backgroundColor=[UIColor whiteColor];
    [super viewDidLoad];
    
    [self initMysearchBarAndMysearchDisPlay];
    [self init_NavigationItems];
    [self init_tableView];
    [self init_Data];
    [self requestUserInfo];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//初始化TableView
-(void)init_tableView{
    _UserTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 109, self.view.frame.size.width, self.view.frame.size.height-109) style:UITableViewStylePlain];
    _UserTableView.backgroundColor=[UIColor whiteColor];
    _UserTableView.delegate=self;
    _UserTableView.dataSource=self;
    //取消分隔线
   // [_UserTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [self.view addSubview:_UserTableView];
}

-(void)initMysearchBarAndMysearchDisPlay
{
    mySearchBar = [[UISearchBar alloc] init];
    mySearchBar.delegate = self;
    mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,45)];
                                                                

    //    //设置选项
    //    [mySearchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"First",@"Last",nil]];
    [mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [mySearchBar sizeToFit];
    mySearchBar.backgroundColor = [UIColor grayColor];
    mySearchBar.keyboardType=UIKeyboardTypeNamePhonePad;
    //[mySearchBar becomeFirstResponder];
    
    //加入列表的header里面
    _UserTableView.tableHeaderView = mySearchBar;
    
    mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self];
    mySearchDisplayController.delegate = self;
    mySearchDisplayController.searchResultsDataSource = self;
    mySearchDisplayController.searchResultsDelegate = self;
    
    
    [self.view addSubview:mySearchBar];
    
}

-(void)init_NavigationItems
{
    UINavigationBar *navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44+20)];
   // [navigationBar setBackgroundImage:[UIImage imageNamed:@"sp_unfold_red@2x"] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:navigationBar];
    
    [navigationBar pushNavigationItem:[Tool addNavigationItemRight:nil Title:@"用户信息" bartitle:nil color:[UIColor whiteColor] barcolor:[UIColor whiteColor] target:self action:nil] animated:NO];
    
    [self.tabBarController.tabBar setHidden:NO];
    
}


-(void)init_Data{
    NSArray *stringsToSort=[[NSArray alloc]initWithObjects:@"张琅",
                            @"易召强",
                            @"王成林",
                            @"王威",
                            @"孙威航",
                            @"刘阳",
                            @"于曌",
                            @"刘欣惝",
                            @"张有权",
                            @"张有明",
                            @"刘金鑫",
                            @"邓嘉越",
                            @"程帅",
                            @"冯维",
                            @"张思舜",
                            @"刘涛",
                            @"张博楠",
                            @"宋路成",
                            @"赵祥",
                            @"徐超",
                            @"王健",
                            @"姜博文",
                            @"阿里郎",
                            @"陈嘉恒",
                            nil];
    
    self.indexArray = [ChineseString IndexArray:stringsToSort];
    self.LetterResultArr = [ChineseString LetterSortArray:stringsToSort];
    
//    for (int i=0; i<self.LetterResultArr.count; i++) {
//        NSLog(@"%@",[self.LetterResultArr objectAtIndex:i]);
//    }

    
}

#pragma mark -Section的Header的值
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [indexArray objectAtIndex:section];
    return key;
}

#pragma mark - row height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35.0;
}

#pragma mark -
#pragma mark Table View Data Source Methods
#pragma mark -设置右方表格的索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return indexArray;
}
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [Tool showPrompt:title inView:self.view delay:0.5];

    return index;
}

#pragma mark -允许数据源告知必须加载到Table View中的表的Section数。
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [indexArray count];
}

#pragma mark -设置表格的行数为数组的元素个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.UserTableView) {
        if (flag[section] == 0) {
            return [[self.LetterResultArr objectAtIndex:section] count];
        } else{
                 //收拢
                 return  0;
              }
        
    }else{
        _UserTableView.clearsContextBeforeDrawing=YES;
        // 谓词搜索
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",mySearchDisplayController.searchBar.text];
        filterData =  [[NSArray alloc] initWithArray:[[self.LetterResultArr objectAtIndex:section] filteredArrayUsingPredicate:predicate]];
        return filterData.count;
         }

}

#pragma mark -每一行的内容为数组相应索引的值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
       // cell.textLabel.text = [[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    if (tableView == self.UserTableView) {
        cell.textLabel.text = [[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    }else{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",mySearchDisplayController.searchBar.text];
        filterData =  [[NSArray alloc] initWithArray:[[self.LetterResultArr objectAtIndex:indexPath.section] filteredArrayUsingPredicate:predicate]];
        cell.textLabel.text = filterData[indexPath.row];
    }

     return cell;
}
#pragma mark - Select内容为数组相应索引的值
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    name = [[NSString alloc]initWithFormat:@"%@",[[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]];
    [Tool showPrompt:name inView:self.view delay:0.3];
        //[self presentViewController:userVC animated:YES completion:nil];
    [self performSelector:@selector(goToVc) withObject:nil afterDelay:0.5];

}

-(void)goToVc{
    User_info * userVC = [[User_info alloc]init];
    self.sendDlegate = userVC;
    [self.sendDlegate sendInfo:name];

    [self presentViewController:userVC animated:YES completion:nil];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //添加一个按钮 看不到的
    UIButton *bgButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 60, 40)];
    [bgButton addTarget:self action:@selector(changeDirection:) forControlEvents:UIControlEventTouchUpInside];
    [bgButton setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1]];
    [bgButton setTag:section];
    
    //添加点头 iconfinder.com
    UIImageView *directionView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 16, 16)];
    [bgButton addSubview:directionView];
    if (flag[section] == 0) {
        directionView.image = [UIImage imageNamed:@"down"];
        
    } else{
        directionView.image = [UIImage imageNamed:@"right"];
    }
    
    //组名
    //获取这个section的内容
    //得到好友的数组
    NSString *groupName = [indexArray objectAtIndex:section];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 60, 40)];
    nameLabel.text = groupName;
    [bgButton addSubview:nameLabel];
   // [bgButton setTitle:groupName forState:UIControlStateNormal];
    
    return bgButton;
}

- (void)changeDirection:(UIButton *)sender{
    NSInteger section = sender.tag;
    
    //改变当前这个section的状态
    //flag[section] = !flag[section];
    if (flag[section] == 0) {
        flag[section] = 1;
    }else {
        flag[section] = 0;
    }
    
    //刷新这个section
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    
    [_UserTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}

-(void)requestUserInfo{
    if(![Tool checkNetworkIsValid]){
        [Tool showSpinnerInView:self.view prompt:@"。"];
        [Tool showPrompt:@"当前没有可用网络" inView:self.view delay:1];
        return;
    }
        NSString * mappUrl = [NSString stringWithFormat:@"%@/%@",APP_SERVER_ADDRES,@"userLogin"];
        NSURL * url = [NSURL URLWithString:mappUrl];
        self.request = [ASIFormDataRequest requestWithURL:url];
    
        //号码从登陆那获得
        //NSString * encryName = [Tool TripleDES:@"17093074407" encryptOrDecrypt:kCCEncrypt];
        [_request addPostValue:@"123456" forKey:@"userPassword"];
        [_request addPostValue:@"zhangym9" forKey:@"userNt"];
        [_request setDelegate:self];
        [_request startAsynchronous];
        _request.timeOutSeconds =6;
        [Tool showSpinnerInView:self.view prompt:@"正在查询中"];
        [self getCurrentDate];
}


-(void)requestFinished:(ASIFormDataRequest *)request{
    if (request.responseStatusCode == 404 ) {
        [Tool showPrompt:@"网络请求超时，请稍候再试。" inView:self.view delay:1];
    } else{
            NSString * msg , * status , * flags;
        
            NSString * respStr = request.responseString;
            NSDictionary * dict = [respStr JSONValue];
            
            msg = [dict objectForKey:@"msg"];
            status = [dict objectForKey:@"status"];
            flags = [dict objectForKey:@"flag"];
        
            NSLog(@"%@",msg);
            NSLog(@"%@",status);
            NSLog(@"%@",flags);

            if ([status isEqualToString:@"1"]) {
                
                [Tool showPrompt:@"登录成功" inView:self.view delay:1.0];
            }
            
            else {
                // msg = @"用户名或服务密码错误，请重新输入";
                [Tool showPrompt:msg inView:self.view delay:1.0];
                
            }
  
    }
    
}


//- (void)requestStarted:(ASIHTTPRequest *)request{
//    NSLog(@"requestStarted%@",@"requestStarted");
//    
//    [Tool showSpinnerInView:self.view prompt:@"正在查询中"];

//}

- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSLog(@"requestFailed%@",request.error);
    [Tool showPrompt:@"网络请求超时，请稍候再试。" inView:self.view delay:1];
    
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
