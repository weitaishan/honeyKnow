//
//  MyWalletCell.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/20.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "MyWalletCell.h"
#import "MessageListModel.h"
@implementation MyWalletCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(MessageListModel *)model{
    
    _model = model;
    self.iconImgView.image = model.image;
    self.lbTitle.text = model.title ? model.title : @"";
}


@end
