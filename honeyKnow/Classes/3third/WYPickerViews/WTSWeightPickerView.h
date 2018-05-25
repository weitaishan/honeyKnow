//
//  WTSWeightPickerView.h
//  WTSEditInfoDemo
//
//  Created by AlbertWei on 2018/5/25.
//  Copyright © 2018年 意一yiyi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^WTSWeightPickerViewBlock)(NSString *selectedWeight);

@interface WTSWeightPickerView : UIView


@property (strong, nonatomic) WTSWeightPickerViewBlock confirmBlock;

- (instancetype)initWithInitialWeight:(NSString *)initialWeight;

@end
