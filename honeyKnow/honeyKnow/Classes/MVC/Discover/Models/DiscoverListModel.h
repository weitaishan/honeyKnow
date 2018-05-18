//
//  DiscoverListModel.h
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "BaseModel.h"
@class DiscoverList;
@interface DiscoverListModel : BaseModel
@property (nonatomic, strong) NSArray<DiscoverList *> *data;

@end

@interface DiscoverList : BaseModel

@property (nonatomic, assign) NSInteger Id;
/** 视频地址*/
@property (nonatomic, copy) NSString *vedioUrl;
/** 用户id*/
@property (nonatomic, assign) NSInteger userId;
/** 创建时间*/
@property (nonatomic, copy) NSString *createdTime;
/** 修改时间*/
@property (nonatomic, copy) NSString *modifyTime;
/**是否已经删除*/
@property (nonatomic, copy) NSString *isDeleted;
/**标题*/
@property (nonatomic, copy) NSString *title;
/**结束*/
@property (nonatomic, copy) NSString *introduct;
/**喜欢量*/
@property (nonatomic, assign) NSInteger loveNum;
/**观看量*/
@property (nonatomic, assign) NSInteger viewNum;
/**封面图*/
@property (nonatomic, copy) NSString *mainImgUrl;
/**是否锁定*/
@property (nonatomic, copy) NSString *isLock;
/**价格*/
@property (nonatomic, assign) NSInteger price;
/**头像*/
@property (nonatomic, copy) NSString *avator;

@end
