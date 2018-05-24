//
//  WYCityPickerView.h
//  WYChangeInfoDemo
//
//  Created by 意一yiyi on 2017/3/6.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WYCityPickerViewBlock)(NSString *selectedCity);

@interface WYCityPickerView : UIView

@property (strong, nonatomic) WYCityPickerViewBlock confirmBlock;

- (instancetype)initWithInitialCity:(NSString *)initialCity;

@end
