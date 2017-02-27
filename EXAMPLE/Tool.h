//
//  Tool.h
//  EXAMPLE
//
//  Created by 王雅强 on 15/3/31.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import <UIKit/UIKit.h>
// 3des加密引入
#import "GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <Availability.h>
#include <TargetConditionals.h>
#include <sys/cdefs.h>
#include <sys/types.h>
#include <CoreFoundation/CoreFoundation.h>
#include <SystemConfiguration/SCNetwork.h>
#include <dispatch/dispatch.h>


#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (fabs((double)[[ UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

@interface Tool : UIViewController

//在view中显示提示信息
+ (void)showSpinnerInView:(UIView *)view prompt:(NSString *)prompt;
+ (void)hideSpinnerInView:(UIView *)view;
+ (void)showPrompt:(NSString *)prompt inView:(UIView *)view delay:(NSTimeInterval)delay;

+(UINavigationBar *)ceatNavigatinBarBackImage:(NSString *)image backGroundColor:(UIColor *)color;

+(UINavigationItem *)addNavigationItemLeft:(NSString *)Image Title:(NSString *)title bartitle:(NSString *)btitle color:(UIColor *)color barcolor:(UIColor *)bcolor target:(id)Target
                                    action:(SEL)Action;

+(UINavigationItem *)addNavigationItemRight:(NSString *)Image Title:(NSString *)title bartitle:(NSString *)btitle color:(UIColor *)color barcolor:(UIColor *)bcolor target:(id)Target
                                     action:(SEL)Action;

+(UINavigationItem *)addNavigationItemsimageLeft:(NSString *)ImageLeft ImageRight:(NSString *)ImageRight Title:(NSString *)title color:(UIColor *)color barcolor:(UIColor *)bcolor TitleLeft:(NSString *)titleLeft TitleRight:(NSString *)titleRight target:(id)Target actionLeft:(SEL)Actionleft actionRight:(SEL)Actionright;

+ (UIImage *)imageWithName:(NSString *)name;

+(UINavigationItem *)creatNavigatTitle:(NSString *)title titleCoor:(UIColor *)color;


//获取随机数
+(int)getRandomNumber:(int)from to:(int)to;
//创建label

+ (UILabel *)createLabel:(NSString *)content color:(UIColor *)color font:(UIFont *)font;

+ (UILabel *)createLabel:(NSString *)content frame:(CGRect)frame color:(UIColor *)color font:(UIFont *)font aliment:(NSTextAlignment)aliment;

// 创建slider
+ (UISlider *)createSliderViewWithFrame:(CGRect)frame andMaxiImage:(NSString *)maxiImageStr  andMiniImage:(NSString *)miniImageStr  andThumbImage:(NSString *)thumbImageStr andTarget:(id)taget andAction:(SEL)action;

//创建button

+ (UIButton *)createButtonWithText:(NSString *)text Image:(NSString *)img
                            target:(id)target
                            action:(SEL)action;

+ (UIButton *)createButtonWithNormalImage:(NSString *)normal
                           highlitedImage:(NSString *)highlited
                                   target:(id)target
                                   action:(SEL)action;

+ (UIButton *)createButtonWithNormalImage:(NSString *)normal
                            selectedImage:(NSString *)highlited
                                   target:(id)target
                                   action:(SEL)action;
//适配方法
+ (float)getCurrentDistinction;

// 3DES加密
+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt;

+ (BOOL) checkNetworkIsValid;

+(void)reSetLogId;

+(void)setUserIdEqual;

@end
