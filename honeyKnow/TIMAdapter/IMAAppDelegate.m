//
//  IMAAppDelegate.m
//  honeyKnow
//
//  Created by AlexiChen on 16/2/26.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import "IMAAppDelegate.h"

#import "IMALoginViewController.h"

#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import <UMShare/UMShare.h>
@implementation IMAAppDelegate

void uncaughtExceptionHandler(NSException*exception){
    DebugLog(@"CRASH: %@", exception);
    DebugLog(@"Stack Trace: %@",[exception callStackSymbols]);
}

- (void)configAppLaunch
{
    [super configAppLaunch];
    [[IMAPlatform sharedInstance] configOnAppLaunch];
}



- (void)applicationDidEnterBackground:(UIApplication *)application
{
    __block UIBackgroundTaskIdentifier bgTaskID;
    bgTaskID = [application beginBackgroundTaskWithExpirationHandler:^ {
        
        //不管有没有完成，结束background_task任务
        [application endBackgroundTask: bgTaskID];
        bgTaskID = UIBackgroundTaskInvalid;
    }];
    
    [[IMAPlatform sharedInstance] configOnAppEnterBackground];
    

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[IMAPlatform sharedInstance] configOnAppEnterForeground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[IMAPlatform sharedInstance] configOnAppDidBecomeActive];
}


-(void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[IMAPlatform sharedInstance] configOnAppRegistAPNSWithDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    DebugLog(@"didFailToRegisterForRemoteNotificationsWithError:%@", error.localizedDescription);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    // 处理推送消息
    DebugLog(@"userinfo:%@",userInfo);
    DebugLog(@"收到推送消息:%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    [[TIMManager sharedInstance] reportAPNSEvent:userInfo];
}


// 进入登录界面
// 用户可重写
- (void)enterLoginUI
{
//    IMALoginViewController *vc = [[IMALoginViewController alloc] init];
//    self.window.rootViewController = vc;
    
}


//==================================
// URL Scheme处理
- (BOOL)application:(UIApplication*)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        if ([url.scheme compare:QQ_OPEN_SCHEMA] == NSOrderedSame)
        {
            return [TencentOAuth HandleOpenURL:url];
        }
        else if([url.scheme compare:WX_APP_ID] == NSOrderedSame)
        {
            //        if ([self.window.rootViewController conformsToProtocol:@protocol(WXApiDelegate)])
            //        {
            //            id<WXApiDelegate> lgv = (id<WXApiDelegate>)self.window.rootViewController;
            //            [WXApi handleOpenURL:url delegate:lgv];
            //
            //        }
            
            return [WXApi handleOpenURL:url delegate:[MJPayApi sharedApi]];
            
        }
        if ([url.scheme isEqualToString:ALI_PAY]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
            }];
        }
        
        return YES;
        
        
    }
    return result;
    
    
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        
        if ([url.scheme compare:QQ_OPEN_SCHEMA] == NSOrderedSame)
        {
            return [TencentOAuth HandleOpenURL:url];
        }
        else if([url.scheme compare:WX_APP_ID] == NSOrderedSame)
        {
            
            return  [WXApi handleOpenURL:url delegate:[MJPayApi sharedApi]];
            
            //        if ([self.window.rootViewController conformsToProtocol:@protocol(WXApiDelegate)])
            //        {
            //            id<WXApiDelegate> lgv = (id<WXApiDelegate>)self.window.rootViewController;
            //            [WXApi handleOpenURL:url delegate:lgv];
            //        }
        }
        
        if ([url.scheme isEqualToString:ALI_PAY]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
            }];
        }
        
        return YES;
        
        
    }
    return result;
    

}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
        
        if ([url.scheme isEqualToString:ALI_PAY]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
            }];
        }
        return YES;
    }
    return result;
    

}



@end
