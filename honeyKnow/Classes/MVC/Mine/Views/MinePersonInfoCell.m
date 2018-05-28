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
    self.iconImgView.userInteractionEnabled = YES ;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInfoModel:(MinePersonInfoModel *)infoModel{
    
    _infoModel = infoModel;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:infoModel.avator] placeholderImage:[UIImage imageNamed:@"pic_avatar"]];
    self.lbName.text = infoModel.nickName ?infoModel.nickName  : @"昵称";
    self.lbFocusNum.text = IntStr(infoModel.focusNum);
    self.lbHCoinNum.text = infoModel.balance ? infoModel.balance  : @"0";
    
    [self.levelBtn setTitle:[NSString stringWithFormat:@"LV.%@",infoModel.star.length ? infoModel.star : @"1"] forState:UIControlStateNormal];
    
}
@end
