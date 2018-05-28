//
//  Urls.h
//  DeviseHome
//
//  Created by 魏太山 on 16/12/6.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#ifndef Urls_h
#define Urls_h

// 定义SDKAppId和AccountType
static  const int kSDKAppID = 1400089200;
static  const int kAccountType = 26272;


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

/** 获取视频信息*/
static NSString * const URL_VIDEO_VIDEO_INFO = @"video/video/url/get";

/** 视频点赞*/
static NSString * const URL_VIDEO_LIKE_UPDATE = @"video/like/update";
//==========================我的=============================
/** 获取用户信息*/
static NSString * const URL_USER_GET = @"user/get";

/** 支付*/
static NSString * const URL_PAYMENT_PAY = @"payment/pay";

/** 获取标签*/
static NSString * const URL_GET_MARKET_LIST = @"marker/list";

/** 更新用户个人标签*/
static NSString * const URL_MARKET_UPDATE = @"user/marker/update";

/** 请求用户建立连接信息 请求视频之前  /video/connect请求视频之前 5001余额不足*/
static NSString * const URL_VIDEO_CONNECT = @"video/connect";


/** 发送消息 判断是否有钱  5001余额不足*/
static NSString * const URL_TM_CHAT_PUT = @"tm/chat/put";

/** 开始通话 计费*/
static NSString * const URL_VIDEO_BILLING_START= @"video/start";

/** 结束通话 计费结束*/
static NSString * const URL_VIDEO_BILLING_STOP = @"video/stop";



//==========================H5页面=============================

/** 收入明细页面：*/
static NSString *  const URL_H5_INCOME_DETAILS = @"http://miliao.xiangchaopai.com/income_detail.html?token=";
/** 支出明细页面：*/
static NSString *  const URL_H5_PAY_DETAILS = @"http://miliao.xiangchaopai.com/pay_detail.html?token=";
/** 提现明细页面*/
static NSString * const URL_H5_FUNDOUT_DETAILS = @"http://miliao.xiangchaopai.com/fundout_detail.html?token=";
/** 通话记录页面*/
static NSString * const URL_H5_VIDEO_DETAILS = @"http://miliao.xiangchaopai.com/video_detail.html?token=";
/** H币明细页：*/
static NSString * const URL_H5_BALANCE_HCOIN = @"http://miliao.xiangchaopai.com/balance_seq.html?token=";
/** 亲密榜页面*/
static NSString * const URL_H5_ORDER_RANK = @"http://miliao.xiangchaopai.com/order_rank.html?actorId=";
/** 帮助页面页面*/
static NSString * const URL_H5_HELP = @"http://miliao.xiangchaopai.com/help.html";




#endif /* Urls_h */
