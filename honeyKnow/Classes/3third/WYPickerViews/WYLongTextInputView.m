//
//  WYLongTextInputView.m
//  WYEditInfoDemo
//
//  Created by 意一yiyi on 2017/3/7.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import "WYLongTextInputView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface WYLongTextInputView ()<UITextViewDelegate>

@property (strong, nonatomic) UILabel *characterNumLabel;
@property (assign, nonatomic) int maxCharacterNum;
@property (strong, nonatomic) UIColor *warningColor;

@end

@implementation WYLongTextInputView

- (instancetype)initWithLongText:(NSString *)longText
                 MaxCharacterNum:(int)number
                    WarningColor:(UIColor *)color {
    
    if ([super init]) {
        
        self.frame = CGRectMake(0, 10, kScreenWidth, kScreenHeight - 64 - 20);
        self.backgroundColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:16];
        self.textColor = [UIColor colorWithRed:61 / 255.0 green:61 / 255.0 blue:61 / 255.0 alpha:1];
        self.returnKeyType = UIReturnKeyDone;// return 键显示完成
//        self.enablesReturnKeyAutomatically = YES;// 如果没有输入文字则不可点击, 否则可点击
        [self becomeFirstResponder];
        
        self.text = longText;
        self.characterNumLabel.text = [NSString stringWithFormat:@"%ld", longText.length];
        self.maxCharacterNum = number;
        self.warningColor = color;
        
        self.delegate = self;
        
        [self drawView];
    }
    
    return self;
}


#pragma mark - drawView

- (void)drawView {
    
    // 注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    
    [self addSubview:self.characterNumLabel];
}


#pragma mark - textView 代理方法

// textView 文本将要改变
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
        if ([text isEqualToString:@"\n"]) {// 判断输入的字是否是回车, 即按下 return
    
            // 在这里做你响应 return 键的代码
            if (textView.text.length <= self.maxCharacterNum) {
    
                self.block(self.text);
            }
    
            return NO;// 这里返回 NO, 就代表 return 键值失效, 即页面上按下 return, 不会出现换行, 如果为 YES, 则输入页面会换行
        }
    return YES;
}

// textView 文本改变
- (void)textViewDidChange:(UITextView *)textView {
    
    self.characterNumLabel.text = [NSString stringWithFormat:@"%ld", self.text.length];

    if (textView.text.length > self.maxCharacterNum) {

        self.characterNumLabel.textColor = self.warningColor;
    }else {

        self.characterNumLabel.textColor = [UIColor colorWithRed:108 / 255.0 green:108 / 255.0 blue:108 / 255.0 alpha:1];
    }
}


#pragma - 键盘通知

- (void)keyboardWillShowNotification:(NSNotification *)notificaiton {
    
    // 获取键盘的基本信息(动画时长和键盘高度)
    NSDictionary *userInfo = [notificaiton userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 更新 textView 的 frame
    [UIView animateWithDuration:keyboardDuration animations:^{
        
        self.frame = CGRectMake(0, 10, kScreenWidth, kScreenHeight - 64 - 20 - keyboardHeight);
        self.characterNumLabel.frame = CGRectMake(kScreenWidth - 10 - 40, kScreenHeight - 64 - 20 - 10 - 15 - keyboardHeight, 40, 15);
        [self layoutIfNeeded];
    }];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
    
    // 获得键盘动画时长
    NSDictionary *userInfo = [notification userInfo];
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 更新 textView 的 frame
    [UIView animateWithDuration:keyboardDuration animations:^{
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 20);
        self.characterNumLabel.frame = CGRectMake(kScreenWidth - 10 - 40, kScreenHeight - 64 - 20 - 10 - 15, 40, 15);
        [self layoutIfNeeded];
    }];
}


#pragma mark - 懒加载

- (UILabel *)characterNumLabel {
    
    if (!_characterNumLabel) {
        
        _characterNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 10 - 40, kScreenHeight - 64 - 20 - 10 - 15, 40, 15)];
        _characterNumLabel.backgroundColor = [UIColor clearColor];
        
        _characterNumLabel.font = [UIFont systemFontOfSize:(12)];
        _characterNumLabel.textColor = [UIColor colorWithRed:108 / 255.0 green:108 / 255.0 blue:108 / 255.0 alpha:1];
        _characterNumLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _characterNumLabel;
}

@end
