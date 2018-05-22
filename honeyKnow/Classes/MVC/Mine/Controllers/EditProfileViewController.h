//
//  EditProfileViewController.h
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/17.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UITableViewController

//0为首次登陆绑定头像 1为我的页面进入
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString* icoImgUrl;


@property (nonatomic, copy) NSString* nickName;

@end
