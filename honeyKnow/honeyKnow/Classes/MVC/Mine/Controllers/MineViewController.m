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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBaseInfo{
    
    [self addTableViewWithFrame:CGRectMake(0, - NewStatusBarHeight, SCREEN_WIDTH,SCREEN_HEIGHT)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[MineListCell class] forCellReuseIdentifier:mineListCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MinePersonInfoCell class]) bundle:nil] forCellReuseIdentifier:minePersonInfoCellId];

    
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
        return cell;
        
        
    }else{
        
        MineListCell * cell = [tableView dequeueReusableCellWithIdentifier:mineListCellId forIndexPath:indexPath];
        cell.listArray = self.listArray;
        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {

        return 242 + NewStatusBarHeight + 36;
        
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
@end
