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
    
    NSString* identifier = [NSUSERDEFAULTS objectForKey:USER_IDENTIFIER];
    
    NSString* userSig = [NSUSERDEFAULTS objectForKey:USER_USERSIG];
    
    
    [[[IMALoginViewController alloc] init] loging];

    
//    //登录sdk
//    [[ILiveLoginManager getInstance] iLiveLogin:identifier sig:userSig succ:^{
//        NSLog(@"iLive 登录成功！");
//    } failed:^(NSString *module, int errId, NSString *errMsg) {
//        NSLog(@"errId:%d, errMsg:%@",errId, errMsg);
//        if (errId == ERR_EXPIRE) {
//            
//            [self exitLoginWithTitle:@"登录信息过期" message:@"请重新登录"];
//        }
//    }];
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
            
            
            LoginSelectViewController* loginVC = [MAIN_SB instantiateViewControllerWithIdentifier:@"loginSelectViewController"];
            
            BaseNavigationViewController* navVC = [[BaseNavigationViewController alloc] initWithRootViewController:loginVC];
            APP_DELEGATE().window.rootViewController = navVC;
            
        }
        
    }];
    
}



@end
