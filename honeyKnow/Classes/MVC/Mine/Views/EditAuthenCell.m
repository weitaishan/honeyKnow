//
//  EditAuthenCell.m
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/24.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "EditAuthenCell.h"
#import "EditAuthenModel.h"
@implementation EditAuthenCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_textFiled setValue:FontTextTwo forKeyPath:@"_placeholderLabel.font"];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _textFiled.font = FontTextTwo;
    
    _textFiled.textColor = [UIColor colorFromHexString:@"#c7c7cd"];
    
    _textFiled.borderStyle = UITextBorderStyleNone;
    
    _textFiled.returnKeyType = UIReturnKeyDone;
    
    _textFiled.textAlignment = NSTextAlignmentRight;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(EditAuthenModel *)model{
    
    _model = model;
    _lbTitile.text = model.title ? model.title : @"";
    _textFiled.text =  model.data ? model.data : @"";
    _textFiled.placeholder = model.placeholder ? model.placeholder : @"";
}

@end
