//
//  touchView.m
//  EXAMPLE
//
//  Created by Slc on 15/9/28.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import "touchView.h"

@implementation touchView

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        //CGFloat hight = super.frame.size.height;
        Frame = frame;
        
        self.frame = CGRectMake(0, Frame.size.height/2, 50, 50);
        self.layer.cornerRadius = self.frame.size.width / 2;
        
        self.backgroundColor = [UIColor lightGrayColor];
    
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, 45, 45)];
        [lab setFont:[UIFont systemFontOfSize:10.0f]];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.numberOfLines=3;
        lab.text=@"头像处理";
        lab.userInteractionEnabled=YES;
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
        
        [lab addGestureRecognizer:labelTapGestureRecognizer];

        [self addSubview:lab];
        self.userInteractionEnabled = YES;
        
    }
    return self;
}


-(void)labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    
    UILabel *label=(UILabel*)recognizer.view;
    NSLog(@"%@被点击了",label.text);
    self.hidden=YES;
    UIActionSheet *sheet = [[UIActionSheet alloc]init];
    sheet.delegate = self;
 
    sheet  = [[UIActionSheet alloc] initWithTitle:@"头像处理" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消操作" otherButtonTitles:@"保存头像到本地", @"其它",nil];
    
    sheet.tag = 255;
    
    [sheet showInView:self];

}

#pragma mark - action sheet delegte
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    image = [[UIImage alloc]init];
    UIImageView * imgview = [[UIImageView alloc]init];
    imgview = [[self superview] superview].subviews[1];
    image = imgview.image;

    self.hidden=NO;
    if (actionSheet.tag == 255) {
            switch (buttonIndex) {
                case 0:
                    
                    return;
                case 1:
                    
                    if (image != nil){
                        UIImageWriteToSavedPhotosAlbum(image,self,@selector(thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:), nil);
                    }
                    break;
                case 2:
                    
                    break;
            }
        }

}

- (void)thisImage:(UIImage *)image hasBeenSavedInPhotoAlbumWithError:(NSError *)error usingContextInfo:(void*)ctxInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!"
                                                        message:[NSString stringWithFormat:@"Saved with error %@", error.description]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Succes!"
                                                        message:@"Saved to camera roll"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //保存触摸起始点位置
    CGPoint point = [[touches anyObject] locationInView:self];
    startPoint = point;
    
    //该view置于最前
    [[self superview] bringSubviewToFront:self];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //计算位移=当前位置-起始位置
    CGPoint point = [[touches anyObject] locationInView:self];
    float dx = point.x - startPoint.x;
    float dy = point.y - startPoint.y;
    
    //计算移动后的view中心点
    CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);
    
    /* 限制不可将视图托出屏幕 */
    float halfx = CGRectGetMidX(self.bounds);
    //x坐标左边界
    newcenter.x = MAX(halfx, newcenter.x);
    //x坐标右边界
    newcenter.x = MIN(self.superview.bounds.size.width - halfx, newcenter.x);
    
    //y坐标同理
    float halfy = CGRectGetMidY(self.bounds);
    newcenter.y = MAX(halfy, newcenter.y);
    newcenter.y = MIN(self.superview.bounds.size.height - halfy, newcenter.y);
    
    //移动view
    self.center = newcenter;
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    CGFloat x = Frame.size.width/2;
    
    CGFloat Value_x = self.frame.size.width/2;
    CGFloat with = Frame.size.width;
    
    NSLog(@"X:%f;Y:%f",self.center.x,self.center.y);
    
    if(self.center.x < x){
        self.frame = CGRectMake(0, self.center.y -25, self.frame.size.width, self.frame.size.height);
    }else if(x < self.center.x){
        self.frame = CGRectMake(with - Value_x*2, self.center.y -25, self.frame.size.width, self.frame.size.height);
    }
    
}

@end
