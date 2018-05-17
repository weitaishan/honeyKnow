//
//  BaseTabBarController.m
//  DeviseHome
//
//  Created by 魏太山 on 16/12/6.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#import "BaseTabBarController.h"
#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "BaseNavigationViewController.h"
#import "MineViewController.h"
#import "MessageViewController.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self TabBarSetting];
   
    //创建tabBarItem
    [self creatViewController];
    
}


-(void)creatViewController{
    
    HomeViewController* homeVC = [[HomeViewController alloc]init];
    DiscoverViewController* discoverVC = [[DiscoverViewController alloc] init];
    MessageViewController* messageVC = [[MessageViewController alloc] init];
    MineViewController* mineVC = [[MineViewController alloc] init];
    
    NSArray* controllerArray = @[homeVC,discoverVC,messageVC,mineVC];

    NSArray* normalImgArray = @[@"tab_home_normal",@"tab_find_normal",@"tab_news_normal",@"tab_info_normal"];//,@"tabbar_tool_normal"
    NSArray* selectedImgArray = @[@"tab_home_highlighted",@"tab_find_highlighted",@"tab_news_highlighted",@"tab_info_highlighted"];//,@"tabbar_tool_select"
    NSMutableArray * navArray = @[].mutableCopy;
    
    CGFloat offset = 5.0;

    [controllerArray enumerateObjectsUsingBlock:^(UIViewController* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BaseNavigationViewController* navVC = [[BaseNavigationViewController alloc] initWithRootViewController:obj];
        UITabBarItem* item = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:normalImgArray[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectedImage:[[UIImage imageNamed:selectedImgArray[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//        obj.title = titleArray[idx];
        obj.tabBarItem = item;
        obj.tabBarItem .imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);

        [navArray addObject:navVC];
        
    }];
    
    // 矫正TabBar图片位置，使之垂直居中显示
//    for (UITabBarItem *item in self.tabBar.items) {
//        item.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
//    }
//    
    self.viewControllers = navArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-定制TabBar
-(void)TabBarSetting{
    //1.设置是否透明
    self.tabBar.translucent = YES;
    
    //2.设置背景颜色
    self.tabBar.barTintColor = [UIColor colorFromHexString:@"#EDEDED"];
    
    //3.高级设置,设置字体大小
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:kNormalTextOneColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:10]} forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:kNormalTextOneColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:10]} forState:UIControlStateSelected];
    
    
    //改变tabbar 线条颜色
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,kLineColor.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:img];
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];

    self.tabBar.backgroundColor = [UIColor whiteColor];
}

@end
