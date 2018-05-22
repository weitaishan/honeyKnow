//
//  HomeListSerachCell.h
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeList;

@interface HomeListSerachCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *lbIntroduce;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (nonatomic, strong) HomeList* model;

@end

