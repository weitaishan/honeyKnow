//
//  WTSHttpTool.h
//  DeviseHome
//
//  Created by 魏太山 on 16/12/7.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>

#define ErrorMsg @"网络好像开了点小差哦~"
typedef NS_ENUM(NSInteger, RequestMethodType){
    RequestMethodTypePost = 1,
    RequestMethodTypeGet = 2,
};
typedef void(^SuccessBlock)(id response);
typedef void(^FailBlock)(NSError *error);
typedef void(^UploadFileProgressingBlock)(double progressLenght);
typedef void(^UploadFileTotalLenghtBlock)(double totalLength);
@interface WTSHttpTool : NSObject

/**
 *  发送一个请求
 *
 *  @param methodType   请求方法
 *  @param url          请求路径
 *  @param params       请求参数
 *  @param success      请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure      请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+(void) requestWihtMethod:(RequestMethodType)methodType
                      url:(NSString *)url
                   params:(NSDictionary *)params
                  success:(SuccessBlock)success
                  failure:(FailBlock)failure;

/** 上传一张图片 */
+(void)uploadSingleImageWithType:(UploadType )type
                           image:(UIImage *)image
                     picFileName:(NSString *)picFileName
                         success:(SuccessBlock)success
                         failure:(FailBlock)failure;

/** 上传一张图片，带进度条 */
+(void)uploadImageWidthURL:(NSString *)url
                postParems:(NSDictionary *)postParems
                     image:(UIImage *)image
               picFileName:(NSString *)picFileName
                   success:(SuccessBlock)success
                  progress:(UploadFileProgressingBlock)progress
               totalLenght:(UploadFileTotalLenghtBlock)totalLength
                   failure:(FailBlock)failure;

/** 上传多张图片 */
+(void)uploadImagesWithType:(UploadType )type
                picFileName:(NSString *)picFileName
                     images:(NSArray *)images
                    success:(void (^)(NSArray *imageUrls,NSArray *idsArr))success
                    failure:(FailBlock)failure;

/** 上传文件 */
+(void)uploadFileWithType:(UploadType )type
              picFileName:(NSString *)picFileName
              fileAddress:(NSString *)fileAddress
                  success:(SuccessBlock)success
                  failure:(FailBlock)failure;

