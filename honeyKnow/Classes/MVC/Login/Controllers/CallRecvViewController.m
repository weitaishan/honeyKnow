//
//  CallRecvViewController.m
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/25.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "CallRecvViewController.h"

@interface CallRecvViewController ()<TILCallNotificationListener,TILCallStatusListener, TILCallMemberEventListener,TILCallMessageListener>

@property (nonatomic, strong) TILC2CCall *call;
@property (nonatomic, strong) NSString *myId;

/**
 关闭摄像头
 */
@property (weak, nonatomic) IBOutlet UIButton *closeCameraBtn;

/**
 切换摄像头
 */
@property (weak, nonatomic) IBOutlet UIButton *switchCameraBtn;

/**
 静音
 */
@property (weak, nonatomic) IBOutlet UIButton *muteBtn;
@property (weak, nonatomic) IBOutlet UIView *muteView;

/**
 免提
 */
@property (weak, nonatomic) IBOutlet UIButton *freehandBtn;
@property (weak, nonatomic) IBOutlet UIView *freehandView;
@property (weak, nonatomic) IBOutlet UIView *callView;
@property (weak, nonatomic) IBOutlet UIButton *callShutBtn;


@property (weak, nonatomic) IBOutlet UIView *recvView;
@property (weak, nonatomic) IBOutlet UIButton *receShutBtn;
@property (weak, nonatomic) IBOutlet UIButton *receCallBtn;
@property (nonatomic, strong) UIView* switchView;


@end

@implementation CallRecvViewController{
    
    BOOL _isSwitchRender;
    
    BOOL _isSend;
    
    BOOL _isClickSwitchCamera;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _isSend = WTSCallTypeSend;
    
    [self.view addSubview:self.switchView];

    
    
    [[ILiveRoomManager getInstance] setWhite:5];
    [[ILiveRoomManager getInstance] setBeauty:5];

    self.view.backgroundColor = [UIColor blackColor];
    [self setEnableButton];
    [self makeCall];
    _myId = [[ILiveLoginManager getInstance] getLoginId];
}

- (UIView *)switchView{
    
    if (!_switchView) {
        
        _switchView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 120, 160)];
        _switchView.userInteractionEnabled = NO;
        _switchView.backgroundColor = [UIColor clearColor];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            
            //手势触发调用
            [self switchRenderView];
            
        }];
        [_switchView addGestureRecognizer:tap];
    }
    
    return _switchView;
}
#pragma mark - 通话接口相关
- (void)makeCall{
    
    
    if (self.callType == WTSCallTypeSend) {
        
        TILCallConfig * config = [[TILCallConfig alloc] init];
        TILCallBaseConfig * baseConfig = [[TILCallBaseConfig alloc] init];
        baseConfig.callType = TILCALL_TYPE_VIDEO;
        baseConfig.isSponsor = YES;
        baseConfig.peerId = _peerId;
        baseConfig.heartBeatInterval = 0;
        config.baseConfig = baseConfig;
        
        TILCallListener * listener = [[TILCallListener alloc] init];
        //注意：
        //［通知回调］可以获取通话的事件通知，建议双人和多人都走notifListener
        // [通话状态回调] 也可以获取通话的事件通知
        listener.callStatusListener = self;
        listener.memberEventListener = self;
        listener.notifListener = self;
        
        config.callListener = listener;
        TILCallSponsorConfig *sponsorConfig = [[TILCallSponsorConfig alloc] init];
        sponsorConfig.waitLimit = 0;
        sponsorConfig.callId = (int)([[NSDate date] timeIntervalSince1970]) % 1000 * 1000 + arc4random() % 1000;
        sponsorConfig.onlineInvite = NO;
        sponsorConfig.controlRole = @"hostTest";
        config.sponsorConfig = sponsorConfig;
        
        _call = [[TILC2CCall alloc] initWithConfig:config];
        
        [_call createRenderViewIn:self.view];
        __weak typeof(self) ws = self;
        [_call makeCall:nil result:^(TILCallError *err) {
            if(err){
                [ws setText:[NSString stringWithFormat:@"呼叫失败:%@-%d-%@",err.domain,err.code,err.errMsg]];
                [self addToast:@"呼叫失败"];
                [ws selfDismiss];
            }
            else{
                [ws setText:@"呼叫成功"];
                if ([SystemService shareInstance].isTeacher == 1) {
                    
                    [WTSHttpTool startVideoBillingWithRoomId:_peerId];
                }
            }
        }];
        
    }else if (self.callType == WTSCallTypeRecv){
        
        TILCallConfig * config = [[TILCallConfig alloc] init];
        TILCallBaseConfig * baseConfig = [[TILCallBaseConfig alloc] init];
        baseConfig.callType = TILCALL_TYPE_VIDEO;
        baseConfig.isSponsor = NO;
        baseConfig.peerId = _invite.sponsorId;
        baseConfig.heartBeatInterval = 0;
        baseConfig.isAutoResponseBusy = YES;
        config.baseConfig = baseConfig;
        
        TILCallListener * listener = [[TILCallListener alloc] init];
        listener.callStatusListener = self;
        //注意：
        //［通知回调］可以获取通话的事件通知，建议双人和多人都走notifListener
        // [通话状态回调] 也可以获取通话的事件通知
        listener.memberEventListener = self;
        listener.notifListener = self;
        listener.msgListener = self;
        
        config.callListener = listener;
        
        TILCallResponderConfig * responderConfig = [[TILCallResponderConfig alloc] init];
        responderConfig.callInvitation = _invite;
        responderConfig.controlRole = @"interactTest";
        config.responderConfig = responderConfig;
        _call = [[TILC2CCall alloc] initWithConfig:config];
    }
    
    
}

- (IBAction)hangUp:(id)sender {
    __weak typeof(self) ws = self;
    
    if (self.callType == WTSCallTypeSend) {
        
        [_call cancelCall:^(TILCallError *err) {
            if(err){
                [ws setText:[NSString stringWithFormat:@"取消通话邀请失败:%@-%d-%@",err.domain,err.code,err.errMsg]];
            }
            else{
                [ws setText:@"取消通话邀请成功"];
            }
            [ws selfDismiss];
        }];
    }else if(self.callType == WTSCallTypeBusying){
        [self hangup];
        
        
        
    }
    
    
}

- (void)hangup{
    
    __weak typeof(self) ws = self;

    [_call hangup:^(TILCallError *err) {
        if(err){
            [ws setText:[NSString stringWithFormat:@"挂断失败:%@-%d-%@",err.domain,err.code,err.errMsg]];
//            [self addToast:@"挂断失败"];
            
        }
        else{
            [ws setText:@"挂断成功"];
            if ([SystemService shareInstance].isTeacher == 1) {
                
                [WTSHttpTool stopVideoBillingWithRoomId:_peerId];
            }
        }
        [ws selfDismiss];
    }];
}
- (IBAction)recvInvite:(id)sender {
    __weak typeof(self) ws = self;
    [_call createRenderViewIn:self.view];
    [_call accept:^(TILCallError *err) {
        if(err){
            [ws setText:[NSString stringWithFormat:@"接受失败:%@-%d-%@",err.domain,err.code,err.errMsg]];
            [self addToast:@"接受通话失败"];

            [ws selfDismiss];
        }
        else{
            [ws setText:@"通话建立成功"];
            self.callType = WTSCallTypeBusying;
            [ws setEnableButton];
        }
    }];
}




- (IBAction)cancelInvite:(UIButton *)sender {
    __weak typeof(self) ws = self;
    [_call refuse:^(TILCallError *err) {
        if(err){
            [ws setText:[NSString stringWithFormat:@"拒绝失败:%@-%d-%@",err.domain,err.code,err.errMsg]];
            [self addToast:@"拒绝失败"];

        }
        else{
            [ws setText:@"拒绝成功"];
            [ws selfDismiss];
        }
    }];
    
   
        
    
    
}

#pragma mark - 设备操作（使用ILiveRoomManager接口，也可以使用TILCallSDK接口）
- (IBAction)closeCamera:(id)sender {
    self.switchCameraBtn.userInteractionEnabled = NO;
    ILiveRoomManager *manager = [ILiveRoomManager getInstance];
    BOOL isOn = [manager getCurCameraState];
    cameraPos pos = [manager getCurCameraPos];
    __weak typeof(self) ws = self;
    [manager enableCamera:pos enable:!isOn succ:^{
        NSString *text = !isOn?@"打开摄像头成功":@"关闭摄像头成功";
        [ws setText:text];
        [ws.closeCameraBtn setTitle:(!isOn?@"关闭摄像头":@"打开摄像头") forState:UIControlStateNormal];
        self.switchCameraBtn.userInteractionEnabled = YES;

    }failed:^(NSString *moudle, int errId, NSString *errMsg) {
        NSString *text = !isOn?@"打开摄像头失败":@"关闭摄像头失败";
        [ws setText:[NSString stringWithFormat:@"%@:%@-%d-%@",text,moudle,errId,errMsg]];
        self.switchCameraBtn.userInteractionEnabled = YES;

    }];
}

- (IBAction)switchCamera:(id)sender {
    self.closeCameraBtn.userInteractionEnabled = NO;

    _isClickSwitchCamera = YES;
    ILiveRoomManager *manager = [ILiveRoomManager getInstance];
    __weak typeof(self) ws = self;
    [manager switchCamera:^{
        [ws setText:@"切换摄像头成功"];
        _isClickSwitchCamera = NO;
        self.closeCameraBtn.userInteractionEnabled = YES;

    } failed:^(NSString *moudle, int errId, NSString *errMsg) {
        [ws setText:[NSString stringWithFormat:@"切换摄像头失败:%@-%d-%@",moudle,errId,errMsg]];
        _isClickSwitchCamera = NO;
        self.closeCameraBtn.userInteractionEnabled = YES;

    }];
}

- (IBAction)closeMic:(id)sender {
    ILiveRoomManager *manager = [ILiveRoomManager getInstance];
    BOOL isOn = [manager getCurMicState];
    __weak typeof(self) ws = self;
    [manager enableMic:!isOn succ:^{
        NSString *text = !isOn?@"打开麦克风成功":@"关闭麦克风成功";
        [ws setText:text];
        ws.muteBtn.selected = isOn;
      
    } failed:^(NSString *moudle, int errId, NSString *errMsg) {
        NSString *text = !isOn?@"打开麦克风失败":@"关闭麦克风失败";
        [ws setText:[NSString stringWithFormat:@"%@:%@-%d-%@",text,moudle,errId,errMsg]];
    }];
}

- (IBAction)switchReceiver:(id)sender {
    ILiveRoomManager *manager = [ILiveRoomManager getInstance];
    __weak typeof(self) ws = self;
    QAVOutputMode mode = [manager getCurAudioMode];
    [ws setText:(mode == QAVOUTPUTMODE_EARPHONE?@"切换扬声器成功":@"切换到听筒成功")];
    ws.freehandBtn.selected = mode == QAVOUTPUTMODE_SPEAKER;

    if(mode == QAVOUTPUTMODE_EARPHONE){
        [manager setAudioMode:QAVOUTPUTMODE_SPEAKER];
    }
    else{
        [manager setAudioMode:QAVOUTPUTMODE_EARPHONE];
    }
}


//切换窗口
- (void)switchRenderView{
    
    if (!_isSend) {
        
         BOOL result = [_call switchRenderView:_peerId with:_myId];
        if (result) {
            _isSwitchRender = !_isSwitchRender;
        }
        
    }else{
        
        BOOL result = [_call switchRenderView:_invite.sponsorId with:_myId];
        if (result) {
            _isSwitchRender = !_isSwitchRender;
        }
    }
}


#pragma mark - 音视频事件回调
- (void)onMemberAudioOn:(BOOL)isOn members:(NSArray *)members
{
    
}

- (void)onMemberCameraVideoOn:(BOOL)isOn members:(NSArray *)members
{
    if(isOn){
        for (TILCallMember *member in members) {
            NSString *identifier = member.identifier;
            if([_myId isEqualToString:identifier]){
                
                if (_isSwitchRender) {
                    
                    [_call addRenderFor:_myId atFrame:CGRectMake(20, 20, 120, 160)];
                    self.switchView.userInteractionEnabled = YES;
                    
                }else{
                    
                    [_call addRenderFor:_myId atFrame:self.view.bounds];
                    [_call sendRenderViewToBack:_myId];
                }
             
            }
            else{
                
                if (_isSwitchRender) {
                    
                    [_call addRenderFor:_myId atFrame:self.view.bounds];
                    [_call sendRenderViewToBack:_myId];
                    
                }else{
                    
                    [_call addRenderFor:identifier atFrame:CGRectMake(20, 20, 120, 160)];
                    self.switchView.userInteractionEnabled = YES;
                    [self.view bringSubviewToFront:self.switchView];
                }
                
          
            }
        }
    }
    else{
        for (TILCallMember *member in members) {
            
            NSString *identifier = member.identifier;
            [_call removeRenderFor:identifier];
            if (!member.isCameraVideo && !member.isAudio) {
                [self hangup];

            }
        }
    }
}



#pragma mark - 通知回调
//注意：
//［通知回调］可以获取通话的事件通知
// [通话状态回调] 也可以获取通话的事件通知
- (void)onRecvNotification:(TILCallNotification *)notify
{
    //    TILCALL_NOTIF_ACCEPTED      = 0x82,
    //    TILCALL_NOTIF_CANCEL,
    //    TILCALL_NOTIF_TIMEOUT,
    //    TILCALL_NOTIF_REFUSE,
    //    TILCALL_NOTIF_HANGUP,
    //    TILCALL_NOTIF_LINEBUSY,
    //    TILCALL_NOTIF_HEARTBEAT     = 0x88,
    //    TILCALL_NOTIF_INVITE        = 0x89,
    //    TILCALL_NOTIF_DISCONNECT    = 0x8A,
    
    NSInteger notifId = notify.notifId;
    NSString *sender = notify.sender;
    switch (notifId) {
        case TILCALL_NOTIF_ACCEPTED:
            [self setText:@"通话建立成功"];
            
            self.callType = WTSCallTypeBusying;
            [self setEnableButton];
            break;
        case TILCALL_NOTIF_TIMEOUT:
            [self setText:@"对方没有接听"];
            [self addToast:@"您通话的用户没有接听"];

            [self selfDismiss];
            break;
        case   TILCALL_NOTIF_CANCEL:{
            
            [self setText:@"对方取消拨打"];
            [self addToast:@"您通话的用户取消拨打"];
            
            [self selfDismiss];
            break;
        }
        case TILCALL_NOTIF_REFUSE:
            [self setText:@"对方拒绝接听"];
            [self addToast:@"您通话的用户拒绝接听"];

            [self selfDismiss];
            break;
        case TILCALL_NOTIF_HANGUP:
            [self setText:@"对方已挂断"];
            [self addToast:@"您通话的用户已挂断"];
            if ([SystemService shareInstance].isTeacher == 1) {
                
                [WTSHttpTool stopVideoBillingWithRoomId:_peerId];
            }
            [self selfDismiss];
            break;
        case TILCALL_NOTIF_LINEBUSY:
            [self setText:@"对方占线"];
            [self addToast:@"您通话的用户正忙，请稍后在播"];

            [self selfDismiss];
            break;
        case TILCALL_NOTIF_HEARTBEAT:
            [self setText:[NSString stringWithFormat:@"%@发来心跳",sender]];
            break;
        case TILCALL_NOTIF_DISCONNECT:
            [self setText:@"对方失去连接"];
            [self addToast:@"您通话的用户失去连接"];
            [self hangup];
            break;
        default:
            break;
    }
}

#pragma mark - 通话状态事件回调



#pragma mark - 界面管理


- (void)setEnableButton{
    
    
    if (self.callType == WTSCallTypeRecv) {
        
        self.callView.hidden = YES;
        self.freehandView.hidden = YES;
        self.muteView.hidden = YES;
        self.closeCameraBtn.hidden = YES;
        self.switchCameraBtn.hidden = YES;
        self.recvView.hidden = NO;
        
        
    }else if(self.callType == WTSCallTypeSend){
        [self.callShutBtn setTitle:@"取消" forState:UIControlStateNormal];
        self.callView.hidden = NO;
        self.freehandView.hidden = YES;
        self.muteView.hidden = YES;
        self.closeCameraBtn.hidden = YES;
        self.switchCameraBtn.hidden = YES;
        self.recvView.hidden = YES;

    }else{
        [self.callShutBtn setTitle:@"挂断" forState:UIControlStateNormal];
        self.callView.hidden = NO;
        self.freehandView.hidden = NO;
        self.muteView.hidden = NO;
        self.closeCameraBtn.hidden = NO;
        self.switchCameraBtn.hidden = NO;
        self.recvView.hidden = YES;
    }
    

}

- (void)setText:(NSString *)text
{
//    NSString *tempText = _textView.text;
//    tempText = [tempText stringByAppendingString:@"\n"];
//    tempText = [tempText stringByAppendingString:text];
//    _textView.text = tempText;
}


- (void)selfDismiss
{
    //为了看到关闭打印的信息，demo延迟1秒关闭
    __weak typeof(self) ws = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ws dismissViewControllerAnimated:YES completion:nil];
//    });
}


@end
