//
//  HomeListSerachCell.m
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "HomeListSerachCell.h"
#import "HomeListModel.h"

@implementation HomeListSerachCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(HomeList *)model{
    
    _model = model;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:model.avator] placeholderImage:[UIImage imageNamed:@"pic_avatar"]];
    self.lbName.text = model.nickName ? model.nickName : @"";
    self.lbIntroduce.text = model.introduce ? model.introduce : @"自我介绍";
}
@end
