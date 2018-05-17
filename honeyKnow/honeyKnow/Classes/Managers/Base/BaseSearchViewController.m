//
//  BaseSearchViewController.m
//  SmallNail
//
//  Created by 魏太山 on 2017/7/12.
//  Copyright © 2017年 SmallNail. All rights reserved.
//

#import "BaseSearchViewController.h"

@interface BaseSearchViewController ()

@end

@implementation BaseSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self setNavigationBar];
//
//    [self setBaseInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBaseInfo{
    
//    [self addTableViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarAndNavigationBarHeight)];
//    self.tableView.showsVerticalScrollIndicator = NO;
    
}
//
//-(void)setNavigationBar{
//
//    self.title = nil;
////    self.navigationItem.leftBarButtonItem = nil;
////    self.navigationItem.hidesBackButton = YES;
//
//    //定制searchBar
//    [self setSearchBar];
//
////    [self addRightTitle:@"取消"];
//
//}
//-(void)viewWillDisappear:(BOOL)animated{
//
//    [super viewWillDisappear:animated];
//
//    [self.view endEditing:YES];
//}
//#pragma mark - 定制界面
//-(void)setSearchBar{
//
//
//    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(55, 0 , SCREEN_WIDTH - 55 - 16, 34)];
//    bgView.backgroundColor = kBgColor;
//    bgView.layer.cornerRadius = 17.f;
//    bgView.layer.masksToBounds = YES;
//    [self.navigationItem setTitleView:bgView];
//
//    [bgView addSubview:self.searchText];
//
//    if (@available(iOS 11.0, *)){
//
//        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.height.mas_equalTo(34);
//            make.width.mas_equalTo(SCREEN_WIDTH - 55 - 16);
//
//        }];
//    }
//
////    [bgView addSubview:self.searchBtn];
//
//
//
//    [self.searchText mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.left.bottom.right.equalTo(bgView);
//
//    }];
//
////    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
////
////        make.centerY.equalTo(bgView);
////        make.right.equalTo(bgView).offset(-8);
////        make.size.mas_equalTo(CGSizeMake(24, 24));
////
////    }];
//}
//
////-(UIButton *)searchBtn{
////
////    if (!_searchBtn) {
////
////        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
////        [_searchBtn setBackgroundImage:[UIImage imageNamed:@"assign_sousuo"] forState:UIControlStateNormal];
////
////    }
////
////    return _searchBtn;
////}
//
//-(SearchTextField *)searchText{
//
//    if (!_searchText) {
//
//        _searchText = [[SearchTextField alloc] init];
//
//        _searchText.placeholder = @"职员";
//
//        [_searchText setValue:kNormalTextThreeColor forKeyPath:@"_placeholderLabel.textColor"];
//        [_searchText setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
//
//        _searchText.font = [UIFont systemFontOfSize:14];
//
//        _searchText.textColor = kNormalTextOneColor;
//
//        //调整光标偏上
//        _searchText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//
//        [_searchText setBorderStyle:UITextBorderStyleNone];
//
//        _searchText.backgroundColor = kBgColor;
//
//        _searchText.autocorrectionType = UITextAutocorrectionTypeNo;
//
//        _searchText.returnKeyType = UIReturnKeySearch;
//
//        _searchText.tintColor = KBlackLabelColor;
//
//        _searchText.clearButtonMode = UITextFieldViewModeWhileEditing;
//
//        _searchText.delegate = self;
//
//        [_searchText becomeFirstResponder];
//
////        //设置leftView
////        UIImageView * searchImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
////        searchImgView.image = [UIImage imageNamed:@"home_search_loupe"];
////
////        [_searchText setLeftView:searchImgView];
////
////        //设置leftView的模式
////        [_searchText setLeftViewMode:UITextFieldViewModeAlways];
//
//        [_searchText addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
//    }
//
//    return _searchText;
//}
//-(void)nextStep{
//
//    [self.searchText resignFirstResponder];
//    [self.navigationController popViewControllerAnimated:YES];
//
//}
//- (void)textFieldEditChanged:(UITextField *)textField{
//
//
//}

@end
