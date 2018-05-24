//
//  EditAuthenCell.h
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/24.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditAuthenModel;
@interface EditAuthenCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTitile;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@property (nonatomic, strong) EditAuthenModel* model;
@end
