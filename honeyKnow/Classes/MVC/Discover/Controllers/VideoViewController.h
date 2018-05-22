//
//  VideoViewController.h
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/19.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "WTSBaseViewController.h"
@class DiscoverList;
@interface VideoViewController : WTSBaseViewController
@property (nonatomic, strong) NSMutableArray<DiscoverList *>* listArray;
@property (nonatomic, assign) NSInteger index;

@end
