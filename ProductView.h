//
//  ProductView.h
//  EXAMPLE
//
//  Created by 王雅强 on 15/3/31.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "musicView.h"
#import "layoutVC.h"

@interface ProductView : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tabelView;
@property(nonatomic,strong)musicView * musicVC;
@property(nonatomic,strong)layoutVC * layoutVC;

@end
