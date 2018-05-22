//
//  VideoModel.h
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/19.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "BaseModel.h"
#import "HomeListModel.h"
#import "DiscoverListModel.h"
@interface VideoModel : BaseModel

@property (nonatomic, strong) HomeList *userInfo;


/**
 是否关注
 */
@property (nonatomic, copy) NSString* isFocus;

/**
 是否喜欢
 */
@property (nonatomic, copy) NSString* isLike;

@property (nonatomic, strong) DiscoverListModel *videoInfo;

@end



