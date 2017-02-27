//
//  example2Cell.m
//  EXAMPLE
//
//  Created by Slc on 15/9/16.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import "example2Cell.h"

@implementation example2Cell

+(instancetype)cellWithTableView:(UITableView*)tableView
{     static NSString *ID = @"weibo";
    example2Cell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[example2Cell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]){
        count = 0;
        CGRect frame = [self frame];
        
        self.imagView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 60, 70)];
        [self.contentView addSubview:self.imagView];
        
        UILabel * labt =[[UILabel alloc]initWithFrame:CGRectMake(75, 0, self.frame.size.width-65, 45)];
        [labt setFont:[UIFont systemFontOfSize:14.0f]];
        labt.numberOfLines =3;
        self.labTop = labt;
        [self.contentView addSubview:self.labTop];
        
        UILabel * labl =[[UILabel alloc]initWithFrame:CGRectMake(75, 50, 55, 25)];
        self.labLeft = labl;
        [self.contentView addSubview:self.labLeft];
        
        UILabel * labr =[[UILabel alloc]initWithFrame:CGRectMake(220, 50, 33, 25)];
        labr.textAlignment =NSTextAlignmentCenter;
        self.labRight = labr;
        [self.contentView addSubview:self.labRight];
        
        btl = [[UIButton alloc]initWithFrame:CGRectMake(190, 50, 25, 25)];
        btl.tag = 0;
        [btl addTarget:self action:@selector(clickedAcation:) forControlEvents:UIControlEventTouchUpInside];
        self.butLeft = btl;
        [self.contentView addSubview:self.butLeft];
        
        btr = [[UIButton alloc]initWithFrame:CGRectMake(260, 50, 25, 25)];
        btr.tag = 1;
        [btr addTarget:self action:@selector(clickedAcation:) forControlEvents:UIControlEventTouchUpInside];
        self.butRight = btr;
        [self.contentView addSubview:self.butRight];
        
        frame.size.height = 80;
        self.frame =frame;
    }
    return self;
}

-(void)loadData:(NSMutableDictionary *)dic{
    self.dataDic = dic;
    self.imagView.image = [UIImage imageNamed:[dic objectForKey:@"imageStr"]];
    self.labTop.text = [dic objectForKey:@"toptitle"];
    self.labLeft.text = [NSString stringWithFormat:@"¥: %@",[dic objectForKey:@"usedAmount"]];
    self.labRight.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]];
    [btl setImage:[UIImage imageNamed:[dic objectForKey:@"powerbuttonoff"]] forState:UIControlStateNormal];
    [btr setImage:[UIImage imageNamed:[dic objectForKey:@"powerbuttonon"]] forState:UIControlStateNormal];
}

-(void)clickedAcation:(UIButton *)sender{
    if(sender.tag == 0){
        if(count > 0){
            count --;
            
        }else{
            return;
        }
    }else{
        if(count <=99){
            count ++;
        }else{
            return;
        }
    }
    self.labRight.text = [NSString stringWithFormat:@"%ld",(long)count];
    [self.dataDic setObject:self.labRight.text forKey:@"count"];
}

@end
