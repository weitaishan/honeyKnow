//
//  LoginModel.h
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/17.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "BaseModel.h"

@interface LoginModel : BaseModel
@property (nonatomic, assign) BOOL isNew;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *userSig;

@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, copy) NSString *token;
@end
