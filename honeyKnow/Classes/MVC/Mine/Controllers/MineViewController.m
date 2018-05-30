//
//  MineViewController.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/17.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "MineViewController.h"
#import "MineListCell.h"
#import "MinePersonInfoCell.h"
#import "MinePersonInfoModel.h"
#import "MineListModel.h"
#import "EditProfileViewController.h"
#import "MyWalletViewController.h"
#import "PayViewController.h"
#import "AuthenMakeMoneyViewController.h"
#import "WebViewController.h"
#import "EditAuthenProfileViewController.h"
@interface MineViewController ()

@property (nonatomic, strong) MinePersonInfoModel* infoModel;

@property (nonatomic, strong) NSMutableArray<MineListModel *>* listArray;


@end

static NSString * const minePersonInfoCellId = @"minePersonInfoCellId";
static NSString * const mineListCellId = @"mineListCellId";

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationController.navigationBarHidden = YES;

    [self setBaseInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self getUserInfoData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getUserInfoData{
    
    
    WeakSelf;
    [WTSHttpTool requestWihtMethod:RequestMethodTypeGet url:URL_USER_GET params:nil success:^(id response) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        
        if ([response[@"success"] integerValue]){
            
            
            self.infoModel = [MinePersonInfoModel yy_modelWithJSON:response[@"data"]];
            [NSUSERDEFAULTS setObject:@(self.infoModel.isTeacher) forKey:USER_IS_TEACHER];
            [SystemService shareInstance].isTeacher = self.infoModel.isTeacher;
            [self.tableView reloadData];
            
            
        }
        
    } failure:^(NSError *error) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
    
}

- (void)setBaseInfo{
    
    [self addTableViewWithFrame:CGRectMake(0, - NewStatusBarHeight, SCREEN_WIDTH,SCREEN_HEIGHT)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[MineListCell class] forCellReuseIdentifier:mineListCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MinePersonInfoCell class]) bundle:nil] forCellReuseIdentifier:minePersonInfoCellId];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getUserInfoData];
        // 禁用footer
        self.tableView.mj_footer.hidden = YES;
    }];
    
    
}

- (void)pushEditViewController{
    
    EditProfileViewController* vc = [MAIN_SB instantiateViewControllerWithIdentifier:@"editProfileViewController"];
    vc.hidesBottomBarWhenPushed = YES;
    vc.type = 1;
    vc.icoImgUrl = self.infoModel.avator;
    vc.nickName = self.infoModel.nickName;

    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UITableViewDelegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        MinePersonInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:minePersonInfoCellId forIndexPath:indexPath];
        cell.infoModel = self.infoModel;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            
            //手势触发调用
            [self pushEditViewController];

        }];
        [cell.iconImgView addGestureRecognizer:tap];
        
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] init];
        
        [[tap2 rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            
            //手势触发调用
            PayViewController* vc = [[PayViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
        [cell.coinView addGestureRecognizer:tap2];
        
        
   
//
        [[[cell.editBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {

            [self pushEditViewController];

        }];
        return cell;
        
        
    }else{
        
        MineListCell * cell = [tableView dequeueReusableCellWithIdentifier:mineListCellId forIndexPath:indexPath];
        cell.listArray = self.listArray;
        WeakSelf;
        cell.resultBlock = ^(NSInteger index) {
          
            [weakSelf clickItemListWithIndex:index];
        };
        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {

        return 242 + NewStatusBarHeight + 36 + (IS_IPHONE_6P ? 20 : 0);
        
    }else {
        
        return ( self.listArray.count / 3 + 1 ) * 95;

    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10.f;

    }
    return CGFLOAT_MIN;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        
        UIView* view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorFromHexString:@"#eeeeee"];
        
        return view;
    }
    
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return CGFLOAT_MIN;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - 懒加载
-(NSMutableArray<MineListModel *> *)listArray{
    
    if (!_listArray) {
        
        _listArray = @[].mutableCopy;
        
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mineList" ofType:@"json"]];
        
        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        
        for (int i = 0; i < dataArray.count; i++) {
            
            MineListModel* model = [MineListModel yy_modelWithDictionary:dataArray[i]];
            [_listArray addObject:model];
        }
    }
    
    return _listArray;
    
}

/**
 处理button点击事件
 */
- (void)clickItemListWithIndex:(NSInteger)index{
    
    NSString* title = self.listArray[index].title;
    
    if ([title isEqualToString:@"安全退出"]) {
        
        [[SystemService shareInstance] exitLoginWithTitle:@"退出登录" message:@"是否确认退出登录!"];

        
    }else if ([title isEqualToString:@"清除缓存"]){
        
        [self cleanCache];
    }else if ([title isEqualToString:@"钱包"]){
        
        MyWalletViewController* vc = [[MyWalletViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"认证赚钱"]) {
        
        if ([SystemService shareInstance].isTeacher == 1) {
            EditAuthenProfileViewController* vc = [[EditAuthenProfileViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([SystemService shareInstance].isTeacher == 5){
            
            
            
            [[WTSAlertViewTools shareInstance] showAlert:@"认证中" message:@"正在认证中，请耐心等待" cancelTitle:@"确定" titleArray:nil viewController:self confirm:^(NSInteger buttonTag){
        
                
            }];
        }else{
            
            AuthenMakeMoneyViewController* vc = [MAIN_SB instantiateViewControllerWithIdentifier:@"authenMakeMoneyViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
       
        
    }else if ([title isEqualToString:@"在线客服"]){
        
        NSString *callPhone = @"telprompt://0571-28120452";
        
        /// 解决iOS10及其以上系统弹出拨号框延迟的问题
        /// 方案一
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
            /// 10及其以上系统
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            /// 10以下系统
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
        
    }else if ([title isEqualToString:@"帮助中心"]){
        
        [self loadingWebViewWithUrl:URL_H5_HELP];

    }
    
}
/**清除缓存和cookie*/
- (void)cleanCacheAndCookie{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}
/**
 *  清楚缓存
 */
- (void)cleanCache{
    
    [[WTSAlertViewTools shareInstance] showAlert:@"清除缓存" message:@"清除本地聊天记录与缓存图片" cancelTitle:@"返回" titleArray:@[@"确定"] viewController:self confirm:^(NSInteger buttonTag){
        
        if (buttonTag == cancelIndex) {
            
        }else{
            
            [self cleanCacheAndCookie];
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self addToast:@"清除缓存成功"];
                        // 设置文字
                    });
                });
            }];
        }
        
    }];
    
   
    
}



@end
