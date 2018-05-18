//
//  MineItemView.h
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineItemView : UIView

@property (nonatomic, strong) UIView* rightLineView;

@property (nonatomic, strong) UIView* bottomLineView;

@property (nonatomic, strong) UILabel* lbTitle;

@property (nonatomic, strong) UIImageView* iconImgView;

@property (nonatomic, strong) UISwitch* switchView;

@property (nonatomic, assign) NSInteger isHaveSwitch;

@end
