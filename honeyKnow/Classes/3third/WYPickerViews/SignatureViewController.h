//
//  SignatureViewController.h
//  WYEditInfoDemo
//
//  Created by 意一yiyi on 2017/3/8.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SignatureBlock)(NSString *signature);

@interface SignatureViewController : UIViewController

@property (strong, nonatomic) NSString *signature;// 已存在的个性签名
@property (assign, nonatomic) int maxCharacterNum;// 可输入的最大字符数
@property (strong, nonatomic) UIColor *warningColor;// 超出字数限制时的警告色

@property (strong, nonatomic) SignatureBlock block;

@end
