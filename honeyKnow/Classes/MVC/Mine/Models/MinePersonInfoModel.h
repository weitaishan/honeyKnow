//
//  MinePersonInfoModel.h
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "BaseModel.h"

@interface MinePersonInfoModel : BaseModel

/**
 生日
 */
@property (nonatomic, copy) NSString* birthday;
/**
 签名
 */
@property (nonatomic, copy) NSString* signName;
/**
 性别
 */
@property (nonatomic, copy) NSString*  gender;
/**
 星级
 */
@property (nonatomic, copy) NSString* star;
/**
 昵称
 */
@property (nonatomic, copy) NSString* nickName;
/**
 介绍
 */
@property (nonatomic, copy) NSString* introduce;
/**
 体重
 */
@property (nonatomic, copy) NSString* weight;
/**
 关注数量
 */
@property (nonatomic, assign) NSInteger focusNum;
/**
 身份证
 */
@property (nonatomic, copy) NSString* certNo;
/**
 H币
 */
@property (nonatomic, copy) NSString* balance;
/**
 价格
 */
@property (nonatomic, copy) NSString* price;
/**
 头像
 */
@property (nonatomic, copy) NSString* avator;
/**
 地区
 */
@property (nonatomic, copy) NSString* location;
/**
 用户id
 */
@property (nonatomic, assign) NSInteger Id;

/**
 身高
 */
@property (nonatomic, copy) NSString* tall;

/**
 isteacher=1是主播，=5认证中
 */
@property (nonatomic, assign) NSInteger isTeacher;
/**
状态
 */
@property (nonatomic, assign) NSInteger status;

/*   /spread/get  获取邀请信息，返回5002的时候引导用户进行推广员认证
点击认证，没认证过跳转开始认证，-> 然后编辑资料
 如果认证通过了-> 跳转编辑资料页面，可以编辑信息
 1跳转编辑，5提示认证中
 
 收入明细页面：http://miliao.xiangchaopai.com/income_detail.html?token=
 支出明细页面：http://miliao.xiangchaopai.com/pay_detail.html?token=
 提现明细：http://miliao.xiangchaopai.com/fundout_detail.html?token=
 通话记录：http://miliao.xiangchaopai.com/video_detail.html?token=
 H币明细：http://miliao.xiangchaopai.com/balance_seq.html?token=
 亲密榜:http://miliao.xiangchaopai.com/order_rank.html?actorId=
 帮助页面：http://miliao.xiangchaopai.com/help.html
 
 0571-28120452 在线客服
 
 /video/connect请求视频之前  /video/connect请求视频之前 5001余额不足
 
 /tm/chat/put 聊天接口
 
*/
@end
