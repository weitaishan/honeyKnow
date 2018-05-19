//
//  AppDelegate.m
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/16.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "AppDelegate.h"
#import "SplashViewController.h"
#import "LoginSelectViewController.h"
#import "BaseTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self baseInfo:application];
    [self setRootController];
    return YES;
}

-(void)baseInfo:(UIApplication *)application{
    
    //设置状态栏x
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    //获取版本号
    NSLog(@"ILiveSDK version:%@",[[ILiveSDK getInstance] getVersion]);
    NSLog(@"AVSDK version:%@",[QAVContext getVersion]);
    NSLog(@"IMSDK version:%@",[[TIMManager sharedInstance] GetVersion]);
    // 初始化SDK
    [[ILiveSDK getInstance] initSdk:kSDKAppID accountType:kAccountType];
    
    
}

-(void)setRootController{
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    
//    NSString *key = (NSString *)kCFBundleVersionKey;
//
//    // 1.从Info.plist中取出版本号
//    NSString *version = App_Version;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//
//    // 2.从沙盒中取出上次存储的版本号
//    NSString *saveVersion = [user valueForKey:key];
//    NSLog(@"version = %@",saveVersion);
//        if ([version isEqualToString:saveVersion]) { // 不是第一次使用这个版本
//
//    NSLog(@"相等");
    
    NSString* userToken = [NSUSERDEFAULTS objectForKey:USER_TOKEN];
    
    if (userToken.length > 0) {
        
        [[SystemService shareInstance] ILiveLogin];

        //创建标签栏控制器
        BaseTabBarController* tabBarController=[[BaseTabBarController alloc]init];
        
        self.window.rootViewController = tabBarController;
                
    }else{
        
        //创建标签栏控制器
        LoginSelectViewController* tabBarController=[MAIN_SB instantiateInitialViewController];
        
        self.window.rootViewController = tabBarController;
    }
    
    
//        } else { // 版本号不一样：第一次使用新版本
//            NSLog(@"不相等");
//
//            // 将新版本号写入沙盒
//            [NSUSERDEFAULTS setObject:version forKey:key];
//            [NSUSERDEFAULTS synchronize];
//
//            //引导页
//            SplashViewController* splashVC = [[SplashViewController alloc] init];
//            self.window.rootViewController = splashVC;
//
//        }

    
    [self.window makeKeyAndVisible];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
