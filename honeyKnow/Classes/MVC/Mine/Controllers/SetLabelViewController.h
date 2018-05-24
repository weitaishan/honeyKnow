//
//  SetLabelViewController.h
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/24.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "WTSBaseViewController.h"
typedef void(^MarketBlock)(NSMutableArray* marketArr);

@interface SetLabelViewController : WTSBaseViewController

@property (nonatomic, copy) MarketBlock marketBlock;

@property (nonatomic, strong) NSMutableArray* selectArray;
@end
