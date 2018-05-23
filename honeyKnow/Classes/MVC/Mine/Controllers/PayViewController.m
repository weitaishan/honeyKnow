//
//  PayViewController.m
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/23.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "PayViewController.h"
#import "PayStyleCell.h"
#import "PayMoneyCell.h"

@interface PayViewController ()

@property (nonatomic, strong) NSMutableArray * listArray;


@end

static NSString * const payStyleCellId = @"payStyleCellId";
static NSString * const payMoneyCellId = @"payMoneyCellId";

@implementation PayViewController

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
//    [self getUserInfoData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getUserInfoData{
    
    
    WeakSelf;
//    [WTSHttpTool requestWihtMethod:RequestMethodTypeGet url:URL_USER_GET params:nil success:^(id response) {
//        
//        [weakSelf.tableView.mj_header endRefreshing];
//        
//        if ([response[@"success"] integerValue]){
//            
//            
//            self.infoModel = [MinePersonInfoModel yy_modelWithJSON:response[@"data"]];
//            
//            [self.tableView reloadData];
//            
//            
//        }
//        
//    } failure:^(NSError *error) {
//        
//        [weakSelf.tableView.mj_header endRefreshing];
//        
//    }];
//    
}

- (void)setBaseInfo{
    
    [self addTableViewWithFrame:CGRectMake(0, - NewStatusBarHeight, SCREEN_WIDTH,SCREEN_HEIGHT)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PayStyleCell class]) bundle:nil] forCellReuseIdentifier:payStyleCellId];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PayMoneyCell class]) bundle:nil] forCellReuseIdentifier:payMoneyCellId];

    
    
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
        
        PayStyleCell * cell = [tableView dequeueReusableCellWithIdentifier:payMoneyCellId forIndexPath:indexPath];
    
        return cell;
        
        
    }else{
        
        PayMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:payMoneyCellId forIndexPath:indexPath];

        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 57;

    
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
//-(NSMutableArray<MineListModel *> *)listArray{
//
//    if (!_listArray) {
//
//        _listArray = @[].mutableCopy;
//
//        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mineList" ofType:@"json"]];
//
//        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
//
//        for (int i = 0; i < dataArray.count; i++) {
//
//            MineListModel* model = [MineListModel yy_modelWithDictionary:dataArray[i]];
//            [_listArray addObject:model];
//        }
//    }
//
//    return _listArray;
//
//}

@end
