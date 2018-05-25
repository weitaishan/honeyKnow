//
//  CallRecvViewController.m
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/25.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "CallRecvViewController.h"

@interface CallRecvViewController ()

/**
 关闭摄像头
 */
@property (weak, nonatomic) IBOutlet UIButton *closeCameraBtn;

/**
 切换摄像头
 */
@property (weak, nonatomic) IBOutlet UIButton *switchCameraBtn;

/**
 静音
 */
@property (weak, nonatomic) IBOutlet UIButton *muteBtn;
@property (weak, nonatomic) IBOutlet UIView *muteView;

/**
 免提
 */
@property (weak, nonatomic) IBOutlet UIButton *freehandBtn;
@property (weak, nonatomic) IBOutlet UIView *freehandView;
@property (weak, nonatomic) IBOutlet UIView *callView;
@property (weak, nonatomic) IBOutlet UIButton *callShutBtn;


@property (weak, nonatomic) IBOutlet UIView *recvView;
@property (weak, nonatomic) IBOutlet UIButton *receShutBtn;
@property (weak, nonatomic) IBOutlet UIButton *receCallBtn;
@end

@implementation CallRecvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
