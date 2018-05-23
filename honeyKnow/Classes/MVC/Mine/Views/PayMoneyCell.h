//
//  PayMoneyCell.h
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/23.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayMoneyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbConfirmMoney;
@property (weak, nonatomic) IBOutlet UIView *payView;

@end
