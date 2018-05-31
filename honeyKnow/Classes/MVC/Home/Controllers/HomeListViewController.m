//
//  HomeListViewController.m
//  honeyKnow
//
//  Created by 魏太山 on 2018/5/17.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "HomeListViewController.h"
#import "HomeListModel.h"
#import "HomeListCell.h"
#import "HomeDetailsViewController.h"
@interface HomeListViewController ()
@property (nonatomic, assign) NSInteger currentPage;//记录当前页

@property (nonatomic, strong) NSMutableArray<HomeList *>* listArray;

@property (nonatomic, strong) HomeListModel* listModel;

@property (nonatomic, copy) NSString* url;

@end

static NSString * const homeListCellId = @"homeListCellId";

@implementation HomeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setBaseUI];
    [self FirstRefreshing];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBaseUI{
    
    self.navigationController.navigationBarHidden = YES;
    
    [self addTableViewWithFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT - NewStatusBarHeight - 44)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorFromHexString:@"#eeeeee"];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeListCell class]) bundle:nil] forCellReuseIdentifier:homeListCellId];
    
}

- (void)FirstRefreshing{
    
    __weak typeof(self) weakSelf = self;
    // 设置刷新，header和footer同时只能一个生效
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.currentPage = 1;
        [self getHomeListData];
        // 禁用footer
        weakSelf.tableView.mj_footer.hidden = YES;
    }];
    
    weakSelf.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (weakSelf.currentPage >= weakSelf.listModel.pageNum) {
            
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            
            return ;
        }
        weakSelf.currentPage++;
        [self getHomeListData];
        
    }];
    // 第一次加载数据
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer.automaticallyHidden = YES;
    
}


- (void)getHomeListData{
    
    if (self.type == ActorListTypeFocus) {
        
        self.url = [NSString stringWithFormat:@"%@?pageIndex=%ld&pageSize=20",URL_HOME_ACTOR_FOCUS_LIST,self.currentPage];
    }else if (self.type == ActorListTypeRecommend){
        
        self.url = [NSString stringWithFormat:@"%@?pageIndex=%ld&pageSize=20",URL_HOME_ACTOR_RECOMMEND_LIST,self.currentPage];

    }else{
        
        self.url = [NSString stringWithFormat:@"%@?pageIndex=%ld&pageSize=20&star=%ld",URL_HOME_ACTOR_STAR_LIST,self.currentPage,self.star];

    }
    
    WeakSelf;
    
    [WTSHttpTool requestWihtMethod:RequestMethodTypeGet url:self.url params:nil success:^(id response) {
       
        
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        if ([response[@"success"] integerValue]){
            
            HomeListModel* model = [HomeListModel yy_modelWithJSON:response[@"data"]];
            
            if (model) {
                
                if (weakSelf.currentPage == 1) {
                    // 移除所有数据
                    [weakSelf.listArray removeAllObjects];
                }
                
                if (model.list.count > 0) {
                    
                    
                    self.listModel = model;
                    // 将新请求的数据添加到数据源中
                    [weakSelf.listArray addObjectsFromArray:self.listModel.list];
                    
                    
                    // 判断数据是否加载完了
                    if (weakSelf.listArray.count >= model.total) {
                        // 表示没有数据可以请求，设置UITableView footer的状态
                        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                        weakSelf.tableView.mj_footer.hidden = YES;
                        weakSelf.tableView.mj_header.hidden = NO;
                        
                        
                    }else {
                        // 重置提示没有更多数据
                        [weakSelf.tableView.mj_footer resetNoMoreData];
                        weakSelf.tableView.mj_footer.hidden = YES;
                        weakSelf.tableView.mj_header.hidden = NO;
                        
                    }
                    
                    
                }else{
                    
                    // 重置提示没有更多数据
                    [weakSelf.tableView.mj_footer resetNoMoreData];
                    weakSelf.tableView.mj_footer.hidden = YES;
                    weakSelf.tableView.mj_header.hidden = NO;
                    
                }
                
                
            }else{
                
                
                if (weakSelf.currentPage > 1) {
                    
                    weakSelf.currentPage --;
                    
                }
                
                weakSelf.tableView.mj_footer.hidden = YES;
            }

        } else {
            
            
            if (weakSelf.currentPage > 1) {
                
                weakSelf.currentPage --;
                
            }
            
            weakSelf.tableView.mj_footer.hidden = YES;
            
        }
        
        [self.tableView reloadData];

        
    } failure:^(NSError *error) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        if (weakSelf.currentPage > 1) {
            
            weakSelf.currentPage --;
            
        }
        
        weakSelf.tableView.mj_footer.hidden = YES;

        [self.tableView reloadData];

    }];
    
}


#pragma mark - UITableViewDelegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.listArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;

    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HomeListCell * cell = [tableView dequeueReusableCellWithIdentifier:homeListCellId forIndexPath:indexPath];
    
    HomeList* model = self.listArray[indexPath.section];

    cell.model = model;
    
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 375;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 6;
    
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorFromHexString:@"#eeeeee"];
    
    
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeList* model = self.listArray[indexPath.section];

    HomeDetailsViewController* vc = [MAIN_SB instantiateViewControllerWithIdentifier:@"homeDetailsViewController"];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userId = model.Id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 懒加载
-(NSMutableArray<HomeList *> *)listArray{
    
    if (!_listArray) {
        
        _listArray = @[].mutableCopy;
        
    }
    
    return _listArray;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"暂无主播哦~";
    
    NSDictionary *attributes = @{NSFontAttributeName: FontTextTwo,
                                 NSForegroundColorAttributeName: kNormalTextTwoColor};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


@end
