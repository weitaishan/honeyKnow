//
//  NicknameViewController.m
//  WYEditInfoDemo
//
//  Created by 意一yiyi on 2017/3/7.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import "NicknameViewController.h"

#import "WYLongTextInputView.h"

@interface NicknameViewController ()

@end

@implementation NicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1];
    
    [self createVC];
}


#pragma mark - createVC

- (void)createVC {
    
    // 有导航栏和 tabBar 的情况下, 自动让布局从导航栏下边和 tabBar 上边开始布局
    if ([self performSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // 导航栏
    self.navigationItem.title = @"昵称";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftBarButtonItemAction:)];
    
    // longText : 已存在的昵称, number : 可输入的最大字符数, color : 超出字数限制时的警告色
    WYLongTextInputView *longTextInputView = [[WYLongTextInputView alloc] initWithLongText:self.nickname MaxCharacterNum:self.maxCharacterNum WarningColor:self.warningColor];
    // 编辑完成之后的回调
    longTextInputView.block = ^(NSString *longText) {
        
#warning - 可以在这里把新数据提交服务器
        
        // 在提交成功的回调里, 按自己的要求做相应的处理就可以了
        self.block(longText);
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:longTextInputView];
}


#pragma mark - Action

- (void)leftBarButtonItemAction:(UIBarButtonItem *)barButtonItem {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
