//
//  DiscoverListCell.h
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DiscoverList;
@interface DiscoverListCell : UICollectionViewCell
@property (nonatomic, strong) DiscoverList* model;
@property (weak, nonatomic) IBOutlet UILabel *lbIntroduce;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbLikeNum;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

@end
