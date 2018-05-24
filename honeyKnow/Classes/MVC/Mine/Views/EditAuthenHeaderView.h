//
//  EditAuthenHeaderView.h
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/24.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReloadEditTableView)(NSMutableArray* imgArr, NSArray* assets);

@interface EditAuthenHeaderView : UIView
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray<UIImage *> *imgArr;
@property (nonatomic, strong) NSArray *assets;


@property (nonatomic, copy) ReloadEditTableView reloadBlock;
- (instancetype)initWithImgArr:(NSMutableArray *)imgArr assets:(NSArray *)assets;
@end
