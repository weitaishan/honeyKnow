    //
//  WTSHttpTool.m
//  DeviseHome
//
//  Created by 魏太山 on 16/12/7.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#import "WTSHttpTool.h"
#import "PayViewController.h"
#import "BaseTabBarController.h"
#import "BaseNavigationViewController.h"
@implementation WTSHttpTool
static id _instance = nil;
+ (instancetype)sharedInstance {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                {
                    // 位置网络
                    NSLog(@"位置网络");
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                {
                    // 无法联网
                    NSLog(@"无法联网");
                    
                }
                    break;  
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    // 手机自带网络
                    NSLog(@"当前使用的是2G/3G/4G网络");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                    // WIFI
                    NSLog(@"当前在WIFI网络下");
                }
            }
        }];
    });
    return _instance;
}
+ (void)requestWihtMethod:(RequestMethodType)methodType
                      url:(NSString*)url
                   params:(NSDictionary*)params
                  success:(SuccessBlock)success
                  failure:(FailBlock)failure
{
    
    
    AFNetworkReachabilityManager *reachManager = [AFNetworkReachabilityManager sharedManager];
    [reachManager startMonitoring];
    [reachManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                // 位置网络
                NSLog(@"位置网络");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                // 无法联网
                NSLog(@"无法联网");
                CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
                style.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
                [GET_WINDOW makeToast:ErrorMsg duration:3 position:CSToastPositionBottom style:style];
                
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                // 手机自带网络
                NSLog(@"当前使用的是2G/3G/4G网络");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                // WIFI
                NSLog(@"当前在WIFI网络下");
            }
        }
    }];

    
    
    
    NSURL* baseURL = [NSURL URLWithString:[BASE_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //获得请求管理者
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    
//    ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
//    AFJSONResponseSerializer *response = [[AFJSONResponseSerializer alloc] init];response.removesKeysWithNullValues = YES;
//    manager.responseSerializer = response;


    [self addHeaderParams:manager];
    manager.requestSerializer.timeoutInterval = 30.f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",@"text/html",@"charset=utf-8",nil];
    NSString* token = [NSUSERDEFAULTS objectForKey:USER_TOKEN];
    
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            
            if (token.length > 0){
                
                if ([url containsString:@"?"] && [url containsString:@"="]) {

                    url = [NSString stringWithFormat:@"%@&token=%@",url,token];

                }else{
                    
                    url = [NSString stringWithFormat:@"%@?token=%@",url,token];

                }
                
            }
            NSLog(@"params = %@,url = %@",params,url);

            //GET请求
            [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideHUDForView:GET_WINDOW animated:YES];

                if (success) {
                    NSLog(@"responseObject = %@",responseObject);

                    success(responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [MBProgressHUD hideHUDForView:GET_WINDOW animated:YES];
                
                CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
                style.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
                [GET_WINDOW makeToast:ErrorMsg duration:1 position:CSToastPositionBottom style:style];
                NSLog(@"error = %@",error);
                if (error.code == NSURLErrorTimedOut) {
                    
                    NSLog(@"请求超时");
                }
                if (failure) {
                    
                    failure(error);
                    
                }

            }];
            
        }
            break;
            
        case RequestMethodTypePost:
        {
            if (token.length > 0){
                
                [params setValue:[NSUSERDEFAULTS objectForKey:USER_TOKEN] forKey:@"token"];
                
            }
            //POST请求
            NSLog(@"params = %@,url = %@",params,url);
            [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideHUDForView:GET_WINDOW animated:YES];
                if (success) {
                    
                    NSLog(@"responseObject = %@",responseObject);
//                    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
//                    style.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
//                    [GET_WINDOW makeToast:responseObject[@"msg"] duration:1 position:CSToastPositionBottom style:style];
//                   
                    success(responseObject);
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [MBProgressHUD hideHUDForView:GET_WINDOW animated:YES];

                CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
                style.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
                [GET_WINDOW makeToast:ErrorMsg duration:1 position:CSToastPositionBottom style:style];
                NSLog(@"error = %@",error);
                if (error.code == NSURLErrorTimedOut) {
                    
                    NSLog(@"请求超时");
                }
                if (failure) {
                    
                    failure(error);
                    
                }
            }];
       
            
        }
            break;
            
        
        default:
            break;
    }
}


//添加请求头参数
+(void)addHeaderParams:(AFHTTPSessionManager*)manager {
    if (!manager) {
        return;
    }
//    struct utsname systemInfo;
//    uname(&systemInfo);
//    NSString* token = [NSUSERDEFAULTS objectForKey:@"token"];
//    NSLog(@"token = %@",token);
//    [manager.requestSerializer setValue:token ? token : @"" forHTTPHeaderField:@"token"];
//    [manager.requestSerializer setValue:@"app" forHTTPHeaderField:@"type"];
//    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"appType"];

}


/** 上传一张图片 */
+(void)uploadSingleImageWithType:(UploadType)type
                           image:(UIImage *)image
                     picFileName:(NSString *)picFileName
                         success:(SuccessBlock)success
                         failure:(FailBlock)failure{
    
    
    [self uploadImageWithWithType:[NSString stringWithFormat:@"%lu",type] image:image picFileName:picFileName progress:nil totalLenght:nil success:^(id response) {
                                
        success(response);
                                
        
    } failure:^(NSError *error) {
                                
                                
        failure(error);
                                
    }];
    
    
}

/** 上传文件 */
+(void)uploadFileWithType:(UploadType )type
              picFileName:(NSString *)picFileName
              fileAddress:(NSString *)fileAddress
                  success:(SuccessBlock)success
                  failure:(FailBlock)failure{
    
    NSDictionary *params = @{@"type" : [NSString stringWithFormat:@"%lu",type]};
    NSString *url = [NSString stringWithFormat:@"%@",URL_UPLOAD_API];//放上传图片的网址
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//初始化请求对象
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置服务器允许的请求格式内容
    [self addHeaderParams:manager];
    manager.requestSerializer.timeoutInterval = 30.f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",@"text/html",@"charset=utf-8",nil];
    
    
    //上传图片/文字，只能同POST
    [manager POST:url parameters:params constructingBodyWithBlock:^(id  _Nonnull formData) {
        //对于图片进行压缩
        NSData *data = [NSData dataWithContentsOfFile:fileAddress];
        
        [formData appendPartWithFileData:data name:@"fileData" fileName:picFileName mimeType:@"application/octet-stream"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        NSLog(@"error = %@",error);
    }];

    
    
}

+(void)uploadImageWithWithType:(NSString *)type
                           image:(UIImage *)image
                     picFileName:(NSString *)picFileName
                        progress:(UploadFileProgressingBlock)progress
                     totalLenght:(UploadFileTotalLenghtBlock)totalLength
                         success:(SuccessBlock)success
                         failure:(FailBlock)failure{
    
    if (image == nil) {
        NSLog(@"上传内容没有包含图片");
        
        return;
    }
    if (![image isKindOfClass:[UIImage class]]) {
        
        NSLog(@"image不是UIImage对象");
        return;
    }
    
//    NSDictionary *params = @{@"type" : type};
    NSString *url = [NSString stringWithFormat:@"%@",URL_UPLOAD_API];//放上传图片的网址
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//初始化请求对象
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置服务器允许的请求格式内容
    [self addHeaderParams:manager];
    manager.requestSerializer.timeoutInterval = 30.f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",@"text/html",@"charset=utf-8",nil];

    
    //上传图片/文字，只能同POST
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id  _Nonnull formData) {
        //对于图片进行压缩
        
        CGFloat scale = 0.5f;
        if (image.size.width > 800 || image.size.height > 800) {

            scale = 0.3f;
            
        }else if (image.size.width > 2000 || image.size.height > 2000) {
            
            scale = 0.4f;
            
        }else if (image.size.width > 4000 || image.size.height > 4000) {
            
            scale = 0.2f;
            
        }
        NSData *data = UIImageJPEGRepresentation(image, scale);
        //第一个代表文件转换后data数据，第二个代表图片的名字，第三个代表图片放入文件夹的名字，第四个代表文件的类型
        [formData appendPartWithFileData:data name:@"file" fileName:picFileName mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress = %@",uploadProgress);

        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        NSLog(@"error = %@",error);
    }];
    
}

/** 上传多张图片 */
+(void)uploadImagesWithType:(UploadType )type
                picFileName:(NSString *)picFileName
                     images:(NSArray *)images
                    success:(void (^)(NSString *))success
                    failure:(FailBlock)failure{
    
    if (images.count == 0) {
        NSLog(@"上传内容没有包含图片");
        [MBProgressHUD hideHUDForView:GET_WINDOW animated:YES];

        return;
    }
    for (int i = 0; i < images.count; i++) {
        if (![images[i] isKindOfClass:[UIImage class]]) {
            NSLog(@"images中第%d个元素不是UIImage对象",i+1);
            [MBProgressHUD hideHUDForView:GET_WINDOW animated:YES];

            return;
        }
    }
    
    
//    NSDictionary *params = @{@"type" : [NSString stringWithFormat:@"%ld",type]};
    NSString *url = [NSString stringWithFormat:@"%@",URL_UPLOAD_API];//放上传图片的网址
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//初始化请求对象
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置服务器允许的请求格式内容
    [self addHeaderParams:manager];
    manager.requestSerializer.timeoutInterval = 60.f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",@"text/html",@"charset=utf-8",nil];
    
    
    //上传图片/文字，只能同POST
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id  _Nonnull formData) {
        
        NSInteger i = 1;
        for (UIImage* image in images) {
            
            NSString* fileName = [NSString stringWithFormat:@"%@%ld.png",picFileName,i];
            //对于图片进行压缩
            CGFloat scale = 0.5f;
            if (image.size.width > 1000 || image.size.height > 1000) {
                
                scale = 0.8f;
                
            }else if (image.size.width > 2000 || image.size.height > 2000) {
                
                scale = 0.4f;
                
            }else if (image.size.width > 4000 || image.size.height > 4000) {
                
                scale = 0.2f;
                
            }
            NSData *data = UIImageJPEGRepresentation(image, scale);
            //第一个代表文件转换后data数据，第二个代表图片的名字，第三个代表图片放入文件夹的名字，第四个代表文件的类型
            [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpg"];
            i ++;
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"uploadProgress = %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * data = responseDict[@"data"];

        success(responseDict[@"data"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        NSLog(@"error = %@",error);
    }];
    
}

+ (void)startVideoBillingWithRoomId:(NSString *)roomId{
    
    [WTSHttpTool requestWihtMethod:RequestMethodTypePost url:URL_VIDEO_BILLING_START params:@{@"roomId" : roomId}.mutableCopy success:^(id response) {
        
        
        if ([response[@"success"] integerValue]){
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}

+ (void)stopVideoBillingWithRoomId:(NSString *)roomId{
    
    [WTSHttpTool requestWihtMethod:RequestMethodTypePost url:URL_VIDEO_BILLING_STOP params:@{@"roomId" : roomId}.mutableCopy success:^(id response) {
        
        
        if ([response[@"success"] integerValue]){
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}

/**
 发消息时 判断是否有钱
 
 @param completion
 */
+ (void)startSendMessageJudegeIsMoneyWithCompletion:(void(^)(BOOL isSend))completion{
    
    if ([SystemService shareInstance].isTeacher == 1) {
        
        return;
    }
    
    [WTSHttpTool requestWihtMethod:RequestMethodTypePost url:URL_TM_CHAT_PUT params:@{}.mutableCopy success:^(id response) {
        
        
        if ([response[@"success"] integerValue]){
            
            if ([response[@"code"] integerValue] == 5001){
                
                NSLog(@"余额不足");
//                [[WTSAlertViewTools shareInstance] showAlert:@"余额不足" message:@"您的账号余额不足以发送消息，无法发送消息！\n是否立即充值？" cancelTitle:@"取消" titleArray:@[@"立即充值"] viewController:APP_DELEGATE().getCurrentVC confirm:^(NSInteger buttonTag){
//                    
//                    if (buttonTag == cancelIndex) {
//                        
//                        
//                    }else{
//                        
//                        PayViewController* vc = [[PayViewController alloc] init];
//                        vc.hidesBottomBarWhenPushed = YES;
//                        if ([APP_DELEGATE().getCurrentVC isKindOfClass:[BaseTabBarController class]]) {
//                            
//                            
//                            BaseTabBarController* tab = (BaseTabBarController *)APP_DELEGATE().getCurrentVC;
//                            
//                            
//                            BaseNavigationViewController *curNav = (BaseNavigationViewController *)[[tab viewControllers] objectAtIndex:tab.selectedIndex];
//
//                            [curNav pushViewController:vc animated:YES];
//
//                            
//                        }else{
//                            
//                            [APP_DELEGATE().getCurrentVC.navigationController pushViewController:vc animated:YES];
//
//                        }
//                    }
//                    
//                }];
                
                completion(YES);
                
            }else if ([response[@"code"] integerValue] == 99){
                
                completion(YES);

                
            }else{
                
                completion(NO);

            }
        }else{
            
            completion(NO);

        }
        
        
        
    } failure:^(NSError *error) {
        
        completion(NO);

    }];
    
}
@end
