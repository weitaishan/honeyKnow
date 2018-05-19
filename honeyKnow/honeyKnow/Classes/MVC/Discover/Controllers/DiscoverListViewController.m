//
//  DiscoverListViewController.m
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/18.
//  Copyright © 2018年 AlbertWei. All rights reserved.
//

#import "DiscoverListViewController.h"
#import "DiscoverViewController.h"
#import "DiscoverListCell.h"
#import "DiscoverListModel.h"
#import "VideoViewController.h"
@interface DiscoverListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) NSMutableArray<DiscoverList *>* listArray;
@property (nonatomic, copy) NSString* url;

@end

static NSString* discoverListCellId = @"discoverListCellId";

@implementation DiscoverListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setBaseInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    
}
- (void)getDiscoverInfoData{
    
    
    if (self.type == DiscoverListTypeHot) {
        
        self.url = URL_VIDEO_HOT_LIST;
    }else if (self.type == DiscoverListTypeNew){
        
        self.url = URL_VIDEO_NEW_LIST;

    }else{
        
        self.url = URL_VIDEO_FOCUS_LIST;

    }
    
    WeakSelf;
    [WTSHttpTool requestWihtMethod:RequestMethodTypeGet url:self.url params:nil success:^(id response) {
        
        [weakSelf.collectionView.mj_header endRefreshing];

        if ([response[@"success"] integerValue]){
            
            
            DiscoverListModel* listModel = [DiscoverListModel yy_modelWithJSON:response];
            [weakSelf.listArray removeAllObjects];
            [weakSelf.listArray addObjectsFromArray:listModel.data];
            
            
        }
        
        [weakSelf.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
        [weakSelf.collectionView.mj_header endRefreshing];

    }];
    
}

- (void)setBaseInfo{
    
    self.navigationController.navigationBarHidden = YES;
    
    //    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //    flowLayout.headerReferenceSize = CGSizeMake(0,  10);
    flowLayout.minimumInteritemSpacing = 0;//列距
    flowLayout.minimumLineSpacing = 1;
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarAndNavigationBarHeight) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled = YES;
    
    _collectionView.allowsMultipleSelection = YES;
    [self.view addSubview:_collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DiscoverListCell class]) bundle:nil] forCellWithReuseIdentifier:discoverListCellId];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getDiscoverInfoData];
        // 禁用footer
        self.collectionView.mj_footer.hidden = YES;
    }];
    
    // 马上进入刷新状态
    [self.collectionView.mj_header beginRefreshing];
    
}


#pragma mark - UICollectionViewDelegate/DataSource/FlowLayout
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArray.count;
    
}
//元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = SCREEN_WIDTH / 2.f - 1;
    
    return CGSizeMake( width,  276.f / 187 * ((SCREEN_WIDTH - 1) / 2.f));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(1, 0, 0, 0);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DiscoverListCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:discoverListCellId forIndexPath:indexPath];
    
    cell.model = self.listArray[indexPath.row];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoViewController*  vc = [[VideoViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.listArray = self.listArray;
    vc.index = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 懒加载
-(NSMutableArray<DiscoverList *> *)listArray{
    
    if (!_listArray) {
        
        _listArray = @[].mutableCopy;
        
    }
    
    return _listArray;
}


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"暂无视频哦~";
    
    NSDictionary *attributes = @{NSFontAttributeName: FontTextTwo,
                                 NSForegroundColorAttributeName: kNormalTextTwoColor};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
@end

