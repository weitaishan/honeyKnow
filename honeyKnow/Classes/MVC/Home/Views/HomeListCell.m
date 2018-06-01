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

-(void)dealloc{
    
}
-(void)setModel:(HomeList *)model{
    
    _model = model;
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:model.avator] placeholderImage:nil];
    self.lbName.text = [NSString stringWithFormat:@"%@ %@",model.signName ? model.signName : @"",model.nickName ? model.nickName : @""];
    self.lbIntroduce.text = model.introduce ? model.introduce : @"";
    self.lbPrice.text = [NSString stringWithFormat:@"%@ V币/分钟",model.price ? model.price : @"0"];
    [self attriString:self.lbPrice.text label:self.lbPrice];
    
    //1是在线  0 是离线  2是繁忙  3勿扰icon_mode_red  icon_mode_green icon_rest
    if ([model.status integerValue] == 1) {
        
        self.lbStatus.text = @"在线";
        self.statusImgView.image = [UIImage imageNamed:@"icon_mode_green"];
    }else if ([model.status integerValue] == 0){
        
        self.lbStatus.text = @"离线";
        self.statusImgView.image = [UIImage imageNamed:@"icon_mode_red"];
    }else if ([model.status integerValue] == 2){
        
        self.lbStatus.text = @"繁忙";
        self.statusImgView.image = [UIImage imageNamed:@"icon_rest"];
    }else if ([model.status integerValue] == 3){
        
        self.lbStatus.text = @"勿扰";
        self.statusImgView.image = [UIImage imageNamed:@"icon_rest"];
    }
    
    //设置星标的值
    self.starView.starValue = [_model.star floatValue];
    
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
