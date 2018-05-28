//
//Created by ESJsonFormatForMac on 18/05/17.
//

#import "BaseModel.h"

@class HomeList;
@interface HomeListModel : NSObject

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, strong) NSArray<HomeList *> *list;

@property (nonatomic, strong) NSArray<HomeList *> *data;


@end
@interface HomeList : BaseModel

@property (nonatomic, assign) NSInteger Id;
/** 标签*/
@property (nonatomic, copy) NSString *signName;
/**身高*/
@property (nonatomic, copy) NSString *tall;
/** 是否在线  1是在线  0 是离线  2是繁忙  3勿扰*/
@property (nonatomic, copy) NSString *status;
/** 星级*/
@property (nonatomic, copy) NSString *star;
/**体重*/
@property (nonatomic, copy) NSString *weight;
/**价格*/
@property (nonatomic, copy) NSString *price;
/**地区*/
@property (nonatomic, copy) NSString *location;
/**生日*/
@property (nonatomic, copy) NSString *birthday;
/**昵称*/
@property (nonatomic, copy) NSString *nickName;
/**封面图*/
@property (nonatomic, copy) NSString *avator;
/**性别*/
@property (nonatomic, copy) NSString *gender;
/**自我介绍*/
@property (nonatomic, copy) NSString *introduce;

@end

