//
//  SystemService.m
//  JaadeeRn
//
//  Created by AlbertWei on 2018/3/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "SystemService.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "LoginSelectViewController.h"
#import "BaseNavigationViewController.h"
#import "IMALoginViewController.h"
#import "CallRecvViewController.h"
#import "PayViewController.h"
//#import <ILiveSDK/ILiveSDK.h>
//#import <ILiveSDK/ILiveCoreHeader.h>

@implementation SystemService
static SystemService* _instance = nil;

+(instancetype) shareInstance{
  
  static dispatch_once_t onceToken ;
  dispatch_once(&onceToken, ^{
    _instance = [[super allocWithZone:NULL] init] ;
    //不是使用alloc方法，而是调用[[super allocWithZone:NULL] init]
    //已经重载allocWithZone基本的对象分配方法，所以要借用父类（NSObject）的功能来帮助出处理底层内存分配的杂物
  }) ;
  
  return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone{
  
  return [SystemService shareInstance] ;
}

-(id) copyWithZone:(NSZone *)zone{
  
  return [SystemService shareInstance] ;//return _instance;
}

-(id) mutablecopyWithZone:(NSZone *)zone{
  
  return [SystemService shareInstance] ;
}

-(id)toArrayOrNSDictionary:(NSString *)json{
  
  NSError *error = nil;
  
  NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];

  id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                  options:NSJSONReadingAllowFragments
                                                    error:&error];
  
  if (jsonObject != nil && error == nil){
    return jsonObject;
  }else{
    // 解析错误
    return nil;
  }
}

- (NSString*)DataTOjsonString:(id)object {
  
  NSString *jsonString = nil;
  NSError *error;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
  if (!jsonData) {
    
    NSLog(@"Got an error: %@", error);
    
  } else {
    
    jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
  }
  return jsonString;
}

/** 权限判断*/
/**
 权限判断
 
 @param type       权限类型  多个用 |  如:WTSPermissionTypePhoto | WTSPermissionTypeCamera | WTSPermissionTypeMicrophone
 @param vc         传入当前控制器，如果有，则会弹出去开启权限弹窗
 @param completion 是否有权限回调
 */
- (void)wtsAccessPermissionJudgeWithType:(WTSPermissionType)type
                          viewController:(UIViewController *)vc
                              completion:(void(^)(WTSPermissionStatus status))completion{
  
  if (type & WTSPermissionTypePhoto) {
    
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
      
      
      [self permissionAlertWithViewController:vc showAlert:@"无相册权限" message:@"请去设置开启相册权限" completion:completion];
      return;
    }else if (author == AVAuthorizationStatusNotDetermined) {
      
      [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
        if (status == PHAuthorizationStatusAuthorized) {
          
          completion(WTSPermissionStatusYes);

        }else{
          
          completion(WTSPermissionStatusNo);
          return;
        }
        
      }];
  }
  
  if (type & WTSPermissionTypeCamera) {
    
    //判断用户是否允许访问相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
      //无权限
      [self permissionAlertWithViewController:vc showAlert:@"无相机权限" message:@"请去设置开启相机权限" completion:completion];

      return;
    }else if (author == AVAuthorizationStatusNotDetermined) {
      
      
      [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if (granted) {
          
          completion(WTSPermissionStatusYes);

        }else{
          
          completion(WTSPermissionStatusNo);
          return;
        }
      }];
      
    }
    
    
  }
  
  
  if (type & WTSPermissionTypeMicrophone) {
    
    //判断用户是否允许访问麦克风权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
      //无权限
      //无权限
      [self permissionAlertWithViewController:vc showAlert:@"无麦克风权限" message:@"请去设置开启麦克风权限" completion:completion];
      
      return;
    }else if (authStatus == AVAuthorizationStatusNotDetermined) {
      
      [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        if (granted) {
          
          completion(WTSPermissionStatusYes);
          
        }else{
          
          completion(WTSPermissionStatusNo);
          return;
        }
        
      }];
      
    }
    
    
  }
}
  
  completion(WTSPermissionStatusYes);

}



- (void)permissionAlertWithViewController:(UIViewController *)vc
                                showAlert:(NSString *)title
                                  message:(NSString *)message
                               completion:(void(^)(WTSPermissionStatus status))completion{
  
  
  if (vc) {
    [[WTSAlertViewTools shareInstance] showAlert:title message:message cancelTitle:@"取消" titleArray:@[@"去设置"] viewController:vc confirm:^(NSInteger buttonTag){
      
      if (buttonTag == cancelIndex) {
        
        
      }else{
        
        //无权限 引导去开启
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
          [[UIApplication sharedApplication] openURL:url];
        }
        
        
      }
      
      completion(WTSPermissionStatusNo);
      
      
    }];
    
  }else{
    
      
      completion(WTSPermissionStatusNo);
    
  }
 
  
}



/**
 登录腾讯云 音视频
 */
- (void)ILiveLogin{
    
    

    [[[IMALoginViewController alloc] init] loging];

//    //登录sdk
    
}

/**
 *  退出登录
 */
- (void)exitLoginWithTitle:(NSString *)title message:(NSString *)message{
    
    [[WTSAlertViewTools shareInstance] showAlert:title message:message cancelTitle:@"取消" titleArray:@[@"确定"] viewController:APP_DELEGATE().getCurrentVC confirm:^(NSInteger buttonTag){
        
        if (buttonTag == cancelIndex) {
            
        }else{
            
            [NSUSERDEFAULTS removeObjectForKey:USER_TOKEN];
            [NSUSERDEFAULTS removeObjectForKey:USER_IDENTIFIER];
            [NSUSERDEFAULTS removeObjectForKey:USER_USERSIG];
            [NSUSERDEFAULTS removeObjectForKey:USER_IS_TEACHER];

            [[IMAPlatform sharedInstance] offlineLogin];
            [[TIMManager sharedInstance] logout:^() {
                NSLog(@"logout succ");
            } fail:^(int code, NSString * err) {
                NSLog(@"logout fail: code=%d err=%@", code, err);
            }];
            
            LoginSelectViewController* loginVC = [MAIN_SB instantiateViewControllerWithIdentifier:@"loginSelectViewController"];
            
            BaseNavigationViewController* navVC = [[BaseNavigationViewController alloc] initWithRootViewController:loginVC];
            APP_DELEGATE().window.rootViewController = navVC;
            
        }
        
    }];
    
}

/**
 打视频电话
 
 @param peerId userId
 @param actorId 主播id
 */
- (void)callVideoTelePhoneWithPeerId:(NSString *)peerId{
    
//#ifdef DEBUG
//
//    CallRecvViewController *make = [MAIN_SB instantiateViewControllerWithIdentifier:@"callRecvViewController"];
//    make.peerId = peerId;
//    make.callType = WTSCallTypeSend;
//    [APP_DELEGATE().getCurrentVC presentViewController:make animated:YES completion:nil];
//#else
//
    [WTSHttpTool requestWihtMethod:RequestMethodTypePost url:URL_PAYMENT_PAY params:@{@"actorId" : peerId}.mutableCopy success:^(id response) {
        
        if ([response[@"success"] integerValue]){
            
            if ([response[@"code"] integerValue] == 5001){
                
                NSLog(@"余额不足");
                [[WTSAlertViewTools shareInstance] showAlert:@"余额不足" message:@"您的账号余额不足以发大V视频五分钟，无法视频聊天！\n是否立即充值？" cancelTitle:@"取消" titleArray:@[@"立即充值"] viewController:APP_DELEGATE().getCurrentVC confirm:^(NSInteger buttonTag){
                    
                    if (buttonTag == cancelIndex) {
                        
                        
                    }else{
                        
                        PayViewController* vc = [[PayViewController alloc] init];
                        vc.hidesBottomBarWhenPushed = YES;
                        [APP_DELEGATE().getCurrentVC.navigationController pushViewController:vc animated:YES];
                    }
                    
                }];
                
            }else if ([response[@"code"] integerValue] == 99){
                
                
                CallRecvViewController *make = [MAIN_SB instantiateViewControllerWithIdentifier:@"callRecvViewController"];
                make.peerId = peerId;
                make.callType = WTSCallTypeSend;
                [APP_DELEGATE().getCurrentVC presentViewController:make animated:YES completion:nil];
            }else{
                
                [self addToast:response[@"msg"]];
            }
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"请求用户建立连接信息失败");
    }];

    
//#endif

    
   
    
}


-(void)addToast:(NSString *)toastStr{
    
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [GET_WINDOW makeToast:toastStr duration:1 position:CSToastPositionCenter style:style];
    
}
@end
