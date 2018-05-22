//
//  MinePersonInfoCell.h
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MinePersonInfoModel;
@interface MinePersonInfoCell : UITableViewCell
@property (nonatomic, strong) MinePersonInfoModel* infoModel;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (weak, nonatomic) IBOutlet UIButton *levelBtn;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbFocusNum;
@property (weak, nonatomic) IBOutlet UILabel *lbHCoinNum;
@end
