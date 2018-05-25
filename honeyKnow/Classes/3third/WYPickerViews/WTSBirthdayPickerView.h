//
//  WTSBirthdayPickerView.h
//  WTSDatePickerViewDemo
//
//  Created by 意一yiyi on 2017/3/6.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WTSBirthdayPickerViewBlock)(NSString *selectedDate);

@interface WTSBirthdayPickerView : UIView

@property (strong, nonatomic) WTSBirthdayPickerViewBlock confirmBlock;

- (instancetype)initWithInitialDate:(NSString *)initialDate;

@end
