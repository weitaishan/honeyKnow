//
//  MineListModel.h
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "BaseModel.h"

@interface MineListModel : BaseModel

@property (nonatomic, copy) NSString* imgName;

@property (nonatomic, copy) NSString* title;

//0为title 1为switch(勿扰)
@property (nonatomic, assign) NSInteger type;
@end
