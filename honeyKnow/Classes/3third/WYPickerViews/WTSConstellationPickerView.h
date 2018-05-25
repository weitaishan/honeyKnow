//
//  WTSConstellationPickerView.h
//  WTSEditInfoDemo
//
//  Created by AlbertWei on 2018/5/25.
//  Copyright © 2018年 意一yiyi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^WTSConstellationPickerViewBlock)(NSString *selectedConstellation);

@interface WTSConstellationPickerView : UIView

@property (strong, nonatomic) WTSConstellationPickerViewBlock confirmBlock;

- (instancetype)initWithInitialConstellation:(NSString *)initialConstellation;
@end
