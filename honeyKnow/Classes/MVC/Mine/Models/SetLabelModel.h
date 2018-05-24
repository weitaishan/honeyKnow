//
//  SetLabelModel.h
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/24.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "BaseModel.h"
@class SetLabelItem;
@interface SetLabelModel : BaseModel

@property (nonatomic, strong) NSArray<SetLabelItem *> *data;


@end


@interface SetLabelItem : BaseModel

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString* name;

@property (nonatomic, copy) NSString* createdTime;

@property (nonatomic, copy) NSString* modifyTime;

@property (nonatomic, copy) NSString* isDeleted;

@end
