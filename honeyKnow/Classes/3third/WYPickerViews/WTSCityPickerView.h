//
//  WTSCityPickerView.h
//  WTSChangeInfoDemo
//
//  Created by 意一yiyi on 2017/3/6.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WTSCityPickerViewBlock)(NSString *selectedCity);

@interface WTSCityPickerView : UIView

@property (strong, nonatomic) WTSCityPickerViewBlock confirmBlock;

- (instancetype)initWithInitialCity:(NSString *)initialCity;

@end
