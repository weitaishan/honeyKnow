//
//  Colors.h
//  DeviseHome
//
//  Created by 魏太山 on 16/12/6.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#ifndef Colors_h
#define Colors_h

// ===================== 颜色相关 =====================
/** 颜色*/
#define Color(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define HexColor(hex)  [UIColor colorFromHexString:[NSString stringWithFormat:@"#%@"],hex]
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/** tabBar填充颜色*/
#define TabBarTintColor [UIColor colorFromHexString:@"#f7f7f7"]

/** 主要颜色颜色*/
#define kMainColor [UIColor colorFromHexString:@"#ED625E"]
#define kOrangeColor [UIColor colorFromHexString:@"#e9994c"]
#define kPinkColor [UIColor colorFromHexString:@"#fa878c"]

/** 背景颜色*/
#define kBgColor [UIColor colorFromHexString:@"#ffffff"]

/** 背景颜色*/
#define kNewBgColor [UIColor colorFromHexString:@"#FFFFFF"]


/** 背景颜色*/
#define kBtnBgColor [UIColor colorFromHexString:@"#F2F4F7"]
/** 分割线颜色*/
#define kLineColor [UIColor colorFromHexString:@"#dadada"]

/** 底部分割线颜色*/
#define kBottomLineColor [UIColor colorFromHexString:@"#d8d8d8"]

/** 常用颜色*/
#define kNormalTextOneColor [UIColor colorFromHexString:@"#272727"]
#define kNormalTextTwoColor [UIColor colorFromHexString:@"#7d7d7d"]
#define kNormalTextThreeColor [UIColor colorFromHexString:@"#b6b6b6"]
#define kWrongTextColor [UIColor colorFromHexString:@"#ff5555"]



#define kTextNorColor [UIColor colorFromHexString:@"#00d4b6"]
#define kTextBlueColor [UIColor colorFromHexString:@"#44befe"]
#define KBorderColor [UIColor colorFromHexString:@"#a3adc1"]

#define KRegisterLabelColor [UIColor colorFromHexString:@"#999999"]
#define KBlackLabelColor [UIColor colorFromHexString:@"#333333"]
#define kBlackColor [UIColor colorFromHexString:@"#323232"]
#define kWhiteColor [UIColor colorFromHexString:@"#ffffff"]
#define kBtnWhiteColor [UIColor colorFromHexString:@"#ffc8c8"]
#define kDarkGrayColor [UIColor colorFromHexString:@"#666666"]
#define kGrayColor [UIColor colorFromHexString:@"#969696"]
#define kLightGrayColor [UIColor colorFromHexString:@"#e8e8e8"]
#define kBlueColor [UIColor colorFromHexString:@"#30BFB7"]
#define kGreenColor [UIColor colorFromHexString:@"#73cba9"]
#define kRandomColor [UIColor colorWithRed:arc4random() % 256 / 255.0f green:arc4random() % 256 / 255.0f blue:arc4random() % 256 / 255.0f alpha:1]

#define kTextPlaceholderColor [UIColor colorFromHexString:@"#b6b6b6"]
#define kTextColor [UIColor colorFromHexString:@"#b6b6b6"]


#define KAnnouncementColor [UIColor colorFromHexString:@"#377DEC"]

#endif /* Colors_h */
