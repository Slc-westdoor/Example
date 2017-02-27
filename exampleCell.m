//
//  exampleCell.m
//  EXAMPLE
//
//  Created by Slc on 15/9/16.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import "exampleCell.h"

@implementation exampleCell

+(instancetype)cellWithTableView:(UITableView*)tableView
{
    static NSString *ID = @"weibo";
      exampleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[exampleCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]){
        
        CGFloat with = self.frame.size.width;
        CGRect frame = [self frame];
        
        self.imgView  = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 80, 80)];
        [self.contentView addSubview:self.imgView];
        
        UILabel * topLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 0,with-100, 70)];
        topLabel.textAlignment = NSTextAlignmentLeft;
        [topLabel setFont:[UIFont systemFontOfSize:13.0f]];
        self.topLabel = topLabel;
        topLabel.numberOfLines = 5;
        [self.contentView addSubview:self.topLabel];
        
        UILabel * leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 65,(with-50)/3-60, 20)];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        [leftLabel setFont:[UIFont systemFontOfSize:15.0f]];
        self.leftLabel = leftLabel;
        [self.contentView addSubview:self.leftLabel];
        
        UILabel * medLabel = [[UILabel alloc]initWithFrame:CGRectMake(with/3+25, 65,(with-60)/3-30, 20)];
        medLabel.textAlignment = NSTextAlignmentLeft;
        [medLabel setFont:[UIFont systemFontOfSize:15.0f]];
        self.medLabel = medLabel;
        [self.contentView addSubview:self.medLabel];
        
        UILabel * rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(2*with/3-30, 65,(with-50)/3+50, 20)];
        rightLabel.textAlignment = NSTextAlignmentLeft;
        [rightLabel setFont:[UIFont systemFontOfSize:15.0f]];
        self.rightLabel = rightLabel;
        [self.contentView addSubview:self.rightLabel];
        
        frame.size.height = leftLabel.frame.size.height + 70;
        self.frame =frame;
    }
    return  self;
}

-(void)loadData:(NSDictionary *)dic{
    NSString * topStr = [dic objectForKey:@"toptitle"];
    NSString * leftStr = [dic objectForKey:@"usedAmount"];
    NSString * medStr = [dic objectForKey:@"unitName"];
    NSString * rightStr = [dic objectForKey:@"productName"];
    
    self.topLabel.text = topStr;
    self.leftLabel.text = leftStr;
    self.medLabel.text = medStr;
    self.rightLabel.text = rightStr;
    self.imgView.image=[UIImage imageNamed:[dic objectForKey:@"imageStr"]];

}

@end
