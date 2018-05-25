//
//  CallRecvViewController.h
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/25.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "WTSBaseViewController.h"
/**
 *  电话类型
 */
typedef NS_ENUM(NSUInteger, WTSCallType) {
    /**
     *  打电话
     */
    WTSCallTypeSend = 0,
    /**
     *  接电话
     */
    WTSCallTypeRecv,
    /**
     *  通话中
     */
    WTSCallTypeBusying
};
@interface CallRecvViewController : WTSBaseViewController
@property (strong, nonatomic) TILCallInvitation *invite;

@property (nonatomic, assign) WTSCallType callType;


/**
 通话id
 */
@property (nonatomic, copy) NSString *peerId;

@end
