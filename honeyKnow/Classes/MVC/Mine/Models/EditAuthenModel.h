//
//  EditAuthenModel.h
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/24.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "BaseModel.h"

@interface EditAuthenModel : BaseModel


/**
 textFile 显示的文字
 */
@property (nonatomic, copy) NSString* data;


/**
 每个cell 类型
 */
@property (nonatomic, copy) NSString* dataType;


/**
 上传参数 key
 */
@property (nonatomic, copy) NSString* field;


/**
 是否能编辑
 */
@property (nonatomic, assign) BOOL isEdit;


/**
 占位文字
 */
@property (nonatomic, copy) NSString* placeholder;

/**
 标题
 */
@property (nonatomic, copy) NSString* title;

@end
