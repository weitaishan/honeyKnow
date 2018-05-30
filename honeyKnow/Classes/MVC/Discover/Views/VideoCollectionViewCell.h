//
//  VideoCollectionViewCell.h
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/19.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoModel;
@class DiscoverList;
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface VideoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (strong, nonatomic)AVPlayer *myPlayer;//播放器
@property (strong, nonatomic)AVPlayerItem *item;//播放单元
@property (strong, nonatomic)AVPlayerLayer *playerLayer;//播放界面（layer）

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UILabel *lbSignName;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIImageView *stateImgView;
@property (weak, nonatomic) IBOutlet UILabel *lbState;
@property (weak, nonatomic) IBOutlet UIImageView *videoImgView;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UILabel *lbLookNum;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *lbLikeNum;
@property (weak, nonatomic) IBOutlet UIView *addFirendView;
@property (weak, nonatomic) IBOutlet UIImageView *acatarImgView;
@property (weak, nonatomic) IBOutlet UIView *clickView;

@property (nonatomic, strong) VideoModel* videoModel;

@property (nonatomic, strong) DiscoverList* listModel;

@property (nonatomic, strong) NSIndexPath* indexPath;
@property (nonatomic, strong) NSIndexPath* oldIndex;
@end
