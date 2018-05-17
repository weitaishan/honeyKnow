//
//  Urls.h
//  DeviseHome
//
//  Created by 魏太山 on 16/12/6.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#ifndef Urls_h
#define Urls_h
/** 网络请求*/

static NSString * const  BASE_URL = @"http://erp.xdingerp.com:7998/";//120.27.134.116

/** 测试-上传接口*/
static NSString * const  URL_UPLOAD_API = @"http://erp.xdingerp.com:7998/upload/fileUpload/";


static NSString * const  URL_FILE = @"uploadFile";
static NSString * const  URL_IMAGE = @"uploadImg";

//==========================下载接口=============================
static NSString * const URL_DOWNLOAD_API = @"http://nail-mobile.oss-cn-qingdao.aliyuncs.com/";

//==========================版本控制=============================
static NSString * const URL_VERSION_CONTROL = @"admin/appVersion/getVersion";
//==========================登录注册接口=============================
/** 根据手机号发送验证码*/
static NSString * const URL_SEND_CODE_BY_MOBILE = @"user/userApp/sendCodeByMobile";
/** 验证手机身份证*/
static NSString * const URL_VER_USER = @"user/userApp/verUser";
/** 用户注册设置密码*/
static NSString * const URL_REGISTER = @"user/userApp/register";
/** 登录*/
static NSString * const URL_LOGIN = @"user/userApp/login";
/** 修改密码接口*/
static NSString * const URL_MODIFY_PASSWORD = @"user/userApp/modifyPassword";




#endif /* Urls_h */
