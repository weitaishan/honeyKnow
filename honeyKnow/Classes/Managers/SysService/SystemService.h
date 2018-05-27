//
//  SystemService.h
//  JaadeeRn
//
//  Created by AlbertWei on 2018/3/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_OPTIONS(NSUInteger, WTSPermissionType) {
  /** 相册*/
  WTSPermissionTypePhoto = 0x01,
  /** 相机*/
  WTSPermissionTypeCamera = 0x02,
  /** 麦克风*/
  WTSPermissionTypeMicrophone = 0x04

};

/**
 *  账户类型
 */
typedef NS_ENUM(NSUInteger, WTSPermissionStatus) {
  /**
   *  无权限
   */
  WTSPermissionStatusNo = 0,
  /**
   *  有权限
   */
  WTSPermissionStatusYes,

};

@interface SystemService : NSObject


/**
 是否是主播 1是主播 5是认证 0不是
 */
@property (nonatomic, assign) NSInteger isTeacher;
+(instancetype) shareInstance;

-(id)toArrayOrNSDictionary:(NSString *)json;
- (NSString*)DataTOjsonString:(id)object;
/**
 权限判断

 @param type       权限类型  多个用 |  如:WTSPermissionTypePhoto | WTSPermissionTypeCamera | WTSPermissionTypeMicrophone
 @param vc         传入当前控制器，如果有，则会弹出去开启权限弹窗
 @param completion 是否有权限回调
 */
- (void)wtsAccessPermissionJudgeWithType:(WTSPermissionType)type
                          viewController:(UIViewController *)vc
                              completion:(void(^)(WTSPermissionStatus status))completion;

/**
 登录腾讯云 音视频
 */
- (void)ILiveLogin;
/**
 *  退出登录
 */
- (void)exitLoginWithTitle:(NSString *)title message:(NSString *)message;


/**
 打视频电话
 
 @param peerId userId
 @param actorId 主播id
 */
- (void)callVideoTelePhoneWithPeerId:(NSString *)peerId;

//- (void)callVideoTelePhoneWithPeerId:(NSString *)peerId actorId:(NSString *)actorId complete:(void (^)(BOOL isCallSend ))complete
@end
