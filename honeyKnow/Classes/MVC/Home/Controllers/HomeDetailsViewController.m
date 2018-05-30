//
//  HomeDetailsViewController.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/27.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "HomeDetailsViewController.h"
#import <UShareUI/UShareUI.h>
#import <UMShare/UMShare.h>
@interface HomeDetailsViewController ()

@end

@implementation HomeDetailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;

    
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]  subscribeNext:^(__kindof UIControl * _Nullable x) {
        
//        [[TIMFriendshipManager sharedInstance] GetUsersProfile:@[@"9"] succ:^(NSArray *data) {
//
//
//            for (TIMUserProfile * userProfile in data) {
//                if ([userProfile.identifier isEqualToString:@"9"]) {
//
//                    IMAUser *user = [[IMAUser alloc] initWithUserInfo:userProfile];
//
//
//#if kTestChatAttachment
//
//                    ChatViewController *vc = [[CustomChatUIViewController alloc] initWith:user];
//#else
//                    ChatViewController *vc = [[IMAChatViewController alloc] initWith:user];
//#endif
//
//                    TIMConversation *imconv = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:user.userId];
//                    if ([imconv getUnReadMessageNum] > 0)
//                    {
//                        [vc modifySendInputStatus:SendInputStatus_Send];
//                    }
//                    vc.hidesBottomBarWhenPushed = YES;
//                    [self.navigationController pushViewController:vc animated:YES];
//                }
//            }
//
//
//
//        } fail:^(int code, NSString *err) {
//
//        }];
        
        
        
        [WTSHttpTool requestWihtMethod:RequestMethodTypeGet url:URL_SHARE params:nil success:^(id response) {
            
            
            if ([response[@"success"] integerValue]){
                
                
                [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
                //            [UMSocialUIManager setShareMenuViewDelegate:APP_DELEGATE().getCurrentVC];
                
                //显示分享面板
                [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
                    // 根据获取的platformType确定所选平台进行下一步操作
                    
                    //调用分享接口
                    //创建分享消息对象
                    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
                    //创建网页内容对象
                    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:response[@"data"][@"title"] descr:response[@"data"][@"content"] thumImage:[NSURL URLWithString:response[@"data"][@"imgUrl"]]];
                    //设置网页地址
                    shareObject.webpageUrl = response[@"data"][@"inviteUrl"];
                    //分享消息对象设置分享内容对象
                    messageObject.shareObject = shareObject;
                    //调用分享接口
                    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:APP_DELEGATE().getCurrentVC completion:^(id data, NSError *error) {
                        if (error) {
                            NSLog(@"************Share fail with error %@*********",error);
                        }else{
                            NSLog(@"response data is %@",data);
                        }
                    }];
                }];
                
                
            }
            
        } failure:^(NSError *error) {
            
            
            
        }];

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


@end
