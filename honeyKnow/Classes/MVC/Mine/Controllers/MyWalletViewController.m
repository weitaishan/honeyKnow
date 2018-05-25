//
//  MyWalletViewController.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/20.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "MyWalletViewController.h"
#import "MessageListModel.h"
#import "MyWalletCell.h"
#import "WithdrawAuthenViewController.h"

@interface MyWalletViewController ()
@property (nonatomic, strong) NSMutableArray<NSArray *>* listArray;

@end

static NSString * const myWalletCellId = @"myWalletCellId";

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationController.navigationBarHidden = NO;
    [self setBaseInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBaseInfo{
    
    self.navigationItem.title = @"我的钱包";
    [self addTableViewWithFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT - StatusBarAndNavigationBarHeight)];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 4, 0, 0);
    self.tableView.backgroundColor = [UIColor colorFromHexString:@"#eeeeee"];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyWalletCell class]) bundle:nil] forCellReuseIdentifier:myWalletCellId];
}


#pragma mark - UITableViewDelegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.listArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArray[section].count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MyWalletCell * cell = [tableView dequeueReusableCellWithIdentifier:myWalletCellId forIndexPath:indexPath];
    MessageListModel* model = self.listArray[indexPath.section][indexPath.row];
    cell.model = model;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 49;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* view = [[UIView alloc] init];
    
    if (section == 0) {
        
        view.backgroundColor = [UIColor colorFromHexString:@"#6874da"];

        UILabel* lbTitle = [[UILabel alloc] init];
        lbTitle.text = @"资产总额:";
        lbTitle.font = [UIFont systemFontOfSize:15];
        lbTitle.textColor = [UIColor colorFromHexString:@"#b4baed"];
        [view addSubview:lbTitle];
        
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(view).offset(10);
            make.top.equalTo(view).offset(22);
        }];
        
        
        UILabel* lbCoin = [[UILabel alloc] init];
        NSString* string = [NSString stringWithFormat:@"%dH币",0];
        lbCoin.text = string;
        lbCoin.font = [UIFont systemFontOfSize:15];
        lbCoin.textColor = [UIColor whiteColor];
        [view addSubview:lbCoin];
        
        [lbCoin mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(view);
            make.bottom.equalTo(view).offset(-40);
        }];
        
        
        // 创建一个富文本
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
        
        
        [attri addAttributes:@{NSForegroundColorAttributeName : kWhiteColor,
                               NSFontAttributeName : Font((45))} range:NSMakeRange(0, string.length)];
            

        [attri addAttribute:NSFontAttributeName value:Font(15) range:NSMakeRange(string.length - 2, 2)];

        
        lbCoin.attributedText = attri;

        return view;
    }
    
   
    view.backgroundColor = [UIColor colorFromHexString:@"#eeeeee"];

    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return CGFLOAT_MIN;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 170;
    }
    
    return 15;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            
            
            switch (indexPath.row) {
                case 0:
                {
                    
                    NSLog(@"充值");
                    
                }
                    break;
                case 1:
                {
                    NSLog(@"提现");
                    WithdrawAuthenViewController* vc = [MAIN_SB instantiateViewControllerWithIdentifier:@"withdrawAuthenViewController"];
                    vc.hidesBottomBarWhenPushed = YES;
                    
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                default:
                    break;
            }
        }
            
            break;
            
        case 1:{
            
            
            switch (indexPath.row) {
                case 0:
                {
                    
                    NSLog(@"收入明细");
                    
                }
                    break;
                case 1:
                {
                    NSLog(@"支出明细");
                    
                    
                }
                    break;
                    
                case 2:
                {
                    
                    NSLog(@"提现明细");
                }
                    break;
                default:
                    break;
            }
        }
            
            break;
        default:
            break;
    }
}

#pragma mark - 懒加载
-(NSMutableArray<NSArray *> *)listArray{
    
    if (!_listArray) {
        
        _listArray = @[].mutableCopy;
        NSArray<NSArray *>* titleArr = @[@[@"充值",@"提现"],
                              @[@"收入明细",@"支出明细",@"提现明细"]];
        
        NSArray<NSArray *>* imgArr = @[@[[UIImage imageNamed:@"icon_recharge"],
                              [UIImage imageNamed:@"icon_cash"]],
                            @[[UIImage imageNamed:@"icon_incomedetails"],
                              [UIImage imageNamed:@"icon_expendituredetails"],
                              [UIImage imageNamed:@"icon_cashdetails"]]
                          ];
        
        NSMutableArray<MessageListModel *>* firstArr = @[].mutableCopy;
        NSMutableArray<MessageListModel *>* secArr = @[].mutableCopy;

        for (int i = 0; i < titleArr.count; i++) {
            
            
            for (int j = 0; j < titleArr[i].count; j ++) {
                
                MessageListModel* model = [[MessageListModel alloc] init];
                model.image = imgArr[i][j];
                model.title = titleArr[i][j];
                
                if (i == 0) {
                    
                    [firstArr addObject:model];

                }else{
                    
                    [secArr addObject:model];

                }
               
            }
            
        }
        
        [_listArray addObject:firstArr];
        [_listArray addObject:secArr];

    }
    
    return _listArray;
    
}
@end
