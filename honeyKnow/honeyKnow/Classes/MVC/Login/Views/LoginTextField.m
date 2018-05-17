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
    return CGRectInset( bounds , 20 , 0);
}

// 控制文本的位置，左
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 20 , 0 );
}
@end
