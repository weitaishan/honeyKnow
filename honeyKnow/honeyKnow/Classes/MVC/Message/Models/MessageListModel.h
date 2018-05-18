//
//  MessageListModel.h
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "BaseModel.h"

@interface MessageListModel : BaseModel
@property (nonatomic, strong) UIImage* image;
@property (nonatomic, copy) NSString* title;

@end
