//
//  BaseModel.h
//  DeviseHome
//
//  Created by 魏太山 on 16/12/6.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseData;
@interface BaseModel : NSObject<YYModel>

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger code;

//@property (nonatomic, strong) BaseData *data;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) BOOL isSel;

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString *telephone;

@property (nonatomic, copy) NSString *showTelephone;

@end

@interface BaseData : NSObject<YYModel>

@property (nonatomic, assign) BOOL isSel;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *showTelephone;

@end


