//
//  AuthenMakeMoneyViewController.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/24.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "AuthenMakeMoneyViewController.h"

@interface AuthenMakeMoneyViewController ()
@property (weak, nonatomic) IBOutlet MainButton *startBtn;

@end

@implementation AuthenMakeMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO;

    self.startBtn.isBgImage = YES;
    self.navigationItem.title = @"认证赚钱";
    [[self.startBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        
    }];
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
