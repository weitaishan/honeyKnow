//
//  BaseSearchViewController.h
//  SmallNail
//
//  Created by 魏太山 on 2017/7/12.
//  Copyright © 2017年 SmallNail. All rights reserved.
//

#import "WTSBaseViewController.h"
#import "SearchTextField.h"

@interface BaseSearchViewController : WTSBaseViewController

@property (nonatomic, strong) SearchTextField * searchText;

@property (nonatomic, strong) UIButton* searchBtn;

@property (nonatomic, copy) NSString* keyWord;


@end
