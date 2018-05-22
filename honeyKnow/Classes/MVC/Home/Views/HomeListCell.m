//
//  HomeListCell.m
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "HomeListCell.h"
#import "HomeListModel.h"
@implementation HomeListCell

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
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:model.avator] placeholderImage:nil];
    self.lbName.text = [NSString stringWithFormat:@"%@ %@",model.signName ? model.signName : @"",model.nickName ? model.nickName : @""];
    self.lbIntroduce.text = model.introduce ? model.introduce : @"";
    self.lbPrice.text = [NSString stringWithFormat:@"%@ V币/分钟",model.price ? model.price : @"0"];
    [self attriString:self.lbPrice.text label:self.lbPrice];

    if ([model.status integerValue]) {
        
        self.statusImgView.image = [UIImage imageNamed:@"icon_mode_green"];
        self.lbStatus.text = @"在线";
    }else{
        
        self.statusImgView.image = [UIImage imageNamed:@"icon_mode_red"];
        self.lbStatus.text = @"离线";

    }
    
}

-(void)attriString:(NSString *)string label:(UILabel *)label{
    
    // 创建一个富文本
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
    
    

    [attri addAttributes:@{NSForegroundColorAttributeName : kWhiteColor,
                               NSFontAttributeName : Font(15)} range:NSMakeRange(0, string.length)];
        
    [attri addAttributes:@{NSForegroundColorAttributeName : kWhiteColor,
                           NSFontAttributeName : FontTextThree} range:NSMakeRange(string.length - 6, 6)];
    label.attributedText = attri;

}
@end
