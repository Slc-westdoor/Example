//
//  ColorConstants.h
//  EXAMPLE
//
//  Created by Slc on 15/7/20.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#ifndef EXAMPLE_ColorConstants_h
#define EXAMPLE_ColorConstants_h

#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

// 判断是否为iOS7
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define Font(F) [UIFont systemFontOfSize:(F)]

#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define kWindowWidth                        ([[UIScreen mainScreen] bounds].size.width)
#define kWindowHeight                       ([[UIScreen mainScreen] bounds].size.height)

#endif
