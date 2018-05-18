//
//  MinePersonInfoCell.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "MinePersonInfoCell.h"
#import "MinePersonInfoModel.h"
@implementation MinePersonInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.iconImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconImgView.layer.borderWidth = 2;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
