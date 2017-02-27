//
//  Tool.m
//  EXAMPLE
//
//  Created by 王雅强 on 15/3/31.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import "Tool.h"
#import "MBProgressHUD.h"
#import "JSON.h"
#import "NSData+Base64.h"
#import <CommonCrypto/CommonDigest.h>
#import "Reachability.h"


@implementation Tool

-(void)viewDidLoad
{
    [super viewDidLoad];
}
//导航栏设定背景图片（颜色）
+(UINavigationBar *)ceatNavigatinBarBackImage:(NSString *)image backGroundColor:(UIColor *)color
{
    
    UINavigationBar *navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44+20)];
    [navigationBar setBackgroundImage:[UIImage imageNamed:image] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setBackgroundColor:color];
    
    return navigationBar;
}

+ (void)showSpinnerInView:(UIView *)view prompt:(NSString *)prompt
{
    if (view != nil) {
        [MBProgressHUD hideAllHUDsForView:view animated:NO];
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
        HUD.removeFromSuperViewOnHide = YES;
        if (prompt.length > 0) {
            HUD.mode = MBProgressHUDModeIndeterminate;
            HUD.labelText = prompt;
        }
    }
}

+ (void)hideSpinnerInView:(UIView *)view
{
    if (view != nil) {
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
    }
}

+ (void)showPrompt:(NSString *)prompt inView:(UIView *)view delay:(NSTimeInterval)delay
{
    if (view != nil) {
        [MBProgressHUD hideAllHUDsForView:view animated:NO];
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
        HUD.removeFromSuperViewOnHide = YES;
        if (prompt.length > 0) {
            HUD.mode = MBProgressHUDModeText;
            HUD.labelText = prompt;
        }
        [HUD hide:YES afterDelay:delay];
    }
}


//获取随机数
+(int)getRandomNumber:(int)from to:(int)to{
    
    return (int)(from + (arc4random() % (to - from + 1)));
    
}

+ (UIImage *)imageWithName:(NSString *)name
{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:NSLocalizedString(name,@"适配") ofType:@"png"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    
    if (!image) {
        
    }
    
    return image;
}

+ (UILabel *)createLabel:(NSString *)content color:(UIColor *)color font:(UIFont *)font
{
    CGSize size = [content sizeWithFont:font];
    return [self createLabel:content frame:CGRectMake(0, 0, (int)size.width, (int)size.height) color:color font:font aliment:NSTextAlignmentCenter];
}

+ (UILabel *)createLabel:(NSString *)content frame:(CGRect)frame color:(UIColor *)color font:(UIFont *)font aliment:(NSTextAlignment)aliment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = content;
    label.textColor = color;
    label.font = font;
    label.textAlignment = aliment;
    return label;
}

// 定制Slider
+ (UISlider *)createSliderViewWithFrame:(CGRect)frame andMaxiImage:(NSString *)maxiImageStr  andMiniImage:(NSString *)miniImageStr  andThumbImage:(NSString *)thumbImageStr andTarget:(id)taget andAction:(SEL)action{
    
    UIImage * maxImage = [[UIImage imageNamed:miniImageStr ]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) ];
    UIImage * minImage = [[UIImage imageNamed:maxiImageStr ]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIImage * thumbImage = [[UIImage imageNamed:thumbImageStr ]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UISlider * slider = [[UISlider alloc]initWithFrame:frame];
    
    /*
     [[UISlider appearance] setMaximumTrackImage:maxImage
     forState:UIControlStateNormal];
     [[UISlider appearance] setMinimumTrackImage:minImage
     forState:UIControlStateNormal];
     [[UISlider appearance] setThumbImage:thumbImage
     forState:UIControlStateNormal];
     */
    
    
    [slider setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [slider setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [slider setThumbImage:thumbImage forState:UIControlStateNormal];
    
    [slider addTarget:taget action:action forControlEvents:UIControlEventValueChanged];
    
    return slider;
}


+ (UIButton *)createButtonWithText:(NSString *)text Image:(NSString *)img
                            target:(id)target
                            action:(SEL)action
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = [self imageWithName:img];
    [button setImage:normalImage forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(277, 25, 45, 30);
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateSelected];
    return button;
    
}

+ (UIButton *)createButtonWithNormalImage:(NSString *)normal
                           highlitedImage:(NSString *)highlited
                                   target:(id)target
                                   action:(SEL)action
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = [self imageWithName:normal];
    UIImage *highlightImage = [self imageWithName:highlited];
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
    return button;
    
}

+ (UIButton *)createButtonWithNormalImage:(NSString *)normal
                            selectedImage:(NSString *)highlited
                                   target:(id)target
                                   action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = [self imageWithName:normal];
    UIImage *selectedImage = [self imageWithName:highlited];
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateHighlighted];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
    return button;
}



//设定左边导航按钮
+(UINavigationItem *)addNavigationItemLeft:(NSString *)Image Title:(NSString *)title bartitle:(NSString *)btitle color:(UIColor *)color barcolor:(UIColor *)bcolor target:(id)Target
                                     action:(SEL)Action{
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 45, 30)];
    lab.text=title;
    lab.textColor=color;
    
    lab.font = [UIFont boldSystemFontOfSize:20];
    lab.backgroundColor = [UIColor clearColor];
    lab.textAlignment = NSTextAlignmentCenter;
    
    //创建导航控件内容
    UINavigationItem *navigationItem=[[UINavigationItem alloc]init];
    navigationItem.titleView=lab;
    
    //右侧添加导航
    UIBarButtonItem * ButtonRight=[[UIBarButtonItem alloc]initWithTitle:btitle style:UIBarButtonItemStyleDone target:Target action:Action];
    [ButtonRight setTintColor:bcolor];
    [ButtonRight setImage:[UIImage imageNamed:Image]];
    //ButtonRight.enabled=NO;
    navigationItem.leftBarButtonItem=ButtonRight;
    
    //添加内容到导航栏
    return navigationItem;
    
}


//设定右边导航按钮
+(UINavigationItem *)addNavigationItemRight:(NSString *)Image Title:(NSString *)title bartitle:(NSString *)btitle color:(UIColor *)color barcolor:(UIColor *)bcolor target:(id)Target
                                    action:(SEL)Action
{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 45, 30)];
    lab.text=title;
    lab.textColor=color;
    
    lab.font = [UIFont boldSystemFontOfSize:20];
    lab.backgroundColor = [UIColor clearColor];
    lab.textAlignment = NSTextAlignmentCenter;
    
    //创建导航控件内容
    UINavigationItem *navigationItem=[[UINavigationItem alloc]initWithTitle:nil];
    navigationItem.titleView=lab;
    
    //右侧添加导航
    UIBarButtonItem * ButtonRight=[[UIBarButtonItem alloc]initWithTitle:btitle style:UIBarButtonItemStyleDone target:Target action:Action];
    [ButtonRight setTintColor:bcolor];
    [ButtonRight setImage:[UIImage imageNamed:Image]];
    //ButtonRight.enabled=NO;
    navigationItem.rightBarButtonItem=ButtonRight;
    
    //添加内容到导航栏
    return navigationItem;

}

//设定左右导航栏按钮
+(UINavigationItem *)addNavigationItemsimageLeft:(NSString *)ImageLeft ImageRight:(NSString *)ImageRight Title:(NSString *)title color:(UIColor *)color barcolor:(UIColor *)bcolor TitleLeft:(NSString *)titleLeft TitleRight:(NSString *)titleRight target:(id)Target actionLeft:(SEL)Actionleft actionRight:(SEL)Actionright{
    
    UILabel *labl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 45, 30)];
    labl.text=title;
    labl.textColor=color;
    
    labl.font = [UIFont boldSystemFontOfSize:20];
    labl.backgroundColor = [UIColor clearColor];
    labl.textAlignment = NSTextAlignmentCenter;
    
    //创建导航控件内容
    UINavigationItem *navigationItem=[[UINavigationItem alloc]init];
    navigationItem.titleView=labl;
    
    //左侧添加导航
    UIBarButtonItem * ButtonLeft=[[UIBarButtonItem alloc]initWithTitle:titleLeft style:UIBarButtonItemStylePlain target:Target action:Actionleft];
    [ButtonLeft setTintColor:bcolor];
    [ButtonLeft setImage:[UIImage imageNamed:ImageLeft]];
    //ButtonRight.enabled=NO;
    navigationItem.leftBarButtonItem=ButtonLeft;
    
    //右侧添加导航
    UIBarButtonItem * ButtonRight=[[UIBarButtonItem alloc]initWithTitle:titleRight style:UIBarButtonItemStylePlain target:Target action:Actionright];
    [ButtonRight setTintColor:bcolor];
    [ButtonRight setImage:[UIImage imageNamed:ImageRight]];
    //ButtonRight.enabled=NO;
    navigationItem.rightBarButtonItem=ButtonRight;
    
    
    //添加内容到导航栏
    return navigationItem;

}

//设定导航栏标题
+(UINavigationItem *)creatNavigatTitle:(NSString *)title titleCoor:(UIColor *)color
{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 45, 30)];
    lab.text=title;
    lab.textColor=color;
    
    lab.font = [UIFont boldSystemFontOfSize:20];
    lab.backgroundColor = [UIColor clearColor];
    lab.textAlignment = NSTextAlignmentCenter;
    //        CGRect frameLeft= CGRectMake(0, 0, imageLeft.size.width, imageLeft.size.height);
    //        CGRect frameRight= CGRectMake(0, 0, imageRight.size.width, imageRight.size.height);
    
    //创建导航控件内容
    UINavigationItem *navigationItem=[[UINavigationItem alloc]initWithTitle:nil];
    navigationItem.titleView=lab;
    
    return navigationItem;

}

//适配方法
+ (float)getCurrentDistinction
{
    if (IS_IPHONE_5) {
        return (548 - 460);
    }
    else
    {
        return 0;
    }
}

// 3DES 加解密

#define kChosenDigestLength     CC_SHA1_DIGEST_LENGTH
#define DESKEY @"4BD634432ERRDF432FFSDDSFAQSDF3E83A361FA75FA446933F90D384C6F6520F29FCD8EA"

+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt
{
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)//解密
    {
        NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else //加密
    {
        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    const void *vkey = (const void *)[DESKEY UTF8String];
    // NSString *initVec = @"init Vec";
    //const void *vinitVec = (const void *) [initVec UTF8String];
    //  Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    //if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
    /*else if (ccStatus == kCC ParamError) return @"PARAM ERROR";
     else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
     else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
     else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
     else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
     else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED"; */
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                               length:(NSUInteger)movedBytes]
                                       encoding:NSUTF8StringEncoding];
        free(bufferPtr);
        return result;
        
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:myData];
        free(bufferPtr);
        return result;
    }
    //bufferPtr = NULL;
}


// 判断网络是否可用
+ (BOOL) checkNetworkIsValid {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;

    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    // = flags & kSCNetworkReachabilityFlagsIsWWAN;
    BOOL nonWifi = flags & kSCNetworkReachabilityFlagsTransientConnection;
    BOOL moveNet = flags & kSCNetworkReachabilityFlagsIsWWAN;
    
    return ((isReachable && !needsConnection) || nonWifi || moveNet) ? YES : NO;
    
}

//判断是否越狱
+ (BOOL)isJailbroken
{
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        return YES;
    }
    else if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        return YES;
    }
    return NO;
}


+ (NSString*)GetCurrntNet
{
    NSString *connectionKind = nil;
    Reachability* hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([hostReach currentReachabilityStatus]) {
        case NotReachable:
            connectionKind = @"null";
            break;
        case ReachableViaWiFi:
            connectionKind = @"wifi";
            break;
        case ReachableViaWWAN:
            connectionKind = @"3g";
            break;
        default:
            break;
    }
    return connectionKind;
}



@end
