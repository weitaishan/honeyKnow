//
//  WYGenderPickerView.h
//  WYChangeInfoDemo
//
//  Created by 意一yiyi on 2017/3/6.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WYGenderPickerViewBlock)(NSString *selectedGender);

@interface WYGenderPickerView : UIView

@property (strong, nonatomic) WYGenderPickerViewBlock confirmBlock;

- (instancetype)initWithInitialGender:(NSString *)initialGender;

@end
