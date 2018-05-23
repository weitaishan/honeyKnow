    //
//  BaseNavigationViewController.m
//  DeviseHome
//
//  Created by 魏太山 on 16/12/6.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#import "BaseNavigationViewController.h"
@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.translucent = NO;
    //设置navigationBar的背景颜色
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    //设置填充颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    //设置文字颜色
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kBlackColor
        ,NSFontAttributeName:[UIFont systemFontOfSize:17]};
   
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:nil];

    self.navigationItem.leftBarButtonItem = leftItem;

    self.navigationItem.backBarButtonItem = leftItem;

    
    
    WeakSelf;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = (id)weakSelf;
        
        self.delegate = (id)weakSelf;
    }
    
    
    //将返回按钮的文字position设置不在屏幕上显示
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-SCREEN_WIDTH, -SCREEN_HEIGHT) forBarMetrics:UIBarMetricsDefault];

    
    //设置navigationBar的背景图
//        UIImage * image = [UIImage imageFromColor:[UIColor blackColor] withSize:CGSizeMake(SCREEN_WIDTH, 64)];
//        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];

//    UIImageView* imageView = [self findHairlineImageViewUnder:self.view];
//    imageView.hidden = YES;
    
//    _navLine = [[UIView alloc] initWithFrame:imageView.frame];
//    _navLine.height = 0.5f;
//    _navLine.y = StatusBarAndNavigationBarHeight - 1;
//    _navLine.backgroundColor = kLineColor;
//    [self.view addSubview:_navLine];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 获取导航栏下方的黑线*/
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

//FIXME:这样做防止主界面卡顿时，导致一个ViewController被push多次
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (self.childViewControllers.count > 0) {
//        
//        if ([[self.childViewControllers lastObject] isKindOfClass:[viewController class]]) {
//            return;
//        }
//    }
//    
//    [super pushViewController:viewController animated:animated];
//}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return  [super popToRootViewControllerAnimated:animated];
    
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToViewController:viewController animated:animated];
    
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if ( gestureRecognizer == self.interactivePopGestureRecognizer )
    {
        if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] )
        {
            return NO;
        }
    }
    
    return YES;
}
@end
