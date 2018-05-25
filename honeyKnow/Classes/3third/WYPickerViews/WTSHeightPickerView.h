//
//  WTSHeightPickerView.h
//  WTSChangeInfoDemo
//
//  Created by 意一yiyi on 2017/3/6.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WTSHeightPickerViewBlock)(NSString *selectedHeight);

@interface WTSHeightPickerView : UIView

@property (strong, nonatomic) WTSHeightPickerViewBlock confirmBlock;

- (instancetype)initWithInitialHeight:(NSString *)initialHeight;

@end
