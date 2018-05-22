//
//  SearchTextField.m
//  SmallNail
//
//  Created by 魏太山 on 2017/5/31.
//  Copyright © 2017年 SmallNail. All rights reserved.
//

#import "SearchTextField.h"

@implementation SearchTextField

//重新调整左视图的frame
//传入的参数表示 需要将传入的参数进行调整
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
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 16 , 0);
}

// 控制文本的位置，左
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 16 , 0 );
}

@end
