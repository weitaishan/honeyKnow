//
//  DiscoverListCell.m
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "DiscoverListCell.h"
#import "DiscoverListModel.h"
@implementation DiscoverListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconImgView.layer.borderWidth = 2;
    self.iconImgView.layer.borderColor = [UIColor colorFromHexString:@"#b1adb6"].CGColor;
}
-(void)setModel:(DiscoverList *)model{
    _model = model;
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:model.avator] placeholderImage:[UIImage imageNamed:@"pic_avatar"]];
    self.lbName.text = model.title ? model.title : @"";
    self.lbIntroduce.text = model.introduct ? model.introduct : @"";
    self.lbLikeNum.text = IntStr(model.loveNum);
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:model.mainImgUrl] placeholderImage:[UIImage imageNamed:@"pic_anchor"]];

}
@end
