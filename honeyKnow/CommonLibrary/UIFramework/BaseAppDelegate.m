//
//  BaseAppDelegate.m
//  CommonLibrary
//
//  Created by Alexi on 3/6/14.
//  Copyright (c) 2014 CommonLibrary. All rights reserved.
//

#import "BaseAppDelegate.h"
#import <objc/runtime.h>
#import "PathUtility.h"
#import "NetworkUtility.h"

#import "NavigationViewController.h"
#import "BaseTabBarController.h"
#import "LoginSelectViewController.h"
@implementation BaseAppDelegate

+ (instancetype)sharedAppDelegate
{
    return (BaseAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)redirectConsoleLog:(NSString *)logFile
{
    NSString *cachePath = [PathUtility getCachePath];
    NSString *logfilePath = [NSString stringWithFormat:@"%@/%@", cachePath, logFile];
    freopen([logfilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
}

// 配置App中的控件的默认属性
- (void)configAppearance
{
    //    [[UINavigationBar appearance] setBarTintColor:kNavBarThemeColor];
    //    [[UINavigationBar appearance] setTintColor:kWhiteColor];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = kWhiteColor;
    shadow.shadowOffset = CGSizeMake(0, 0);
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName:kBlackColor,
                                                           NSShadowAttributeName:shadow,
                                                           NSFontAttributeName:kCommonLargeTextFont
                                                           }];
    
    [[UILabel appearance] setBackgroundColor:kClearColor];
    [[UILabel appearance] setTextColor:kMainTextColor];
    
    
    [[UIButton appearance] setTitleColor:kMainTextColor forState:UIControlStateNormal];
    
    //    [[UITableViewCell appearance] setBackgroundColor:kClearColor];
    //
    //    [[UITableViewCell appearance] setTintColor:kNavBarThemeColor];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self configAppearance];
    
    // 日志重定向处理
    if ([self needRedirectConsole])
    {
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //用[NSDate date]可以获取系统当前时间
        NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
        
        [self redirectConsoleLog:[NSString stringWithFormat:@"%@.log", currentDateStr]];
    }
    
//    // 用StoryBoard不需要自己创建
//    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    _window.backgroundColor = [UIColor whiteColor];
//
    [self configAppLaunch];
    
    // 进入登录界面
//    [self enterLoginUI];
//    [_window makeKeyAndVisible];

    //注册通知消息已经移动到登录之后，必须在登录之后上传token
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//    {
//        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
//    }
//    else
//    {
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
//    }
    
    [self baseInfo:application];
    [self setRootController];
    

    return YES;
}

-(void)baseInfo:(UIApplication *)application{
    
    //清空通知栏消息
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 1];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    //设置状态栏x
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    //获取版本号
//    NSLog(@"ILiveSDK version:%@",[[ILiveSDK getInstance] getVersion]);
//    NSLog(@"AVSDK version:%@",[QAVContext getVersion]);
//    NSLog(@"IMSDK version:%@",[[TIMManager sharedInstance] GetVersion]);
//    // 初始化SDK
//    [[ILiveSDK getInstance] initSdk:kSDKAppID accountType:kAccountType];
//
//    [[TIMManager sharedInstance] initSdk:kSDKAppID accountType:IntStr(kAccountType)];
//
//    [[TIMManager sharedInstance]  addMessageListener:self];
    
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

- (void)configAppLaunch
{
    // 作App配置
#if kSupportNetReachablity
     [[NetworkUtility sharedNetworkUtility] startCheckWifi];
#endif
}

- (void)enterLoginUI
{
    // 未提过前面的过渡界面，暂时先这样处理
    // 进入登录界面
}

- (BOOL)needRedirectConsole
{
    return NO;
}


- (void)enterMainUI
{
    
}

//- (void)applicationWillResignActive:(UIApplication *)application
//{
//    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
//}
//
//- (void)applicationDidBecomeActive:(UIApplication *)application
//{
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//}
//
//- (void)applicationWillTerminate:(UIApplication *)application
//{
//
//}

// 获取当前活动的navigationcontroller
- (UINavigationController *)navigationViewController
{
    if ([self.window.rootViewController isKindOfClass:[UINavigationController class]])
    {
        return (UINavigationController *)self.window.rootViewController;
    }
    else if ([self.window.rootViewController isKindOfClass:[UITabBarController class]])
    {
        UIViewController *selectVc = [((UITabBarController *)self.window.rootViewController) selectedViewController];
        if ([selectVc isKindOfClass:[UINavigationController class]])
        {
            return (UINavigationController *)selectVc;
        }
    }
    return nil;
}

- (UIViewController *)topViewController
{
    UINavigationController *nav = [self navigationViewController];
    return nav.topViewController;
}

- (void)pushViewController:(UIViewController *)viewController
{
    @autoreleasepool
    {
        viewController.hidesBottomBarWhenPushed = YES;
        [[self navigationViewController] pushViewController:viewController animated:YES];
    }
}

- (void)pushViewController:(UIViewController *)viewController withBackTitle:(NSString *)title
{
    @autoreleasepool
    {
        viewController.hidesBottomBarWhenPushed = YES;
        [[self navigationViewController] pushViewController:viewController withBackTitle:title animated:YES];
    }
}

//- (void)pushViewController:(UIViewController *)viewController withBackTitle:(NSString *)title backAction:(CommonVoidBlock)action
//{
//    @autoreleasepool
//    {
//        viewController.hidesBottomBarWhenPushed = YES;
//        [[self navigationViewController] pushViewController:viewController withBackTitle:title action:action animated:NO];
//    }
//}

- (UIViewController *)popViewController
{
    return [[self navigationViewController] popViewControllerAnimated:YES];
}
- (NSArray *)popToRootViewController
{
    return [[self navigationViewController] popToRootViewControllerAnimated:YES];
}

- (NSArray *)popToViewController:(UIViewController *)viewController
{
    return [[self navigationViewController] popToViewController:viewController animated:YES];
}

- (void)presentViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)())completion
{
    UIViewController *top = [self topViewController];
    
    if (vc.navigationController == nil)
    {
        NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:vc];
        [top presentViewController:nav animated:animated completion:completion];
    }
    else
    {
        [top presentViewController:vc animated:animated completion:completion];
    }
}

- (void)dismissViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)())completion
{
    if (vc.navigationController != [BaseAppDelegate sharedAppDelegate].navigationViewController)
    {
        [vc dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [vc.navigationController popViewControllerAnimated:YES];
    }
}

@end
