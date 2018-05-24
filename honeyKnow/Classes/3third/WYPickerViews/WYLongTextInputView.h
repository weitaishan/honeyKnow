//
//  WYLongTextInputView.h
//  WYEditInfoDemo
//
//  Created by 意一yiyi on 2017/3/7.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WYLongTextInputViewBlock)(NSString *longText);

@interface WYLongTextInputView : UITextView

@property (strong, nonatomic) WYLongTextInputViewBlock block;

/**
 初始化方法
 
 @param longText    打开时就显示的文本
 @param number      可输入的最大字符数
 @param color       超出字数限制时的警告色
 */
- (instancetype)initWithLongText:(NSString *)longText
                 MaxCharacterNum:(int)number
                    WarningColor:(UIColor *)color;


@end
