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

static NSString * const  BASE_URL = @"http://miliao.xiangchaopai.com/";//120.27.134.116

/** 测试-上传接口*/
static NSString * const  URL_UPLOAD_API = @"http://miliao.xiangchaopai.com/file/upload/";


//==========================下载接口=============================
static NSString * const URL_DOWNLOAD_API = @"http://nail-mobile.oss-cn-qingdao.aliyuncs.com/";

//==========================版本控制=============================
static NSString * const URL_VERSION_CONTROL = @"admin/appVersion/getVersion";
//==========================登录注册接口=============================
/** 根据手机号发送验证码*/
static NSString * const URL_SEND_CODE = @"smn/send/code";


/** 校验验证码*/
static NSString * const URL_VERIFY_CODE = @"smn/verify/code";

/** 用户信息更新*/
static NSString * const URL_USER_UPDATE = @"/user/update";


//==========================首页=============================
/** 获取个人关注主播列表*/
static NSString * const URL_HOME_ACTOR_FOCUS_LIST = @"actor/focus/list";

/** 获取推荐的主播列表*/
static NSString * const URL_HOME_ACTOR_RECOMMEND_LIST = @"actor/list";

/** 按照星级获取主播列表*/
static NSString * const URL_HOME_ACTOR_STAR_LIST = @"actor/star/list";

/** 通过昵称查找主播*/
static NSString * const URL_HOME_SEARCH_ACTOR_BY_NICKNAME = @"actor/find";

//==========================发现=============================
/** 关注视屏列表*/
static NSString * const URL_VIDEO_FOCUS_LIST = @"video/focus/list";

/** 最新视屏列表*/
static NSString * const URL_VIDEO_NEW_LIST = @"video/new/list";

/** 热门视屏列表*/
static NSString * const URL_VIDEO_HOT_LIST = @"video/hot/list";

#endif /* Urls_h */
