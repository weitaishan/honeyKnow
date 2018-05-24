//
//  SetLabelCell.h
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/24.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SetLabelItem;
@interface SetLabelCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, strong) SetLabelItem* model;
@end
