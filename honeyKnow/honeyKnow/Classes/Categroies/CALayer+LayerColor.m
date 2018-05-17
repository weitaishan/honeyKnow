//
//  CALayer+LayerColor.m
//  Master
//
//  Created by 魏太山 on 16/8/2.
//  Copyright © 2016年 qushenghuo. All rights reserved.
//

#import "CALayer+LayerColor.h"

@implementation CALayer (LayerColor)
- (void)setBorderColorFromUIColor:(UIColor *)color
 {
    self.borderColor = color.CGColor;
 }
@end
