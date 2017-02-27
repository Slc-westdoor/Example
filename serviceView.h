//
//  serviceView.h
//  EXAMPLE
//
//  Created by 王雅强 on 15/3/31.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "Tool.h"
#import "JSON.h"
#import "SvGifView.h"
#import "WZXPopViewController.h"

@interface serviceView : WZXPopViewController<ASIHTTPRequestDelegate>{
    SvGifView * _gifView;
}

@property( nonatomic ,strong)ASIFormDataRequest * request;
@property( nonatomic ,strong)NSMutableData * receiveData;
@end
