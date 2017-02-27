//
//  ViewController.h
//  MyADDressBook
//
//  Created by Slc on 15/8/28.
//  Copyright (c) 2015年 Slc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>{
    NSInteger sectionNumber;
    NSInteger recordID;
    NSString *name;
    NSString *email;
    NSString *tel;
    UIImageView *imge;
    
    NSMutableArray *addressBookTemp;
}
@property NSInteger sectionNumber;
@property NSInteger recordID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *tel;
@property (nonatomic, retain) UIImageView *imge;
//-(void)filterContentForsearchText:(NSString *)searchText;

//@property(nonatomic,retain)UITableView * UserTableView;

@end

