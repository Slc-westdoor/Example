//
//  exampleCell.h
//  EXAMPLE
//
//  Created by Slc on 15/9/16.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface exampleCell : UITableViewCell

@property(nonatomic,retain)UILabel *topLabel;
@property(nonatomic,retain)UILabel *leftLabel;
@property(nonatomic,retain)UILabel *medLabel;
@property(nonatomic,retain)UILabel *rightLabel;
@property(nonatomic,retain)UIImageView * imgView;

+(instancetype)cellWithTableView:(UITableView*)tableView;

-(void)loadData:(NSDictionary *)dic;

@end
