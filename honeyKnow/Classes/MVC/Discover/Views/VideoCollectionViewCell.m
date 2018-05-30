//
//  VideoCollectionViewCell.m
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/19.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "VideoCollectionViewCell.h"
#import "VideoModel.h"
#import "DiscoverListModel.h"
@implementation VideoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
  
//    [self playWithUrl:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        
        if (self.listModel.Id > 0) {
            
            [[SystemService shareInstance] callVideoTelePhoneWithPeerId:IntStr(self.listModel.Id)];
            
        }else{
            
            
        }
        
    }];
    [self.videoImgView addGestureRecognizer:tap];
    
    [[self.shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        [WTSHttpTool shareWechat];
        
    }];
    
    
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] init];
    
    [[tap2 rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        
        
        NSLog(@"CMTimeGetSeconds(self.myPlayer.currentItem.currentTime) = %lf,     CMTimeGetSeconds(self.avPlayer.currentItem.duration) = %lf",CMTimeGetSeconds(self.myPlayer.currentItem.currentTime) ,CMTimeGetSeconds(self.myPlayer.currentItem.duration));
        if(self.myPlayer.rate==0){ //说明时暂停
            [self.myPlayer play];
            self.playBtn.hidden = YES;
            if (CMTimeGetSeconds(self.myPlayer.currentItem.currentTime) == CMTimeGetSeconds(self.myPlayer.currentItem.duration)) {
                
                [_item seekToTime:kCMTimeZero]; // item 跳转到初始
                [_myPlayer play];
            }
        }else if(self.myPlayer.rate==1){//正在播放
            [self.myPlayer pause];
            self.playBtn.hidden = NO;

        }
        
    }];
    [self.clickView addGestureRecognizer:tap2];

}


// 播放完成后
- (void)playbackFinished:(NSNotification *)notification {
    NSLog(@"视频播放完成通知");
    _item = [notification object];
    [_item seekToTime:kCMTimeZero]; // item 跳转到初始
    [_myPlayer play]; // 循环播放
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:
(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        //取出status的新值
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey]intValue];
        switch (status) {
            case AVPlayerItemStatusFailed:
                NSLog(@"item 有误");
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"准好播放了");
                break;
            case AVPlayerItemStatusUnknown:
                NSLog(@"视频资源出现未知错误");
                break;
            default:
                break;
        }
    }
    //移除监听（观察者）
    [object removeObserver:self forKeyPath:@"status"];
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
-(void)setListModel:(DiscoverList *)listModel{
    
    
    _listModel = listModel;
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:listModel.mainImgUrl] placeholderImage:[UIImage imageNamed:@"pic_anchor"]];
    
    _lbLikeNum.text = IntStr(listModel.loveNum);
    
    _lbLookNum.text = IntStr(listModel.viewNum);
    
    
    [self getVideoData];
    
    [self playWithUrl:listModel.vedioUrl];

    
    WeakSelf;
    [[_likeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
       
        x.selected = !x.selected;
        _lbLikeNum.text = IntStr(_lbLikeNum.text.integerValue + ( x.isSelected ? 1 : -1));
        
        
        [WTSHttpTool requestWihtMethod:RequestMethodTypePost url:URL_VIDEO_LIKE_UPDATE params:@{@"videoId" : IntStr(weakSelf.listModel.Id)}.mutableCopy success:^(id response) {

            if ([response[@"success"] integerValue]){

                

            }


        } failure:^(NSError *error) {


        }];

    }];
    
    
    
}

- (void)playWithUrl:(NSString *)urlString{
    
    
    [self.myPlayer pause];
    [self.playerLayer removeFromSuperlayer];
    NSURL *mediaURL = [NSURL URLWithString:urlString];
    self.item = [AVPlayerItem playerItemWithURL:mediaURL];
    self.myPlayer = [AVPlayer playerWithPlayerItem:self.item];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
    [self.bgView.layer addSublayer:self.playerLayer];
    self.playerLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.myPlayer play];
    [self.item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];

    
    
    if(self.myPlayer.rate==0){ //说明时暂停
        self.playBtn.hidden = NO;
    }else if(self.myPlayer.rate==1){//正在播放
        self.playBtn.hidden = YES;
        
    }
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];

}

- (void)getVideoData{
    
    WeakSelf;
    [WTSHttpTool requestWihtMethod:RequestMethodTypeGet url:[NSString stringWithFormat:@"%@?videoId=%ld", URL_VIDEO_VIDEO_INFO,self.listModel.Id] params:nil success:^(id response) {
        
        if ([response[@"success"] integerValue]){
            
            
            VideoModel* viewModel = [VideoModel yy_modelWithJSON:response[@"data"]];
            [weakSelf updateCellDataWithModel:viewModel];
            
        }
        
        
    } failure:^(NSError *error) {
        
        
    }];
}
- (void)updateCellDataWithModel:(VideoModel *)model{
    
    [self.acatarImgView sd_setImageWithURL:[NSURL URLWithString:model.userInfo.avator] placeholderImage:[UIImage imageNamed:@"pic_avatar"]];

    self.lbName.text = model.userInfo.nickName ? model.userInfo.nickName : @"";
    self.lbSignName.text = model.userInfo.introduce ? model.userInfo.introduce : @"";
    
    if ([model.isLike integerValue]) {
        
        self.likeBtn.selected = YES;
        
    }else{
        
        self.likeBtn.selected = NO;

    }
    
    //1是在线  0 是离线  2是繁忙  3勿扰icon_mode_red  icon_mode_green icon_rest
    if ([model.userInfo.status integerValue] == 1) {
        
        self.lbState.text = @"在线";
        self.stateImgView.image = [UIImage imageNamed:@"icon_mode_green"];
    }else if ([model.userInfo.status integerValue] == 0){
        
        self.lbState.text = @"离线";
        self.stateImgView.image = [UIImage imageNamed:@"icon_mode_red"];
    }else if ([model.userInfo.status integerValue] == 2){
        
        self.lbState.text = @"繁忙";
        self.stateImgView.image = [UIImage imageNamed:@"icon_rest"];
    }else if ([model.userInfo.status integerValue] == 3){
        
        self.lbState.text = @"勿扰";
        self.stateImgView.image = [UIImage imageNamed:@"icon_rest"];
    }
}


@end
