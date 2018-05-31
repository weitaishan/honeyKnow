//
//  HomeDetailsViewController.h
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/27.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "WTSBaseViewController.h"
@interface HomeDetailsViewController : WTSBaseViewController
@property (weak, nonatomic) IBOutlet UIView *messgeView;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;

@property (nonatomic, assign) NSInteger userId;
@end
