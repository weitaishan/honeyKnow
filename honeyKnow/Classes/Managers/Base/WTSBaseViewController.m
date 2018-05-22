//
//  WTSBaseViewController.m
//  DeviseHome
//
//  Created by 魏太山 on 16/12/6.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#import "WTSBaseViewController.h"
#import "BaseNavigationViewController.h"
@interface WTSBaseViewController ()

@end

@implementation WTSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.tabBarController.tabBar.hidden = YES;
    [self setBaseInfomation];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setBaseInfomation{
    
    self.view.backgroundColor = kBgColor;
    
    //设置navigationBar的背景图
    //    UIImage * image = [UIImage imageFromColor:color(13, 13, 13, 1) withSize:CGSizeMake(ScreenWidth, 44)];
    //    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    //设置标题的颜色和字体大小
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:18]};
    
//    返回按钮
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

//设置导航栏右侧Button
-(void)addRightTitle:(NSString *)rightStr{
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithTitle:rightStr style:UIBarButtonItemStylePlain target:self action:@selector(nextStep)];
    rightItem.tintColor = kBlueColor;
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    
}

//设置导航栏右侧图片
-(void)addRightItemWithImage:(UIImage *)image{
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 24, 24);

    [button addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    self.navigationItem.rightBarButtonItem = item;
    
    
    
}
//跳转控制器
-(void)nextStepController:(NSString *)ConStr stroyBoard:(NSString*)stroyBoard{
    
    UIStoryboard* CSSb = [UIStoryboard storyboardWithName:stroyBoard bundle:nil];
    UIViewController* CSVc = [CSSb instantiateViewControllerWithIdentifier:ConStr];
    CSVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:CSVc animated:YES];

}

//右侧Button点击方法
-(void)nextStep{
    
    
}
//返回
-(void)back{

    [self.navigationController popViewControllerAnimated:YES];

}

//结束编辑
- (void)endEditing:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self.view endEditing:YES];
    }
}

#pragma mark UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
        
    [textField resignFirstResponder];
    
    return YES;
}

//解决手势冲突
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    if ([touch.view isKindOfClass:[UITextField class]])
//    {
//        return NO;
//    }
//    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] || [NSStringFromClass([touch.view class]) isEqualToString:@"YYTextContainerView"]) {
//        return NO;
//    }
//    return YES;
//}
/**
 *  现在textFile输入
 *
 *  @param textField
 *  @param numbs
 */
-(void)textField:(UITextField *)textField maxLimitNumbs:(NSInteger)numbs{
    
    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textField positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textField.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > numbs)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:numbs];
        
        [textField setText:s];
    }
}

-(void)addToast:(NSString *)toastStr{
    
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [GET_WINDOW makeToast:toastStr duration:1 position:CSToastPositionCenter style:style];
    
}

-(void)addTableViewWithFrame:(CGRect)frame{
    
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.backgroundColor = kBgColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);
    _tableView.separatorColor = kLineColor;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //ios 11适配
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;

    [self.view addSubview:_tableView];
    
}
-(void)addTableViewWithGroupFrame:(CGRect)frame{
    
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    _tableView.backgroundColor = kBgColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);
    _tableView.separatorColor = kLineColor;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    
}

//设置占位图
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"icon_zanwu"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"该列表暂时没有数据哦~";
    
    NSDictionary *attributes = @{NSFontAttributeName: FontTextTwo,
                                 NSForegroundColorAttributeName: kNormalTextTwoColor};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//解决空视图时，无法下拉刷新问题   
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    
    return YES;
}

//- (BOOL)shouldAutorotate{
//
//    APP_DELEGATE().interfaceOrientationMask = UIInterfaceOrientationMaskPortrait;
//    return NO;
//}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations

{
    
    return UIInterfaceOrientationMaskPortrait;
    
}
@end
