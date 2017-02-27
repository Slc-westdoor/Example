//
//  LoginView.m
//  EXAMPLE
//
//  Created by Slc on 15/6/10.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import "LoginView.h"
#import "activationView.h"

@implementation LoginView



-(void)viewDidLoad{
    [super viewDidLoad];
    [self init_VC];
}

-(void)init_VC{
    
    flg =YES;
    CGFloat width = self.view.frame.size.width;
    self.view.backgroundColor=[UIColor colorWithWhite:0.9 alpha:0.5];
    _tabView = [[UITableView alloc]initWithFrame:CGRectMake(15, 150, width-30, 160) style:UITableViewStyleGrouped];
    _tabView.backgroundColor=[UIColor clearColor];
    _tabView.delegate=self;
    _tabView.dataSource=self;
    //取消分隔线
    [_tabView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tabView setScrollEnabled:NO];
    
    [self.view addSubview:_tabView];
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(width/2-40, 80, 80, 80)];
    _imgView.image=[UIImage imageNamed:@"denglu001_480"];
    [self.view addSubview:_imgView];
    
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(45, 300, 100, 25)];
    lab.text=@"记住密码";
    [lab setTextColor:[UIColor grayColor]];
    
    Bt =[[UIButton alloc]initWithFrame:CGRectMake(15, 300, 25, 25)];
    [Bt setBackgroundImage:[UIImage imageNamed:@"dneglu0040_@3x"] forState:UIControlStateNormal];
    [Bt addTarget:self action:@selector(BtClickedAcation) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *bt =[[UIButton alloc]initWithFrame:CGRectMake(215, 300, 100, 25)];
    [bt setTitle:@"激活账号" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(btClickedAcation) forControlEvents:UIControlEventTouchUpInside];
    
    ActionButton =[[UIButton alloc]initWithFrame:CGRectMake(65, 360, width-130, 45)];
    [ActionButton setBackgroundImage:[UIImage imageNamed:@"dneglu005_720"] forState:UIControlStateNormal];
    [ActionButton addTarget:self action:@selector(AcationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [ActionButton setTitle:@"登录" forState:UIControlStateNormal];
    
    
    [self.view addSubview:lab];
    [self.view addSubview:bt];
    [self.view addSubview:Bt];
    [self.view addSubview:ActionButton];
    
   
}

-(void)btClickedAcation{
    activationView * actVC = [[activationView alloc]init];
    [self presentViewController:actVC animated:YES completion:nil];
}

-(void)BtClickedAcation{
    if(!flg){
        [Bt setBackgroundImage:[UIImage imageNamed:@"dneglu0040_@3x"] forState:UIControlStateNormal];
        flg = YES;
    }else{
        [Bt setBackgroundImage:[UIImage imageNamed:@"dneglu0041_@3x"] forState:UIControlStateNormal];
        flg = NO;
    }
}

-(void)AcationButtonClicked{
    
}



#pragma mark - row height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  1.0f;
}

#pragma mark -允许数据源告知必须加载到Table View中的表的Section数。
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark -每一行的内容为数组相应索引的值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"loginCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone; // 设置不能点击
    }
    
    
    CGFloat leftX = 40.0f;
    CGFloat width = self.view.frame.size.width;
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView * img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"denglu007_480"]];
    img.frame=CGRectMake(leftX, 5, 1, 30);
    imgs = [[UIImageView alloc]init];
    
    
    UITextField * textField = nil;
    UIImageView *imgview = nil;
    if (0 == indexPath.section ) {
        
        _userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(leftX+15, 0, width-leftX-25, 40)];
        textField = _userNameTextField;
        _userNameTextField.placeholder = @"请输入您的NT账号";
        [_userNameTextField setClearButtonMode:UITextFieldViewModeNever];
        [_userNameTextField becomeFirstResponder];
        
        imgview = imgs;
        imgs.image=[UIImage imageNamed:@"denglu006_480"];
        imgs.frame=CGRectMake(0 ,0, width-28, 42);
        _imgView.image=[UIImage imageNamed:@"denglu002_480"];

      
    }
    else if(1 == indexPath.section ){
        
        _passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(leftX+15, 0, width-leftX-25, 40)];
        textField = _passWordTextField;
        imgview = imgs;
        
        _passWordTextField.placeholder = @"请输入您的密码";
        _passWordTextField.secureTextEntry = YES;
        
        imgs.image=[UIImage imageNamed:@"denglu006_480"];
        imgs.frame=CGRectMake(0 ,0, width-28, 42);
        
        _imgView.image=[UIImage imageNamed:@"denglu003_480"];
        
    }
    
    
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.keyboardType = UIKeyboardTypeNamePhonePad;
    //textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.delegate = self;
    textField.clearButtonMode = YES;
    textField.font = [UIFont systemFontOfSize:16];
    textField.returnKeyType = UIReturnKeyDone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.borderStyle = UITextBorderStyleNone;
    
    [cell.contentView addSubview:imgview];
    [cell.contentView addSubview:textField];
    [cell.contentView addSubview:_imgView];
    [cell.contentView addSubview:img];
    
    return cell;

}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // the user pressed the "Done" button, so dismiss the keyboard
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}


@end


