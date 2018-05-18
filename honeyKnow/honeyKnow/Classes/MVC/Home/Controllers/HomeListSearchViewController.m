//
//  HomeListSearchViewController.m
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "HomeListSearchViewController.h"
#import "HomeListModel.h"
#import "HomeListSerachCell.h"
#import "SearchTextField.h"


@interface HomeListSearchViewController ()

@property (nonatomic, assign) NSInteger currentPage;//记录当前页

@property (nonatomic, strong) NSMutableArray<HomeList *>* listArray;

@property (nonatomic, strong) HomeListModel* listModel;

@end

static NSString * const homeListSerachCellId = @"homeListSerachCellId";

@implementation HomeListSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTableViewWithFrame:CGRectMake(0,StatusBarAndNavigationBarHeight, SCREEN_WIDTH,SCREEN_HEIGHT - StatusBarAndNavigationBarHeight)];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 0);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeListSerachCell class]) bundle:nil] forCellReuseIdentifier:homeListSerachCellId];
}


/** 根据昵称搜索用户 */
- (void)getListSearchActorNameData{
    
    WeakSelf;
    [WTSHttpTool requestWihtMethod:RequestMethodTypeGet url:[NSString stringWithFormat:@"%@?nickName=%@",URL_HOME_SEARCH_ACTOR_BY_NICKNAME,self.keyWord] params:nil success:^(id response) {

        if ([response[@"success"] integerValue]){

            
            weakSelf.listModel = [HomeListModel yy_modelWithJSON:response];
            [weakSelf.listArray removeAllObjects];
            [weakSelf.listArray addObjectsFromArray:weakSelf.listModel.data];
            

        }
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {

        
    }];

    
}
#pragma mark - UITableViewDelegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HomeListSerachCell * cell = [tableView dequeueReusableCellWithIdentifier:homeListSerachCellId forIndexPath:indexPath];
    HomeList* model = self.listArray[indexPath.row];
    cell.model = model;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    
    return CGFLOAT_MIN;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 8;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorFromHexString:@"#eeeeee"];
    
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
}

#pragma mark - textField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    self.keyWord = textField.text;
    [textField resignFirstResponder];
    
    if (self.keyWord.length != 0) {
        
        [self getAllSearchDataWithSearchText:self.keyWord];
        
    }else{
        
        [self.listArray removeAllObjects];
        [self.tableView reloadData];
    }
    
    return YES;
}



- (void)textFieldEditChanged:(UITextField *)textField{
    
    self.keyWord = textField.text;
    if (self.keyWord.length != 0) {
        
        [self getAllSearchDataWithSearchText:self.keyWord];
        
    }else{
        
        [self.listArray removeAllObjects];
        [self.tableView reloadData];
        
    }
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchText resignFirstResponder];
}
-(void)getAllSearchDataWithSearchText:(NSString *)keyword{
    
    [self getListSearchActorNameData];
}

#pragma mark - 懒加载
-(NSMutableArray<HomeList *> *)listArray{
    
    if (!_listArray) {
        
        _listArray = @[].mutableCopy;
    }
    
    return _listArray;
}



@end

