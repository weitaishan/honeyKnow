//
//  EnumApi.h
//  DeviseHome
//
//  Created by 魏太山 on 16/12/9.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#ifndef EnumApi_h
#define EnumApi_h

/**
 *  账户类型
 */
typedef NS_ENUM(NSUInteger, UserType) {
    /**
     *  员工
     */
    UserTypeStaff = 0,
    /**
     *  项目经理
     */
    UserTypeProjectManager,
    /**
     *  工人
     */
    UserTypeWorker,
    /**
     *  供应商
     */
    UserTypeSuppliers
};

/**
 *  定义状态值
 */
typedef NS_ENUM(NSUInteger, Status) {
    /**
     *  失败
     */
    StatusFailure = 0,
    /**
     *  成功
     */
    StatusSuccess
};

/**
 *  性别
 */
typedef NS_ENUM(NSUInteger, Sex) {
    /**
     *  男
     */
    SexMale = 1,
    /**
     *  女
     */
    SexFemale
};
/**
 *  关联机构
 */
typedef NS_ENUM(NSUInteger, RelationStatus) {
    /**
     *  未关联
     */
    RelationStatusNot = 0,
    /**
     *  已关联
     */
    RelationStatusAlready
};
/**
 *  身份证正反面
 */
typedef NS_ENUM(NSUInteger, IdCardStatus) {
    /**
     *  身份证正面
     */
    IdCardStatusFront = 302,
    /**
     *  身份证反面
     */
    IdCardStatusBack
};
/**
 *  用户状态
 */
typedef NS_ENUM(NSUInteger, UserStatus) {
    /**
     *  待认证,用户注册成功但未提交实名认证
     */
    UserStatusWaitAuthentication = 1,
    /**
     *  认证未通过,后台管理实名认证审核未通过
     */
    UserStatusAuthenticationFail,
    /**
     *  已认证,后台管理通过实名认证审核
     */
    UserStatusAuthenticationSuccess,
    /**
     *  已关闭,后台管理操作“关闭”用户
     */
    UserStatusAuthenticationClose,
    /**
     *  认证中,用户提交实名认证后，但后台未操作审核
     */
    UserStatusAuthenticationing
};
/**
 *  验证码业务逻辑判断
 */
typedef NS_ENUM(NSUInteger, VcfCode) {
    
    VcfCodeRegister = 0,
    VcfCodeOther,
    VcfCodeRegisterTwo,
    VcfCodeChangePassword,
    VcfCodeChangePasswordTwo,
    VcfCodeLogin
};


/**
 *  待办计划状态
 */
typedef NS_ENUM(NSUInteger, GtasksPlanStatus) {
    
    GtasksPlanStatusGtasks = 0,
    GtasksPlanStatusComplete,
    GtasksPlanStatusTimeOut
    
};

/**
 *  上传文件
 */
typedef NS_ENUM(NSUInteger, UploadType) {
    
    UploadTypeAvatar = 0,
    UploadTypeAudio,
    UploadTypeVideo,
    UploadTypeFile,
    UploadTypeImg
};

/**
 *  客户问题类型
 */
typedef NS_ENUM(NSUInteger, CustomerQuestionType) {
    
    /**
     *  投诉
     */
    CustomerQuestionTypeComplaints = 0,
    /**
     *  问题
     */
    CustomerQuestionTypeQuestion,
    /**
     *  反馈
     */
    CustomerQuestionTypeFeedback,
    /**
     *  售后
     */
    CustomerQuestionTypeAftermarket,
    
    /**
     *  是否有新公告
     */
    CustomerQuestionTypeAnnouncement
};

/**
 *  客户处理问题状态
 */
typedef NS_ENUM(NSUInteger, CustomerQuestionStatus) {
    
    CustomerQuestionStatusUnprocessed = 0,
    CustomerQuestionStatusProcessed
    
};

/**
 *  方向
 */
typedef NS_OPTIONS(NSUInteger, Direction) {
    /**
     *  无
     */
    DirectionNone   = 1 << 0,
    /**
     *  上
     */
    DirectionTop    = 1 << 1,
    /**
     *  左
     */
    DirectionLeft   = 1 << 2,
    /**
     *  下
     */
    DirectionBottom = 1 << 3,
    /**
     *  右
     */
    DirectionRight  = 1 << 4
};

/**
 *  添加客户类型
 */
typedef NS_ENUM(NSUInteger, AddCustomerType) {
    
    AddCustomerTypeNone = 0,
    /**
     *  职业类型
     */
    AddCustomerTypeJobType,
    /**
     *  所在方位
     */
    AddCustomerTypeLocation,
    /**
     *  楼盘小区
     */
    AddCustomerTypeSubareaFillin,
    /**
     *  客户分类
     */
    AddCustomerTypeCustomerClassify,
    /**
     *  客户来源
     */
    AddCustomerTypeCustomerSource,
    /**
     *  优先级别
     */
    AddCustomerTypePriority,
    /**
     *  装修类型
     */
    AddCustomerTypeFitmentType,
    /**
     *  行业了解度
     */
    AddCustomerTypeIndustryUnderstanding,
    /**
     *  客户关注
     */
    AddCustomerTypeConcern,
    /**
     *  房屋类型
     */
    AddCustomerTypeHouseType,
    /**
     *  户型
     */
    AddCustomerTypeHomeType,
    /**
     *  居住状况
     */
    AddCustomerTypeResidentialSituation,
    /**
     *  装修风格
     */
    AddCustomerTypeDecorationStyle
};


/**
 *  报价类型
 */
typedef NS_ENUM(NSUInteger, QuotationType) {
    /**
     *  报价分类
     */
    QuotationTypeMain = 1,
    /**
     *  报价建材分类
     */
    QuotationTypeBuilding,
    /**
     *  报价详情
     */
    QuotationTypeDetails
    
};

/**
 *  工作文件类型
 */
typedef NS_ENUM(NSUInteger, WorkFileType) {
    /**
     *  图片上传
     */
    WorkFileTypeUploadImg = 1,
    /**
     *  图片审核
     */
    WorkFileTypeAuditImg,
    /**
     *  文档上传
     */
    WorkFileTypeUploadDocument,
    /**
     *  文档审核
     */
    WorkFileTypeAuditDocument
    
};

/**
 *  工作任务类型
 */
typedef NS_ENUM(NSUInteger, WorkTaskType) {
    /**
     *  其他
     */
    WorkTaskTypeOther = 0,
    /**
     *  图片上传
     */
    WorkTaskTypeImgUpload,
    /**
     *  文档上传
     */
    WorkTaskTypeFileUpload,
    /**
     *  客户服务计划
     */
    WorkTaskTypeCustomerServicePlan
    
};

/**
 *  客户详情日志列表类型
 */
typedef NS_ENUM(NSUInteger, CustomerDetailsLogType) {

    /**
     *  系统日志
     */
    CustomerDetailsLogTypeSystem = 0,
    /**
     *  业务日志
     */
    CustomerDetailsLogTypeTransaction
    
};

/**
 *  材料下单-收货
 */
typedef NS_ENUM(NSUInteger, MaterialOrderReceivingType) {
   
    /**
     *  材料下单-未收货
     */
    MaterialOrderReceivingDidnotType = 0,
    /**
     *  材料下单-已收货
     */
    MaterialOrderReceivingAlreadyType = 1
    
};

/**
 *  跟单计划
 */
typedef NS_ENUM(NSUInteger, MerchandisingPlanType) {
    /**
     *  跟单计划-未完成
     */
    MerchandisingPlaDidnotType = 0,
    /**
     *  跟单计划-已完成
     */
    MerchandisingPlanAlreadyType
    
};

/**
 *  日志列表类型
 */
typedef NS_ENUM(NSUInteger, LogListType) {
    
    /**
     *  所有日志
     */
    LogListTypeAll = 0,
    /**
     *  系统日志
     */
    LogListTypeSystem,
    /**
     *  其他日志
     */
    LogListTypeOther
    
};

/**
 *  客户详情处理任务
 */
typedef NS_ENUM(NSUInteger, CustomerHandleTaskType) {
    
    /**
     *  重做
     */
    CustomerHandleTaskTypeReset = 0,
    /**
     *  完成
     */
    CustomerHandleTaskTypeComplete,
    /**
     *  不做
     */
    CustomerHandleTaskTypeDonot
    
};

/**
 *  文件/图片上传类型-新
 */
typedef NS_ENUM(NSUInteger, NewUploadFileType) {
    
    NewUploadFielTypeImage = 0,
    NewUploadFileTypeDocument
};

/**
 *  新报价类型
 */
typedef NS_ENUM(NSUInteger, NewQuotationType) {
    
    /**
     *  预算报价
     */
    NewQuotationTypeBudget = 0,
    /**
     *  材料确认
     */
    NewQuotationTypeMaterialConfirmation
};

/**
 *  预算子项类型
 */
typedef NS_ENUM(NSUInteger, BudgetSubType) {
    
    /**
     *  所有
     */
    BudgetSubTypeAll = 0,
    /**
     *  只查材料
     */
    BudgetSubTypeMaterial
};

/**
 *  待办事项排序
 */
typedef NS_ENUM(NSUInteger, WorkAgendaSort) {
    
    /**
     *  按实际排序
     */
    WorkAgendaSortTime = 0,
    /**
     *  按客户排序
     */
    WorkAgendaSortCustomer
};

/**
 *  选择框类型
 */
typedef NS_ENUM(NSUInteger, SelectBoxType) {
    
    /**
     *  添加客户
     */
    SelectBoxTypeAddCustomer = 0,
    /**
     *  修改客户
     */
    SelectBoxTypeModifyCustomer,
    
    /**
     *  日志
     */
    SelectBoxTypeLog,
    
    /**
     *  工程进度计划
     */
    SelectBoxTypeProSchPlan
};


/**
 *  工程进度计划类型
 */
typedef NS_ENUM(NSUInteger, ProSchPlanType) {
    
    /**
     *  其他，所有
     */
    ProSchPlanTypeAll = 0,
    /**
     *  重排
     */
    ProSchPlanTypeReset,
    
    /**
     *  初始化
     */
    ProSchPlanTypeInit,
};


/**
 *  客户收付款提成类型
 */
typedef NS_ENUM(NSUInteger, CustomerPublicType) {
    
    /**
     *  工程付款
     */
    CustomerPublicTypePaymentBIll = 1,
    
    /**
     *  客户收款
     */
    CustomerPublicTypeReceivablesBill ,
    
    /**
     *  项目提成
     */
    CustomerPublicTypeCommissionBIll,
};


/**
 *  推送消息跳转页面
 */
typedef NS_ENUM(NSUInteger, PushMessageType) {
    
    /**
     *  客户详情
     */
    PushMessageTypeCustomer = 1,
    
    /**
     *  客户服务计划
     */
    PushMessageTypePlan = 6,
    
    /**
     *  工程进度
     */
    PushMessageTypeProgress = 7,
    
    /**
     *  工程进度
     */
    PushMessageTypeProgress2,
};


#endif /* EnumApi_h */
