//
//  imageViewController.h
//  HorizontalCollectionCellExample
//
//  Created by Slc on 15/7/28.
//  Copyright (c) 2015年 Muratcan Celayir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imageViewController : UINavigationController<UIScrollViewDelegate>{
    UIImage *imge;
    UIScrollView *_scrollview;
    UIImageView *imgview;
}

-(void)getImage:(UIImage *)img;
@end
