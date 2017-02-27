//
//  homeView.h
//  EXAMPLE
//
//  Created by 王雅强 on 15/3/31.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "EFAnimationViewController.h"
#import "SLGSlideshowView.h"

@interface homeView : UIViewController<SLGSlideshowViewDatasource,SLGSlideshowViewDelegate>{
    NSArray *_slideshowData;
    NSArray *_transitionOptions;
}
@property(nonatomic,readwrite)SLGSlideshowView *slideShowView;
@property(nonatomic,retain)NSArray * arr;

@property (nonatomic, strong) EFAnimationViewController *viewController;

@end
