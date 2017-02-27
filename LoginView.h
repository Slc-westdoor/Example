//
//  LoginView.h
//  EXAMPLE
//
//  Created by Slc on 15/6/10.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    BOOL flg;
    UIButton *Bt;
    UIButton * ActionButton;
    UIImageView * imgs;
}

@property(nonatomic,retain)UITableView *tabView;
@property(nonatomic,retain)UITextField *userNameTextField;
@property(nonatomic,retain)UITextField *passWordTextField;
@property(nonatomic,strong)UIImageView *imgView;


@end
