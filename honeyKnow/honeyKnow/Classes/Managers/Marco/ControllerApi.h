//
//  ControllerApi.h
//  JiuLve
//
//  Created by 魏太山 on 16/12/19.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#ifndef ControllerApi_h
#define ControllerApi_h
/** 登录注册StoryBoard */
static NSString  * const  registerSBStr = @"RegisterSB";
static NSString * const enterpriseCenterSBStr = @"EnterpriseCenterSB";

/** 登录界面控制器 */
static NSString  * const  registerViewControllerStr = @"RegisterViewController";
/** 获取验证码界面控制器 */
static NSString  * const  verificationCodeAuthenticationViewControllerStr = @"VerificationCodeAuthenticationViewController";
/** 完成注册界面控制器 */
static NSString  * const  completeRegisterViewControllerStr = @"CompleteRegisterViewController";
/** 忘记密码界面控制器 */
static NSString  * const  forgetPasswordViewControllerStr = @"ForgetPasswordViewController";
//===================个人中心===================
static NSString * const personCenterSBStr = @"PersonCenterSB";
/**
 *  实名认证开始
 */
static NSString * const RealNameAuthenViewControllerStr = @"RealNameAuthenViewController";
#define REALNAME_AUTHEN_CONTROLLER [PERSON_SB instantiateViewControllerWithIdentifier:RealNameAuthenViewControllerStr];

/**
 *  实名认证详情
 */
static NSString * const RealNameAuthenDetailsViewControllerStr = @"RealNameAuthenDetailsViewController";
#define REALNAME_AUTHEN_DETAILS_CONTROLLER [PERSON_SB instantiateViewControllerWithIdentifier:RealNameAuthenDetailsViewControllerStr];
/**
 *  实名认证拍照
 */
static NSString * const RealNamePhotoViewControllerStr = @"RealNamePhotoViewController";
#define REALNAME_PHOTO_CONTROLLER [PERSON_SB instantiateViewControllerWithIdentifier:RealNamePhotoViewControllerStr];
/**
*  实名认证拍照详情
*/
static NSString * const RealNamePhotoDetailsViewControllerStr = @"RealNamePhotoDetailsViewController";
#define REALNAME_PHOTO_DETAILS_CONTROLLER [PERSON_SB instantiateViewControllerWithIdentifier:RealNamePhotoDetailsViewControllerStr];
/**
 *  个人资料
 */
static NSString * const PersonInfomationViewControllerStr = @"PersonInfomationViewController";
#define PERSON_INFOMATION_CONTROLLER [PERSON_SB instantiateViewControllerWithIdentifier:PersonInfomationViewControllerStr];


/**
 *  关联机构
 */
static NSString * const RelevanceOrganizationViewControllerStr = @"RelevanceOrganizationViewController";
#define RELEVANCE_ORGANIZATION_CONTROLLER [PERSON_SB instantiateViewControllerWithIdentifier:RelevanceOrganizationViewControllerStr]
//===================新任务===================
static NSString * const newTaskSBStr = @"NewTaskSB";

//===================   我的工地  ===================
static NSString * const workSiteSBStr = @"WorkSiteSB";



static NSString  * const  MainSBStr = @"Main";


#define Storyboard(sb) [UIStoryboard storyboardWithName:sb bundle:nil]

#define MAIN_SB Storyboard(MainSBStr)




#endif /* ControllerApi_h */
