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
#import "ConversationListViewController.h"
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
//    MessageViewController* messageVC = [[MessageViewController alloc] init];
    MineViewController* mineVC = [[MineViewController alloc] init];
    ConversationListViewController* messageVC = [[ConversationListViewController alloc] init];
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

- (void)pushToChatViewControllerWith:(IMAUser *)user
{
    NavigationViewController *curNav = (NavigationViewController *)[[self viewControllers] objectAtIndex:self.selectedIndex];
    if (self.selectedIndex == 0)
    {
        // 选的中会话tab
        // 先检查当前栈中是否聊天界面
        NSArray *array = [curNav viewControllers];
        for (UIViewController *vc in array)
        {
            if ([vc isKindOfClass:[IMAChatViewController class]])
            {
                // 有则返回到该界面
                IMAChatViewController *chat = (IMAChatViewController *)vc;
                [chat configWithUser:user];
                //                chat.hidesBottomBarWhenPushed = YES;
                [curNav popToViewController:chat animated:YES];
                return;
            }
        }
#if kTestChatAttachment
        // 无则重新创建
        ChatViewController *vc = [[CustomChatUIViewController alloc] initWith:user];
#else
        ChatViewController *vc = [[IMAChatViewController alloc] initWith:user];
#endif
        
        if ([user isC2CType])
        {
            TIMConversation *imconv = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:user.userId];
            if ([imconv getUnReadMessageNum] > 0)
            {
                [vc modifySendInputStatus:SendInputStatus_Send];
            }
        }
        
        vc.hidesBottomBarWhenPushed = YES;
        [curNav pushViewController:vc withBackTitle:@"返回" animated:YES];
    }
    else
    {
        NavigationViewController *chatNav = (NavigationViewController *)[[self viewControllers] objectAtIndex:0];
        
#if kTestChatAttachment
        // 无则重新创建
        ChatViewController *vc = [[CustomChatUIViewController alloc] initWith:user];
#else
        ChatViewController *vc = [[IMAChatViewController alloc] initWith:user];
#endif
        vc.hidesBottomBarWhenPushed = YES;
        [chatNav pushViewController:vc withBackTitle:@"返回" animated:YES];
        
        [self setSelectedIndex:0];
        
        if (curNav.viewControllers.count != 0)
        {
            [curNav popToRootViewControllerAnimated:YES];
        }
        
    }
}
@end
