//
//  HomeDetailsViewController.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/27.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "HomeDetailsViewController.h"

@interface HomeDetailsViewController ()

@end

@implementation HomeDetailsViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;

    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]  subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [[TIMFriendshipManager sharedInstance] GetUsersProfile:@[@"9"] succ:^(NSArray *data) {
            
            
            for (TIMUserProfile * userProfile in data) {
                if ([userProfile.identifier isEqualToString:@"9"]) {
                    
                    IMAUser *user = [[IMAUser alloc] initWithUserInfo:userProfile];
                    
                    
#if kTestChatAttachment
                    
                    ChatViewController *vc = [[CustomChatUIViewController alloc] initWith:user];
#else
                    ChatViewController *vc = [[IMAChatViewController alloc] initWith:user];
#endif
                    
                    TIMConversation *imconv = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:user.userId];
                    if ([imconv getUnReadMessageNum] > 0)
                    {
                        [vc modifySendInputStatus:SendInputStatus_Send];
                    }
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
            
          
            
        } fail:^(int code, NSString *err) {
            
        }];
        
        
        
       

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
