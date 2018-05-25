//
//  WTSGenderPickerView.h
//  WTSChangeInfoDemo
//
//  Created by 意一yiyi on 2017/3/6.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WTSGenderPickerViewBlock)(NSString *selectedGender);

@interface WTSGenderPickerView : UIView

@property (strong, nonatomic) WTSGenderPickerViewBlock confirmBlock;

- (instancetype)initWithInitialGender:(NSString *)initialGender;

@end
