//
//  CollecViewCell.m
//  EXAMPLE
//
//  Created by Slc on 16/4/5.
//  Copyright © 2016年 slc. All rights reserved.
//

#import "CollecViewCell.h"

@implementation CollecViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
   
        // Initialization code
        self.backgroundColor = [UIColor purpleColor];
        
        self.imgeView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, CGRectGetWidth(self.frame)-10)];
        self.imgeView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.imgeView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imgeView];
        
        self.text = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imgeView.frame), CGRectGetWidth(self.frame)-10, 20)];
        self.text.backgroundColor = [UIColor brownColor];
        self.text.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.text];
        
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.frame = CGRectMake(5, CGRectGetMaxY(self.text.frame), CGRectGetWidth(self.frame)-10,30);
        [self.btn setTitle:@"按钮" forState:UIControlStateNormal];
        self.btn.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.btn];
    }
    return self;
}



@end
