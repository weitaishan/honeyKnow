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
#import "MinePersonInfoModel.h"

@interface PayViewController ()
@property (nonatomic, strong) MinePersonInfoModel* infoModel;

@property (nonatomic, strong) NSMutableArray * listArray;

//是否是微信支付
@property (nonatomic, assign) BOOL isWeixin;

@end

static NSString * const payStyleCellId = @"payStyleCellId";
static NSString * const payMoneyCellId = @"payMoneyCellId";

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationController.navigationBarHidden = NO;
    [self setBaseInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self getUserInfoData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getUserInfoData{
    
    
    [WTSHttpTool requestWihtMethod:RequestMethodTypeGet url:URL_USER_GET params:nil success:^(id response) {
        
        
        if ([response[@"success"] integerValue]){
            
            
            self.infoModel = [MinePersonInfoModel yy_modelWithJSON:response[@"data"]];
                        
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

- (void)setBaseInfo{
    
    self.navigationItem.title = @"充值";
    [self addTableViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - NewStatusBarHeight)];
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
    
    if (section == 1) {
        
        return self.listArray.count;
    }
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        PayStyleCell * cell = [tableView dequeueReusableCellWithIdentifier:payStyleCellId forIndexPath:indexPath];
        cell.lbHCoin.text = self.infoModel.balance.length ? self.infoModel.balance : @"0";
        _isWeixin = cell.wxBtn.isSelected;
        cell.aliBtn.selected = !cell.wxBtn.selected;

        
        [[[cell.wxBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            cell.wxBtn.selected = !cell.wxBtn.selected;
            cell.aliBtn.selected = !cell.wxBtn.selected;
            _isWeixin = cell.wxBtn.isSelected;

        }];
        
        [[[cell.aliBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            cell.aliBtn.selected = !cell.aliBtn.selected;
            cell.wxBtn.selected = !cell.aliBtn.selected;
            _isWeixin = cell.wxBtn.isSelected;

        }];
        
        
        return cell;
        
        
    }else{
        
        PayMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:payMoneyCellId forIndexPath:indexPath];
        cell.lbMoney.text = self.listArray[indexPath.row];
        cell.lbConfirmMoney.text = self.listArray[indexPath.row];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            
            [self payActionWithCell:cell];
            
        }];
        [cell.payView addGestureRecognizer:tap];
        
        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {

        return 257;
    }
    return 67;

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    

    return CGFLOAT_MIN;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return CGFLOAT_MIN;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - 懒加载
-(NSMutableArray *)listArray{

    if (!_listArray) {

        _listArray = @[@"100",@"200",@"500",@"1000",@"2000"].mutableCopy;

    }

    return _listArray;

}

- (void)payActionWithCell:(PayMoneyCell *)cell{
    
    NSLog(@"是%@支付",_isWeixin ? @"微信" : @"支付宝");

    WeakSelf;
    [WTSHttpTool requestWihtMethod:RequestMethodTypePost url:URL_PAYMENT_PAY params:@{@"channel" : _isWeixin ? @"02" : @"01",
                    @"amount" : cell.lbMoney.text}.mutableCopy success:^(id response) {
        
        
        if ([response[@"success"] integerValue]){
            
            
            if (_isWeixin) {

                [[MJPayApi sharedApi]wxPayWithPayParam:response[@"data"] success:^(PayCode code)
                 {

                 } failure:^(PayCode code) {


                 }];

            }else{

                [[MJPayApi sharedApi]aliPayWithPayParam:response[@"data"] success:^(PayCode code)
                 {
                 } failure:^(PayCode code) {
                 }];

            }
            
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"支付失败");
    }];
    
    
   
}
@end
