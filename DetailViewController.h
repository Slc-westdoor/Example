//
//  DetailViewController.h
//  MyADDressBook
//
//  Created by Slc on 15/8/30.
//  Copyright (c) 2015年 Slc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController

@property(strong,nonatomic)UIImageView * imageView;
@property(strong,nonatomic)UILabel * labName;
@property(strong,nonatomic)UILabel * labModel;
@property(strong,nonatomic)UILabel * labIPhone;
@property(strong,nonatomic)UILabel * labWorkEmail;
@property(strong,nonatomic)UILabel * labHomeEmail;

@property(strong,nonatomic)NSNumber * personIDAsNumber;

-(void)getPersonInfo:(NSArray *)infoArr;

@end
