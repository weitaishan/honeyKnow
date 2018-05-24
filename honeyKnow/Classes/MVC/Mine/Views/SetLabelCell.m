//
//  SetLabelCell.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/24.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "SetLabelCell.h"
#import "SetLabelModel.h"
@implementation SetLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(SetLabelItem *)model{
    
    _model = model;
    [_button setTitle:model.name forState:UIControlStateNormal];
    
}
@end
