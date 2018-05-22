//
//  AppDelegate.m
//  honeyKnow
//
//  Created by AlexiChen on 16/1/29.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import "AppDelegate.h"

#import <TencentOpenAPI/TencentOAuth.h>

#import "WXApi.h"

#import "BaseTabBarController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (void)configAppLaunch
{
    // 作App配置
    [[NSClassFromString(@"UICalloutBarButton") appearance] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
 
}


- (void)enterMainUI
{
    self.window.rootViewController = [[TIMTabBarController alloc] init];
}

+ (instancetype)sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}


- (void)pushToChatViewControllerWith:(IMAUser *)user
{
    
    BaseTabBarController *tab = (BaseTabBarController *)self.window.rootViewController;
    [tab pushToChatViewControllerWith:user];
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
