//
//  WYBirthdayPickerView.h
//  WYDatePickerViewDemo
//
//  Created by 意一yiyi on 2017/3/6.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WYBirthdayPickerViewBlock)(NSString *selectedDate);

@interface WYBirthdayPickerView : UIView

@property (strong, nonatomic) WYBirthdayPickerViewBlock confirmBlock;

- (instancetype)initWithInitialDate:(NSString *)initialDate;

@end
