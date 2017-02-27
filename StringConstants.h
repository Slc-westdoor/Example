//
//  StringConstants.h
//  EXAMPLE
//
//  Created by Slc on 15/6/9.
//  Copyright (c) 2015年 slc. All rights reserved.
//
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define StatusBarHeight (IOS7==YES ? 0 : 20)
#define BackHeight      (IOS7==YES ? 0 : 15)

#define fNavBarHeigth (IOS7==YES ? 64 : 44)

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height-StatusBarHeight)
#ifndef EXAMPLE_StringConstants_h
#define EXAMPLE_StringConstants_h
//http://192.168.1.109:8080/daily-project/user/userLogin?userPassword=123456&userNt=zhangym9
#define APP_SERVER_ADDRESSINIT [NSString stringWithFormat:@"http://192.168.1.109:8080"]
#define APP_SERVER_ADDRES [NSString stringWithFormat:@"%@/daily-project/user",APP_SERVER_ADDRESSINIT]

//Nt账号
#define Nt [NSString stringWithFormat@"userNt"]
//电话号
#define Telphone [NSString stringWithFormat@"userTelphone"]
//登录密码
#define Password [NSString stringWithFormat@"userPassword"]
//关注或取消的Nt账号
#define attentionNt [NSString stringWithFormat@"attentionNt"]
//日报信息
#define dailyInfo [NSString stringWithFormat@"dailyInfo"]
//预警标志
#define dailyWarningStatus [NSString stringWithFormat@"dailyWarningStatus"]
//预警内容
#define dailyWarning [NSString stringWithFormat@"dailyWarning"]
//日报内容
#define dailyContent [NSString stringWithFormat@"dailyContent"]
//日报时间
#define dailyCreateDate [NSString stringWithFormat@"dailyCreateDate"]
//@对象（数组［@的人员］）
#define at [NSString stringWithFormat@"at"]
//数组［@的人员］
#define atnt [NSString stringWithFormat@"atnt"]

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (fabs((double)[[ UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#endif
