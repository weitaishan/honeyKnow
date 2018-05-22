//
//  MyWalletCell.h
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/20.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageListModel;

@interface MyWalletCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@property (nonatomic, strong) MessageListModel* model;

@end
