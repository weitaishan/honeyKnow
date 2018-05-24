//
//  WYHeightPickerView.h
//  WYChangeInfoDemo
//
//  Created by 意一yiyi on 2017/3/6.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WYHeightPickerViewBlock)(NSString *selectedHeight);

@interface WYHeightPickerView : UIView

@property (strong, nonatomic) WYHeightPickerViewBlock confirmBlock;

- (instancetype)initWithInitialHeight:(NSString *)initialHeight;

@end
