//
//  rootViewContoller.h
//  EXAMPLE
//
//  Created by 王雅强 on 15/3/31.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GXCustomButton.h"

@interface rootViewContoller : UITabBarController

{
    UIImageView *_tabBarView; //自定义的覆盖原先的tarbar的控件
    GXCustomButton *_previousBtn; //记录前一次选中的按钮
    UILabel *l2;

}
@end
