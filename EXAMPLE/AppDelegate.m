//
//  AppDelegate.m
//  EXAMPLE
//
//  Created by 王雅强 on 15/3/30.
//  Copyright (c) 2015年 slc. All rights reserved.
//

#import "AppDelegate.h"
#import "rootViewContoller.h"
#import "User_InfoList.h"
#import "EFAnimationViewController.h"
#import "homeView.h"
#import "HYPWWheelViewControll.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "ViewController.h"
#import "UMMobClick/MobClick.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [MobClick setLogEnabled:YES];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    UMConfigInstance.appKey = UMENG_APPKEY;
//    UMConfigInstance.secret = @"secretstringaldfkals";
//    UMConfigInstance.channelId = @"Web";
    //    UMConfigInstance.eSType = E_UM_GAME;
    [MobClick startWithConfigure:UMConfigInstance];

    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    //告诉系统，我们要接受远程控制事件
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

    [self becomeFirstResponder];

    [[UIApplication sharedApplication]setStatusBarHidden:YES];
     self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    
      EFAnimationViewController *EFanimaVC=[[EFAnimationViewController alloc]init];
    UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:EFanimaVC];

     //ViewController *userVC = [[ViewController alloc]init];
    
    self.window.rootViewController=nav;
    [self.window addSubview:self.window.rootViewController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(BOOL)canBecomeFirstResponder{

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
