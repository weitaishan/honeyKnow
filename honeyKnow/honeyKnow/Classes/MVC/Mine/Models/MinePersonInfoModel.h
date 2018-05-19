//
//  MinePersonInfoModel.h
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "BaseModel.h"

@interface MinePersonInfoModel : BaseModel

/**
 生日
 */
@property (nonatomic, copy) NSString* birthday;
/**
 签名
 */
@property (nonatomic, copy) NSString* signName;
/**
 性别
 */
@property (nonatomic, copy) NSString*  gender;
/**
 星级
 */
@property (nonatomic, copy) NSString* star;
/**
 昵称
 */
@property (nonatomic, copy) NSString* nickName;
/**
 介绍
 */
@property (nonatomic, copy) NSString* introduce;
/**
 体重
 */
@property (nonatomic, copy) NSString* weight;
/**
 关注数量
 */
@property (nonatomic, assign) NSInteger focusNum;
/**
 身份证
 */
@property (nonatomic, copy) NSString* certNo;
/**
 平衡
 */
@property (nonatomic, copy) NSString* balance;
/**
 价格
 */
@property (nonatomic, copy) NSString* price;
/**
 头像
 */
@property (nonatomic, copy) NSString* avator;
/**
 地区
 */
@property (nonatomic, copy) NSString* location;
/**
 用户id
 */
@property (nonatomic, assign) NSInteger Id;

/**
 身高
 */
@property (nonatomic, copy) NSString* tall;

/**
 是否是老师
 */
@property (nonatomic, assign) NSInteger isTeacher;
/**
状态
 */
@property (nonatomic, assign) NSInteger status;

@end
