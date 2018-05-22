//
//  DiscoverListViewController.h
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "WTSBaseViewController.h"

@interface DiscoverListViewController : WTSBaseViewController<ZJScrollPageViewChildVcDelegate>
@property (nonatomic, assign) DiscoverListType type;

@end
