//
//  LoginTextField.m
//  Designer
//
//  Created by 魏太山 on 16/12/19.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#import "LoginTextField.h"

@implementation LoginTextField
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 40 , 0);
}

// 控制文本的位置，左
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 40 , 0 );
}

-(CGRect)leftViewRectForBounds:(CGRect)bounds{
    
    //确定左视图的左边距
    CGFloat margin = 6;
    //确定左视图的宽和高相等，并且确定比例
    CGFloat scale = 6 / 11.0f;
    CGFloat width = bounds.size.height * scale;
    //确定坐标
    CGFloat x = margin;
    CGFloat y = (bounds.size.height - width) / 2.0f;
    return CGRectMake(x, y, width, width);
}
@end
