//
//  MineListCell.h
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineListModel;
@interface MineListCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray<MineListModel *>* listArray;

@end
