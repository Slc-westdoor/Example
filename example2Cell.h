//
//  example2Cell.h
//  EXAMPLE
//
//  Created by Slc on 15/9/16.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface example2Cell : UITableViewCell{
    NSInteger count;
    UIButton * btl;
    UIButton * btr;
    NSUserDefaults * userdefault ;
}
@property(nonatomic,retain)NSMutableDictionary *dataDic;
@property(nonatomic,retain)UIButton *butLeft;
@property(nonatomic,retain)UIButton *butRight;
@property(nonatomic,retain)UILabel *labTop;
@property(nonatomic,retain)UILabel *labLeft;
@property(nonatomic,retain)UILabel *labRight;
@property(nonatomic,retain)UIImageView *imagView;

+(instancetype)cellWithTableView:(UITableView*)tableView;

-(void)loadData:(NSMutableDictionary *)dic;
@end
