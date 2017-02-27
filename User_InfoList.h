//
//  User_InfoList.h
//  EXAMPLE
//
//  Created by Slc on 15/6/8.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendeDlegate <NSObject>

-(void)sendInfo:(NSString *)name;

@end

#import "GXCustomButton.h"
@interface User_InfoList : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>{
    int flag[20];
    
    NSArray *filterData;
    UISearchBar *mySearchBar;
    UISearchDisplayController *mySearchDisplayController;
    NSString *name;
   
}

@property(nonatomic,retain)NSMutableArray * indexArray;
//设置每个section下的cell内容
@property(nonatomic,retain)NSMutableArray * LetterResultArr;

@property(nonatomic,retain)UITableView * UserTableView;

@property (nonatomic,assign)id<sendeDlegate>sendDlegate;

@end
